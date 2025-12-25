class axi4lite_high_addr_sequence extends uvm_sequence #(axi4lite_seq_item);
 
    `uvm_object_utils(axi4lite_high_addr_sequence)

    function new(string name = "axi4lite_high_addr_sequence");
        super.new(name);
    endfunction 

    virtual task body();
        `uvm_info("SEQ","!!! STRESS TEST (HIGH ADDR) STARTING !!!", UVM_LOW)

        repeat(50) begin 
            req = axi4lite_seq_item::type_id::create("req");

            start_item(req);

            if(!req.randomize() with{
                addr dist{
                    0                       := 1,
                    [4 : 32'hFFFF_FFEF]     :/ 2,
                    32'hFFFF_FFF0           := 8
                };
                
                is_write dist{1 := 50, 0 := 50};
                delay inside {[0:2]};
            }) begin 
                `uvm_error("SEQ", "Randomization failed!")
            end 

            finish_item(req);
        end
        `uvm_info("SEQ", "!!! STRESS TEST FINISH !!!", UVM_LOW)
    endtask

endclass