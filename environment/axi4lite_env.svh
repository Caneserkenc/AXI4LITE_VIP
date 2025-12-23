class axi4lite_env extends uvm_env;

   `uvm_component_utils(axi4lite_env)

    axi4lite_agent      agent;
    axi4lite_scoreboard scoreboard;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

     agent      = axi4lite_agent::type_id::create("agent",this);
     scoreboard = axi4lite_scoreboard::type_id::create("scoreboard", this);

    endfunction 

    virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      agent.monitor.item_collected_port.connect(scoreboard.analysis_export);
    endfunction 

    


endclass 
