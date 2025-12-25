package axi4lite_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    //seq_item
    `include "agent/axi4lite_seq_item.svh"

    //sequences
    `include "sequences/axi4lite_sequence.svh" 
    `include "sequences/axi4lite_high_addr_sequence.svh"

    //  Agent bileşenleri
    `include "agent/axi4lite_driver.svh"
    `include "agent/axi4lite_monitor.svh"
    `include "agent/axi4lite_coverage.svh"
    `include "agent/axi4lite_agent.svh"

    // scoreboard
    `include "scoreboard/axi4lite_scoreboard.svh"

    //  env
    `include "environment/axi4lite_env.svh"

    // test
    `include "tests/axi4lite_test.svh"
    `include "tests/axi4lite_stress_test.svh"

endpackage