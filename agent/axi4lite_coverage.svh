class axi4lite_coverage extends uvm_subscriber #(axi4lite_seq_item);
  
  `uvm_component_utils(axi4lite_coverage)

  axi4lite_seq_item cov_item;

  covergroup cg_axi;


    //düşük adres (0-16)
    cp_addr_low: coverpoint cov_item.addr {
      bins range = {[0:16]};
    }

    //orta adres (17-100)
    cp_addr_mid: coverpoint cov_item.addr {
      bins range = {[17:100]};
    }

    //yüksek adres stress test
    cp_addr_high: coverpoint cov_item.addr {
      bins range = {[32'hFFFF_FFF0:$]};
    }

    cp_op: coverpoint cov_item.is_write {
      bins write = {1}; 
      bins read  = {0}; 
    }

  endgroup

  function new(string name, uvm_component parent);
    super.new(name, parent);
    cg_axi = new();
  endfunction

  function void write(axi4lite_seq_item t);
    cov_item = t;
    cg_axi.sample();
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    
    `uvm_info("COV_REPORT", $sformatf("--------------------------------------------------"), UVM_NONE)
    `uvm_info("COV_REPORT", $sformatf("GENERAL COVERAGE : %% %0.2f", cg_axi.get_coverage()), UVM_NONE)
    `uvm_info("COV_REPORT", $sformatf("--------------------------------------------------"), UVM_NONE)
    
    `uvm_info("COV_REPORT", $sformatf(" [0-16]   Low Range Hit : %% %0.2f", cg_axi.cp_addr_low.get_coverage()), UVM_NONE)
    `uvm_info("COV_REPORT", $sformatf(" [17-100] Mid Range Hit : %% %0.2f", cg_axi.cp_addr_mid.get_coverage()), UVM_NONE)
    `uvm_info("COV_REPORT", $sformatf(" [High]   Stress Hit    : %% %0.2f", cg_axi.cp_addr_high.get_coverage()), UVM_NONE)
    
    `uvm_info("COV_REPORT", $sformatf("--------------------------------------------------"), UVM_NONE)
  endfunction

endclass