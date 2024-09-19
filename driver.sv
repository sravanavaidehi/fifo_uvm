`include "sequence.svh"

class driver extends uvm_driver#(item);
  `uvm_component_utils(driver)
  function new(string name = "driver", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  item i;
  virtual f_in inf;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!(uvm_config_db #(virtual f_in) ::get(this,"","inf",inf)))
      `uvm_fatal("[DRIVER]",$sformatf("VIRTUAL INTERFACE NOT GET "))
      
      i = item::type_id::create("i");
    
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    fork 
    forever begin
      
      if(inf.rst)
      reset();
      else
     drive();
      
    end
    join
    endtask 
  task reset();
   
        inf.wr_en = 0;
        inf.rd_en = 0;
        inf.data_in = 0;
        `uvm_info("[DRIVER]",$sformatf("item getting randomised in RESET  wr_en = %d  data_in = %d ", inf.wr_en,inf.data_in),UVM_MEDIUM)
      
      
   
    
  endtask
  
  task drive();
    
    seq_item_port.get_next_item(i);
    get_drive(i);
  seq_item_port.item_done();
  endtask
  
    task get_drive(item i);
      @(posedge inf.clk)
      if(i.wr_en) begin 
        @(posedge inf.clk)
        inf.wr_en = i.wr_en;
        inf.data_in = i.data_in;
        @(posedge inf.clk)
        inf.wr_en = 0;
        
        `uvm_info("[DRIVER]",$sformatf("item getting randomised in WRITE wr_en = %d  data_in = %d full = %d ", inf.wr_en,inf.data_in,inf.full),UVM_MEDIUM)
      end
      else if(i.rd_en & !i.empty) begin 
        
        inf.rd_en = i.rd_en;
        @(posedge inf.clk)
        inf.rd_en = 0;
        `uvm_info("[DRIVER]",$sformatf("item getting randomised  READ rd_en = %d data_out= %d  empty = %d wr_en = %d rd_en = %d ", inf.rd_en,inf.data_out,inf.empty,inf.wr_en,inf.rd_en),UVM_MEDIUM)
      end
      
      else 
        $display("in 1 in enables");
      
      
 //  end
   //   end
      
    endtask
 
endclass

        
     
      
      
      
