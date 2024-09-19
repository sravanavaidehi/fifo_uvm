class coverage extends uvm_subscriber #(item);
  `uvm_component_utils(coverage)
  
  item i;
  virtual f_in inf;
  
  real cov,cov2;
  
  covergroup cg_wr(input string comment);
    
    option.per_instance = 1;
    
   
    cg_wr_en:coverpoint i.wr_en{
      bins f = {1};
      bins w = {0};
      
    }
    cg_data_in : coverpoint i.data_in iff(i.wr_en){
      bins a = {1};
      bins b = {2};
      bins c[] = {[4:7]}; 
      bins k = {3};  
    }
    
    cg_rd_en :coverpoint i.rd_en;
    
    cg_data_out: coverpoint i.data_out iff(i.rd_en);
    
    cr: cross cg_wr_en,cg_data_in {
      
      bins q = binsof(cg_wr_en) && binsof(cg_data_in);
    }
    
    cr2 : cross cg_rd_en,cg_data_in{
      bins e = binsof(cg_rd_en) intersect{1} && binsof(cg_data_in);
    }
      
      
   option.cross_num_print_missing=1;
  
    option.comment = comment;
  endgroup
  
 
  
  extern function new(string name = "coverage" ,uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void write(item i);

        
endclass
        
    function coverage::new(string name="coverage",uvm_component parent = null);
      super.new(name,parent);
      cg_wr= new("Covergroup");
      
    endfunction
    
     function void coverage::build_phase(uvm_phase phase);
      super.build_phase(phase);
      
       if(!(uvm_config_db #(virtual f_in)::get(this,"","inf",inf)))
         `uvm_fatal("cov",$sformatf("NOT GET CONFIG"))
      
        
         i= new();
     endfunction
         
         function void coverage::write(item i);
           this.i = i;
           cg_wr.sample();
         
           cov = cg_wr.get_coverage(); 
           `uvm_info("[COVERGAE]", $sformatf("coverage is = %f", cov), UVM_MEDIUM)
            $display("overall coverage = %0f", $get_coverage());
  
           $display("coverage of coverpoint CP1 = %0f", cg_wr.cg_data_in.get_coverage());
          
         endfunction
       
         
         
         
