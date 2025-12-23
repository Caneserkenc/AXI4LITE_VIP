class axi4lite_seq_item extends uvm_sequence_item;

   `uvm_object_utils(axi4lite_seq_item)

    rand bit [31:0] addr;  // read or write hedef adres 
    rand bit [31:0] data;  //read or write yazılacak data 
    rand bit [3:0]  strb;
    rand bit        is_write;  //read mi write mi?
    rand int        delay;
         bit [1:0]  resp;  //işlem sonucu BRESP veya RRESP
         bit [31:0] rdata;  //read data için

    function new (string name = "axi4lite_seq_item");
     super.new(name);
    endfunction

endclass 

