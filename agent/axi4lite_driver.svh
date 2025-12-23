class axi4lite_driver extends uvm_driver#(axi4lite_seq_item);

   `uvm_component_utils(axi4lite_driver)
   
    virtual axi4lite_if vif;

    function new (string name, uvm_component parent);
      super.new(name, parent);
    endfunction 

    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual axi4lite_if)::get(this, "", "vif", vif))
        `uvm_fatal("NOVIF", "Virtual interface not found in config_db");
    endfunction 
    

    virtual task run_phase(uvm_phase phase);
      axi4lite_seq_item seq;
      forever begin 
         seq_item_port.get_next_item(seq);
         drive_transfer(seq);
         seq_item_port.item_done();
      end 
    endtask

    task drive_transfer(axi4lite_seq_item seq);

       wait(vif.ARESETN == 1);

       // WRITE
       if(seq.is_write == 1) begin 
           @(posedge vif.ACLK);
  
           vif.S_AWADDR  <= seq.addr;
           vif.S_AWVALID <= 1'b1;
           vif.S_WDATA   <= seq.data;
           vif.S_WSTRB   <= seq.strb;
           vif.S_WVALID  <= 1'b1;      
           
           // Cevap 
           vif.S_BREADY  <= 1'b1;
           
           // Handshake bekle
           do begin
              @(posedge vif.ACLK);
           end while (vif.S_AWREADY === 0 || vif.S_WREADY === 0);
           
           // Temizlik 
           vif.S_AWVALID <= 1'b0;
           vif.S_WVALID  <= 1'b0;     
           vif.S_AWADDR  <= 0;
           vif.S_WDATA   <= 0;
           
           // Cevap bekle
           do begin 
              @(posedge vif.ACLK);
           end while (vif.S_BVALID === 0); 
           
           vif.S_BREADY <= 1'b0;
       end 
    
       // READ
       else begin 
        @(posedge vif.ACLK);
        vif.S_ARADDR  <= seq.addr;
        vif.S_ARVALID <= 1'b1;
        do begin 
            @(posedge vif.ACLK);
        end while (vif.S_ARREADY === 0); 
        vif.S_ARVALID <= 1'b0;
        vif.S_ARADDR  <= 0;
        vif.S_RREADY  <= 1'b1;
        do begin
            @(posedge vif.ACLK);
        end while(vif.S_RVALID === 0);
        seq.rdata = vif.S_RDATA;
        seq.resp  = vif.S_RRESP;
        vif.S_RREADY <= 1'b0;
       end 

     endtask 
   
endclass