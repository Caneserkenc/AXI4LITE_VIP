
interface axi4lite_if #(parameter ADDRESS = 32, parameter DATA_WIDTH = 32) 
(input logic ACLK, input logic ARESETN);
  

    import uvm_pkg::*;          
    `include "uvm_macros.svh"  


     logic [ADDRESS-1:0]    S_ARADDR;
     logic                  S_ARVALID;
     logic                  S_RREADY;
     logic [ADDRESS-1:0]    S_AWADDR;
     logic                  S_AWVALID;
     logic [DATA_WIDTH-1:0] S_WDATA;
     logic [3:0]            S_WSTRB;
     logic                  S_WVALID;
     logic                  S_BREADY;	
     logic                  S_ARREADY;
     logic[DATA_WIDTH-1:0]  S_RDATA;
     logic  [1:0]           S_RRESP;
     logic                  S_RVALID;
     logic                  S_AWREADY;
     logic                  S_WREADY;
     logic [1:0]            S_BRESP;
     logic                  S_BVALID;


  // SVA: AXI4-Lite Protocol Checks

  // 1. KURAL: VALID kararlılığı
  // Master (Driver) AWVALID=1 yaptıysa, Ready gelene kadar 0'a düşemez.
  property p_awvalid_stable;
    @(posedge ACLK) disable iff (!ARESETN)
    (S_AWVALID && !S_AWREADY ) |=> S_AWVALID;
  endproperty

  ASSERT_AWVALID_STABLE: assert property (p_awvalid_stable)
    else `uvm_error("SVA", "PROTOCOL ERROR: AWVALID dropped before Ready arrived!");

  // 2. KURAL: X/Z Kontrolü (Bilinmeyen Sinyal)
  // Reset yokken, Adres hattında X veya Z olmamalı.
  property p_addr_known;
    @(posedge ACLK) disable iff (!ARESETN)
    S_AWVALID |-> !$isunknown(S_AWADDR);
  endproperty

  ASSERT_ADDR_KNOWN: assert property (p_addr_known)
    else `uvm_error("SVA", "SIGNAL ERROR: There is an X or Z on the address line!");

endinterface