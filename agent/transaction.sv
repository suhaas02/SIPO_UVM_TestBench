class transaction extends uvm_sequence_item; 

	//`uvm_object_utils(transaction)

	function new(string name = "transaction");
		super.new(name); 
	endfunction

	rand bit din; 
	rand bit rst;
//	rand bit load;  
	bit [3:0] q; 
//	bit [3:0] qn; 
	constraint range {rst dist {0:=10, 1:=1};
			  din dist {0:= 5, 1:= 5};}
	`uvm_object_utils_begin(transaction)
		`uvm_field_int(din, UVM_ALL_ON +UVM_BIN)
		`uvm_field_int(q, UVM_ALL_ON +UVM_BIN)
		`uvm_field_int(rst, UVM_ALL_ON)
	//	`uvm_field_int(load, UVM_ALL_ON)
	`uvm_object_utils_end

endclass
