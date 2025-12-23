class axi4lite_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(axi4lite_scoreboard)

   uvm_analysis_imp #(axi4lite_seq_item, axi4lite_scoreboard) analysis_export;

   bit [31:0] scb_mem[int];

   int match_count    = 0;
   int mismatch_count = 0;


  function new (string name, uvm_component parent);
    super.new(name, parent);
    analysis_export = new("analysis_export",this);
  endfunction

  function void write(axi4lite_seq_item seq);
    if(seq.is_write) begin 
        scb_mem[seq.addr] = seq.data;  //seq.addr(bulunduğu sıra) seq_data(o sıranın içine yazılan veri)
    end else begin 
        if(scb_mem.exists(seq.addr)) begin 
          if(scb_mem[seq.addr] == seq.rdata) begin 
            `uvm_info("SCB", "verification successfull", UVM_HIGH)
            match_count++;
          end else begin 
            `uvm_error( "SCB", "data miscatch!")
            mismatch_count++;
          end
        end else begin 
          `uvm_error("SCB","Reading was done from an address that was not written.")  
           mismatch_count++;
        end 
    end 
  endfunction 


  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
  
    $display("matches : %0d", match_count);
    $display("mismatches : %0d", mismatch_count);
  
    if(mismatch_count == 0 && match_count > 0)
       $display("             TEST PASSED");
    else
       $display( "            TEST FAILED");

  endfunction 
endclass 