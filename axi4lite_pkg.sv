package axi4lite_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // Temel 
    `include "agent/axi4lite_seq_item.svh"
    
    // Test bunu kullanacağı için önce gelmeli
    `include "sequences/axi4lite_sequence.svh" 

    //  Agent Bileşenleri
    `include "agent/axi4lite_driver.svh"
    `include "agent/axi4lite_monitor.svh"
    `include "agent/axi4lite_coverage.svh"
    `include "agent/axi4lite_agent.svh"

    // Scoreboard
    `include "scoreboard/axi4lite_scoreboard.svh"

    //  Env
    `include "environment/axi4lite_env.svh"

    //  EN SON TEST Her şeyi kullandığı için en son
    `include "tests/axi4lite_test.svh"

endpackage