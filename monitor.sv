class f_mon extends uvm_monitor;
  `uvm_component_utils(f_mon)
  function new(string name = "f_mon", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  item i;
  
  virtual f_in inf;
  uvm_analysis_port#(item) mon_ana;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db #(virtual f_in)::get(this,"","inf",inf)))
       `uvm_fatal("MONITOR",$sformatf("NOT GET CONFIG"))
      
       i = item::type_id::create("i");
       
       mon_ana = new("mon_ana",this);
       
    
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
     // $display("inside monitor");
      @(posedge inf.clk) 
        if(inf.wr_en ) begin
       i.wr_en = inf.wr_en;
         // i.rd_en = inf.wr_en;
        i.data_in = inf.data_in;
           i.full = inf.full;
          `uvm_info("[MONITOR]",$sformatf("MON WRITE wr_en = %d data_in =  %d full = %d", i.wr_en, i.data_in,i.full),UVM_MEDIUM)
           mon_ana.write(i);
      end
       else if(inf.rd_en) begin
       //   @(posedge inf.clk)
          i.rd_en = inf.rd_en;
            i.wr_en = inf.wr_en;  
          i.data_out = inf.data_out ;
         // i.full = inf.full;
          i.empty = inf.empty;
          `uvm_info("[MONITOR]",$sformatf("MON READ rd_en = %d data_out =  %d  full = %d empty = %d", i.rd_en, i.data_out, i.full,i.empty),UVM_LOW)
          mon_ana.write(i);
        end
    end
  endtask 
endclass
       
