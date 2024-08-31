module top; 
	import uvm_pkg::*; 
	`include "uvm_macros.svh"; 

	bit clock; 
	always #10 clock = ~clock; 
	sipo_if if0(clock); 
	sipo DUV(clock, if0.rst, if0.din, if0.q); 
	initial 
		begin 
			`ifdef VCS
			$fsdbDumpvars(0, top);
			`endif
			uvm_config_db #(virtual sipo_if)::set(null, "*", "sipo_if", if0);
			uvm_top.enable_print_topology = 1;  
			run_test("test"); 
		end 
endmodule 
