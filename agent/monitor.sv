class monitor extends uvm_monitor; 
	`uvm_component_utils(monitor)
	tb_config tb_cfg;
	virtual sipo_if.mon_mp vif; 
	uvm_analysis_port #(transaction) anys_port; 
	function new(string name = "monitor", uvm_component parent); 
		super.new(name, parent); 
		anys_port = new("anys_port", this); 
	endfunction 

	function void build_phase(uvm_phase phase); 
		super.build_phase(phase); 
		uvm_config_db #(tb_config)::get(this, "", "tb_config", tb_cfg); 
	endfunction 
	
	function void connect_phase(uvm_phase phase); 
		vif = tb_cfg.vif; 
	endfunction 

	task run_phase(uvm_phase phase); 
		forever 
			collect_data(); 
	endtask

	task collect_data(); 
		transaction xtn; 
		
		@(vif.mon_cb); 
		
		xtn = transaction::type_id::create("xtn"); 
		xtn.q = vif.mon_cb.q; 
	//	xtn.qn = vif.mon_cb.qn;
		`uvm_info(get_type_name, $sformatf("Printing from monitor: %s", xtn.sprint()), UVM_LOW)
		anys_port.write(xtn); 
	//	@(vif.mon_cb); 
		
	endtask
endclass

