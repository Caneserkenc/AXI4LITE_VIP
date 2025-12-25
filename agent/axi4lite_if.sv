interface axi4lite_if #(parameter ADDRESS = 32, parameter DATA_WIDTH = 32) 
(input logic ACLK, input logic ARESETN);
  
    import uvm_pkg::*;          
    `include "uvm_macros.svh"  

    logic [ADDRESS-1:0]    S_AWADDR;
    logic                  S_AWVALID;
    logic                  S_AWREADY;
    logic [DATA_WIDTH-1:0] S_WDATA;
    logic [3:0]            S_WSTRB;
    logic                  S_WVALID;
    logic                  S_WREADY;

    logic [1:0]            S_BRESP;
    logic                  S_BVALID;
    logic                  S_BREADY; 

    logic [ADDRESS-1:0]    S_ARADDR;
    logic                  S_ARVALID;
    logic                  S_ARREADY;

    logic [DATA_WIDTH-1:0] S_RDATA;
    logic [1:0]            S_RRESP;
    logic                  S_RVALID;
    logic                  S_RREADY;


    // SYSTEMVERILOG ASSERTIONS (SVA) - Protocol Checkers
    //  Handshake Stability
    // Once VALID is asserted, it must remain asserted until READY is high.
    property p_awvalid_stable;
       @(posedge ACLK) disable iff (!ARESETN)
       (S_AWVALID && !S_AWREADY) |=> S_AWVALID;
    endproperty

    ASSERT_AWVALID_STABLE: assert property (p_awvalid_stable)
       else `uvm_error("SVA", "PROTOCOL VIOLATION: AWVALID dropped before AWREADY asserted!");

    // RULE 2: Unknown State Check (X/Z Propagation)
    // When VALID is high, Address must not be X or Z.
    property p_addr_known;
       @(posedge ACLK) disable iff (!ARESETN)
       S_AWVALID |-> !$isunknown(S_AWADDR);
    endproperty

    ASSERT_ADDR_KNOWN: assert property (p_addr_known)
       else `uvm_error("SVA", "SIGNAL INTEGRITY: Unknown value (X/Z) detected on AWADDR while VALID is high!");

endinterface