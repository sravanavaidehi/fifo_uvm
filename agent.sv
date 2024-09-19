class f_agent extends uvm_agent;
  `uvm_component_utils(f_agent)
  function new(string name = "f_agent", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  f_sqr sq;
  driver dri;
  f_mon mon;
 
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    sq = f_sqr::type_id::create("sq",this);
    dri = driver::type_id::create("dri",this);
    mon = f_mon::type_id::create("mon",this);
    
    
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    dri.seq_item_port.connect(sq.seq_item_export);
  endfunction
  
endclass
