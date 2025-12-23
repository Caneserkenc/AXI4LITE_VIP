class axi4lite_agent extends uvm_agent;

  `uvm_component_utils(axi4lite_agent)

  uvm_sequencer #(axi4lite_seq_item) sequencer; //yeni bir sequencer dosyası oluşturmamak için bu şekilde kullan(standart uvm sequencer)
  axi4lite_driver driver;
  axi4lite_monitor monitor;


  function new(string name, uvm_component parent);
   super.new(name, parent);
  endfunction 

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

      monitor = axi4lite_monitor::type_id::create("monitor",this);
  
      if(get_is_active() == UVM_ACTIVE) begin 
          driver    = axi4lite_driver::type_id::create("driver", this);
          sequencer = uvm_sequencer#(axi4lite_seq_item)::type_id::create("sequencer", this);
      end
  endfunction 

  virtual function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     if(get_is_active()== UVM_ACTIVE) begin
       driver.seq_item_port.connect(sequencer.seq_item_export);
     end
  
  endfunction 


endclass 
