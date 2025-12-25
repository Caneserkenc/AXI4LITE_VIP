class axi4lite_seq_item extends uvm_sequence_item;

   `uvm_object_utils(axi4lite_seq_item)

    rand bit [31:0] addr;  
    rand bit [31:0] data;   
    rand bit [3:0]  strb;
    rand bit        is_write; 
    rand int        delay;
         bit [1:0]  resp;  
         bit [31:0] rdata;  

    // Enforce 32-bit (4-byte) address alignment as required by the RTL/Protocol
    constraint c_align { addr[1:0] == 2'b00; } 
    function new (string name = "axi4lite_seq_item");
     super.new(name);
    endfunction

endclass 

