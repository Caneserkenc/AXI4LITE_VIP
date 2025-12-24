class axi4lite_coverage extends uvm_subscriber #(axi4lite_seq_item);
  
  `uvm_component_utils(axi4lite_coverage)


  axi4lite_seq_item cov_item;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    // Covergroupu oluştur 
    cg_axi = new();
  endfunction

  covergroup cg_axi;
 
    cp_addr: coverpoint cov_item.addr {
      bins low_range  = {[0:16]};           
      bins mid_range  = {[17:100]};         
      bins high_range = {[32'hFFFF_FFF0:$]};
      bins others     = default; 
    }

    cp_op: coverpoint cov_item.is_write {
      bins write = {1}; 
      bins read  = {0}; 
    }

    //CROSS COVERAGE 

    cross_ops: cross cp_addr, cp_op;

  endgroup

  function void write(axi4lite_seq_item t);
    cov_item = t;
    cg_axi.sample();
  endfunction

endclass