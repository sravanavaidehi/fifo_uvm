class item extends uvm_sequence_item;
  
 // rand bit rst;
  rand bit wr_en;
  rand bit rd_en;
  randc bit [2:0]data_in;
  bit [2:0]data_out;
  bit full,empty;
  
  `uvm_object_utils_begin(item)
  	//`uvm_field_int(rst,UVM_DEFAULT)
  	`uvm_field_int(wr_en,UVM_ALL_ON)
  	`uvm_field_int(rd_en,UVM_ALL_ON)
  	`uvm_field_int(data_in,UVM_ALL_ON)
  	`uvm_field_int(data_out,UVM_ALL_ON)
  	`uvm_field_int(full,UVM_ALL_ON)
  	`uvm_field_int(empty,UVM_ALL_ON)
  `uvm_object_utils_end
  
 // constraint k {rst dist {1:=20,0:=80};}
  constraint j {wr_en != rd_en ;}
  function new(string name = "item");
    super.new(name);
  endfunction
  
endclass
