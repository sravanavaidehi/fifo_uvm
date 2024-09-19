`include "uvm_macros.svh"
`include "test.svh"
//`include "fi_pack.svh"

module tb;
  
  import uvm_pkg::*;
 //   import fi_pack::*;
      
    bit clk;
 bit rst;
  
  f_in inf(.clk(clk),.rst(rst));
  
  fifo f1(.clk(clk),.rst(inf.rst),.wr_en(inf.wr_en),.rd_en(inf.rd_en),.data_in(inf.data_in),.data_out(inf.data_out),.full(inf.full),.empty(inf.empty));
  
  
  initial begin
    
    uvm_config_db #(virtual f_in) :: set(null,"*","f_in",inf);
    run_test("test");
    
  end
  always #10 clk = ~clk;
  initial begin
    clk = 0;rst = 0;
    
    #10;
    rst =1;
    #10;
    rst=0;
    rst=0;
    
    
  end
   initial begin 
    $dumpfile("dumb.vcd");
   $dumpvars;
  end
  
endmodule
    
    
