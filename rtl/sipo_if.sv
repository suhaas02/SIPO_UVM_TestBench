interface sipo_if(input bit clock); 
	bit din; 
	bit rst;
	bit [3:0] q; 
//	bit load; 
//	bit [3:0] qn; 

	clocking drv_cb@(posedge clock); 
		default input #1 output #0;
		output din, rst;
	//	input q;  
	endclocking

	clocking mon_cb@(posedge clock); 
		default input #1 output #0; 
		input q; 
		
	endclocking

	modport drv_mp(clocking drv_cb); 
	modport mon_mp(clocking mon_cb); 

endinterface 
