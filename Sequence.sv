class f_seq extends uvm_sequence#(item);
  `uvm_object_utils(f_seq)
  
  function new(string name = "f_seq");
    super.new(name);
  endfunction
  
  virtual task pre_body();
    if(starting_phase != null)
    starting_phase.raise_objection(this);
  endtask 
  
  virtual task body();
    item i = item::type_id::create("i") ;
    
    repeat(9) begin
    
      start_item(i);
      assert(i.randomize() with {i.wr_en == 1 ;});
      `uvm_info("[SEQUENCE]",$sformatf("values [[WRITE]] wr_en = %d , rd_en = %d, data_in =%0d  ",i.wr_en,i.rd_en,i.data_in),UVM_MEDIUM)
   
      finish_item(i);
    end
    
    repeat(5) begin
      start_item(i);
      assert(i.randomize() with {i.rd_en == 1;});
      `uvm_info("[SEQUENCE]",$sformatf("values [[READ]] wr_en = %d , rd_en = %d, data_in =%0d  ",i.wr_en,i.rd_en,i.data_in),UVM_MEDIUM)
   
      finish_item(i);
      
    end
    
    repeat (8) begin
      start_item(i);
      assert(i.randomize());
      `uvm_info("[SEQUENCE]",$sformatf("values [[RAND]] wr_en = %d , rd_en = %d, data_in =%0d  ",i.wr_en,i.rd_en,i.data_in),UVM_MEDIUM)
   
      finish_item(i);
    end
    
  endtask
  
  virtual task post_body();
    if(starting_phase != null)
    starting_phase.drop_objection(this);
  endtask
endclass
