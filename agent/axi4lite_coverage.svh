class axi4lite_coverage extends uvm_subscriber #(axi4lite_seq_item);

    `uvm_component_utils(axi4lite_coverage)

    axi4lite_seq_item coverage_item;

    function new(string name,uvm_component parent);
      super.new(name parent);
      cg_axi = new();
    endfunction 

    covergroup cg_axi;

    endgroup




    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

    endfunction
