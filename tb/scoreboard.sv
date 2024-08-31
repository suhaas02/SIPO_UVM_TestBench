class scoreboard extends uvm_scoreboard; 
	`uvm_component_utils(scoreboard)
	uvm_tlm_analysis_fifo #(transaction) fifoh;  
	transaction xtn, xtn_ref; 
	function new(string name = "scoreboard", uvm_component parent); 
		super.new(name, parent); 
		fifoh = new("fifoh", this); 
		packet = new; 
	endfunction 

	covergroup packet;
		data_in : coverpoint xtn.din; 
		rst_sig: coverpoint xtn.rst;
		data_out : coverpoint xtn.q {
			bins one = {[0:3]};
			bins two = {[4:7]}; 
			bins three = {[8:11]}; 
			bins four = {[12:15]};} 	
	endgroup 

	task run_phase(uvm_phase phase);
		forever begin  
		fifoh.get(xtn); 
		assert($cast(xtn_ref, xtn.clone())); 
		data_out_ref(xtn_ref); 
		check_data(xtn, xtn_ref); 
		packet.sample(); 
		end
	
	endtask 

	task data_out_ref(ref transaction xtn); 
		if(xtn.rst)
			xtn.q = 4'b0; 
		else 
			xtn.q = {xtn.din, xtn.q[3:1]}; 
	endtask 
	
	task check_data(transaction xtn_ref, transaction xtn); 
		if(xtn.compare(xtn_ref))
			`uvm_info(get_type_name, "Packet successfully compared", UVM_LOW)
	endtask 
	
	
endclass
