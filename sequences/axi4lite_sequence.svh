class axi4lite_sequence extends uvm_sequence #(axi4lite_seq_item);
  `uvm_object_utils(axi4lite_sequence)

  axi4lite_seq_item write_queue[$]; 

  function new(string name = "axi4lite_sequence");
    super.new(name);
  endfunction 

  virtual task body();
     axi4lite_seq_item req;
     axi4lite_seq_item saved_req;

     `uvm_info("SEQ_DEBUG", "!!! YENI RTL UYUMLU SEQUENCE CALISIYOR !!!", UVM_NONE)


     // YAZMA 

     repeat(50) begin
       req = axi4lite_seq_item::type_id::create("req");
       
       start_item(req);
       
       
       if (!req.randomize() with { 
           is_write == 1; 
           addr inside {[0:31]}; // RTL'in hafızası 32 
       }) begin 
         `uvm_error("SEQ", "Randomize hatasi (Write)!");
       end
       
       finish_item(req);

       saved_req = axi4lite_seq_item::type_id::create("saved_req");
       saved_req.addr     = req.addr;
       saved_req.data     = req.data;
       saved_req.is_write = req.is_write;
       write_queue.push_back(saved_req);
     end


     repeat(50) begin
       if (write_queue.size() == 0) break;
       saved_req = write_queue.pop_front(); 

       req = axi4lite_seq_item::type_id::create("req");
       start_item(req);
       
       if (!req.randomize() with { 
           is_write == 0; 
           addr == saved_req.addr; 
       }) begin
         `uvm_error("SEQ", "Randomize error(Read)!");
       end
       finish_item(req);
     end

  endtask 
endclass