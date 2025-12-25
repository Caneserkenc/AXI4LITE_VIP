class axi4lite_stress_test extends axi4lite_test;

  `uvm_component_utils(axi4lite_stress_test)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    axi4lite_high_addr_sequence seq; 

    phase.raise_objection(this);
    
    `uvm_info("TEST", "STRESS TEST (HIGH ADDR)STARTING!", UVM_LOW)

    seq = axi4lite_high_addr_sequence::type_id::create("seq");
    
    if(env == null || env.agent == null || env.agent.sequencer == null) begin
       `uvm_fatal("TEST", " Sequencer not found.")
    end
    
    seq.start(env.agent.sequencer);

    phase.drop_objection(this);
  endtask

endclass