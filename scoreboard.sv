class f_sc extends uvm_scoreboard;
  `uvm_component_utils(f_sc)
  function new(string name = "f_sc", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
 uvm_analysis_imp #(item,f_sc) sc_ana;
  bit [2:0]fifo[$];
//  bit [2:0]wr_pt,rd_pt;
  item i;
  bit  [2:0] check;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    sc_ana = new("sc_ana",this);
  endfunction
  
  virtual function write(item i);
    
    if(i.wr_en & !i.full ) begin
     
      fifo.push_front(i.data_in);
      
      `uvm_info(get_type_name(),$sformatf("[[[WRITE]]] fifo = %p full=%d",fifo,i.full),UVM_MEDIUM)
      end
  
    else if(i.rd_en & !i.empty ) begin
      
      if(fifo.size() >=1)begin
      check = fifo.pop_back();;
      if(i.data_out == check)
        `uvm_info(get_type_name(),$sformatf("DATA IS EQUALL check = %d data_out = %d fifo = %p",check,i.data_out,fifo),UVM_MEDIUM)
        else
          `uvm_info("[SCOREBOARD]",$sformatf("DATA IS NOT EQUAL check = %d data_out = %d fifo = %p ",check,i.data_out,fifo),UVM_MEDIUM)
          end
    
          end
    else 
     
        
      `uvm_info(get_type_name(),$sformatf("Fifo is full or empty"),UVM_MEDIUM)
          
      endfunction
endclass
