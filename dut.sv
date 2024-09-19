// Code your design here
// Code your design here
// Code your testbench here
// or browse Examples

`include "uvm_macros.svh"
module fifo(input clk,
            rst,
            wr_en,rd_en,
            [2:0]data_in,
            output reg [2:0]data_out,
           output full,
           empty);
  
  import uvm_pkg::*;
  reg [3:0]wr_pt=0;
  reg [3:0]rd_pt=0;
  reg [2:0] fi[7:0];
  
  assign full = (wr_pt == 4'b1000) ? 1 : 0;
  assign empty = (rd_pt == wr_pt) ? 1: 0;
  
  always @(posedge clk) begin
    
    if(rst)
      begin
        $display("inside reset");
        fi[0]<=0; fi[1]<= 0 ;fi[2]<=0;  
        data_out <= 0; wr_pt <=0; rd_pt<=0;
      end
    else begin
      //$display("inside else");
      if(wr_en & !full)
         begin
           $display("inside write in dut wr_pt =%0d ",wr_pt);
           fi[wr_pt] = data_in;
           wr_pt     = wr_pt+1;
           $display(" inside [%0t] data_in= %d,fi=%p wr_pt = %d full=%0d",$time,data_in,fi,wr_pt,full);
           
         end
      else if (rd_en & !empty)
      begin
      // $display("inside read");
      data_out = fi[rd_pt];
      
          rd_pt    = rd_pt +1;
        $display("data_out= %d,fi=%p  rd_pt = %d",data_out,fi,rd_pt);
       
    end
      
    
  end
     
  if(full && empty)begin
    wr_pt =0;
  	rd_pt =0;
 //   full=0;
   // empty=0;
  end
    
  end
  
 
  
endmodule
      
      
      
interface f_in(input bit clk,rst);
  
  logic wr_en,rd_en;
  logic [2:0]data_in;
  logic [2:0]data_out;
  logic  full,empty;
  
  /*clocking f_cb @(posedge clk);
    default input #1 output #0;
    */
endinterface
      
      
