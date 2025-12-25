class axi4lite_stress_test extends axi4lite_test;

  `uvm_component_utils(axi4lite_stress_test)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
   
    axi4lite_sequence::type_id::set_type_override(axi4lite_high_addr_sequence::get_type());

    super.build_phase(phase); 
  endfunction

endclass