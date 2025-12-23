`include "uvm_macros.svh"
import uvm_pkg::*;
import axi4lite_pkg::*;

module tb_top;
  
    bit ACLK;
    bit ARESETN;

    initial begin 
        ACLK = 0; 
        forever #5
         ACLK = ~ACLK;
    end 

    initial begin 
        ARESETN = 0;
        #20 ARESETN = 1;
    end

    axi4lite_if vif(ACLK, ARESETN);

    axi4_lite_slave dut(
        .ACLK(vif.ACLK),
        .ARESETN(vif.ARESETN),
        .S_ARADDR(vif.S_ARADDR),
        .S_ARVALID(vif.S_ARVALID),
        .S_RREADY(vif.S_RREADY),
        .S_AWADDR(vif.S_AWADDR),
        .S_AWVALID(vif.S_AWVALID),
        .S_WDATA(vif.S_WDATA),
        .S_WSTRB(vif.S_WSTRB),
        .S_WVALID(vif.S_WVALID),
        .S_BREADY(vif.S_BREADY),
        .S_ARREADY(vif.S_ARREADY),
        .S_RDATA(vif.S_RDATA),
        .S_RRESP(vif.S_RRESP),
        .S_RVALID(vif.S_RVALID),
        .S_AWREADY(vif.S_AWREADY),
        .S_WREADY(vif.S_WREADY),
        .S_BRESP(vif.S_BRESP),
        .S_BVALID(vif.S_BVALID)
    );

    initial begin 

        uvm_config_db#(virtual axi4lite_if)::set(null, "*", "vif",vif);

        run_test();

    end 

endmodule
