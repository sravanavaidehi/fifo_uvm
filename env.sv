class env extends uvm_env;
  `uvm_component_utils(env)
  function new(string name = "env", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  f_agent  ag;
  f_sc sc;
  coverage c1;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    ag = f_agent::type_id::create("ag",this);
    sc = f_sc::type_id::create("sc",this);
    c1 = coverage::type_id::create("c1",this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    ag.mon.mon_ana.connect(c1.analysis_export);
    ag.mon.mon_ana.connect(sc.sc_ana );
    
  endfunction
  
endclass
