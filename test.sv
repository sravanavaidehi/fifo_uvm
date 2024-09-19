`include "env.svh"

class test extends uvm_test;
  `uvm_component_utils(test)
  function new(string name = "test", uvm_component parent= null);
    super.new(name,parent);
  endfunction
  
  env e;
  f_seq seq;
  virtual f_in inf;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!(uvm_config_db #(virtual f_in) ::get(this,"","f_in",inf)))
      `uvm_fatal("[test]",$sformatf("NOT GET"))
    
    uvm_config_db #(virtual f_in)::set(this,"e.*","inf",inf);
      
      e = env::type_id::create("e",this);
    seq = f_seq::type_id::create("seq");
    
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
  //  seq.tr.randamozise() with {;}
    seq.start(e.ag.sq);
    phase.drop_objection(this);
  endtask
endclass
