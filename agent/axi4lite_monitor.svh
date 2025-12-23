class axi4lite_monitor extends uvm_monitor;

  `uvm_component_utils(axi4lite_monitor)
  virtual axi4lite_if vif;

  uvm_analysis_port #(axi4lite_seq_item) item_collected_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this);
  endfunction 

  virtual function void build_phase (uvm_phase phase);
    super.build_phase(phase);
     if(!uvm_config_db#(virtual axi4lite_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual interface not found in config_db");
  endfunction

  virtual task run_phase(uvm_phase phase);
     wait(vif.ARESETN == 1);
     fork
         monitor_write();
         monitor_read();   
    join_none
  endtask 

   task monitor_write();
     axi4lite_seq_item seq;
     forever begin
        @(posedge vif.ACLK);
        if(vif.S_AWVALID && vif.S_AWREADY && vif.S_WVALID && vif.S_WREADY) begin 
           seq = axi4lite_seq_item::type_id::create("seq"); 
           seq.is_write = 1;
           seq.addr = vif.S_AWADDR;
           seq.data = vif.S_WDATA;
           seq.strb = vif.S_WSTRB;
           while(vif.S_BVALID === 0) begin 
            @(posedge vif.ACLK);
           end
           seq.resp = vif.S_BRESP;
           item_collected_port.write(seq);
           `uvm_info("MON",$sformatf("finish write : addr= %0h data= %0h resp=%0b",seq.addr, seq.data, seq.resp),UVM_HIGH)
        end  
     end 
   endtask 

   task monitor_read();
      axi4lite_seq_item seq;
      forever begin 
        @(posedge vif.ACLK);
        if(vif.S_ARVALID && vif.S_ARREADY) begin 
            seq = axi4lite_seq_item::type_id::create("seq");
            seq.is_write = 0;
            seq.addr = vif.S_ARADDR;
            while(vif.S_RVALID === 0 || vif.S_RREADY == 0) begin 
                @(posedge vif.ACLK);
            end
            
            seq.rdata = vif.S_RDATA;
            seq.resp  = vif.S_RRESP;
            item_collected_port.write(seq);
            `uvm_info( "MON", $sformatf("read done: addr=%0h data=%0h", seq.addr, seq.rdata),UVM_HIGH)
        end
     
    end 
   endtask 
endclass 

