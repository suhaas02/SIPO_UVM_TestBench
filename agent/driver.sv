class driver extends uvm_driver #(transaction); 
	`uvm_component_utils(driver)
	tb_config tb_cfg;
	virtual sipo_if.drv_mp vif;  
	function new(string name = "driver", uvm_component parent); 
		super.new(name, parent); 
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
		begin 
			//req = transaction::type_id::create("req"); 
			seq_item_port.get_next_item(req); 
			//vif.drv_cb.
			send_to_dut(req); 
			seq_item_port.item_done();
		end 
	endtask 

	task send_to_dut(transaction req); 
		@(vif.drv_cb); 
		
		vif.drv_cb.din <= req.din; 
		vif.drv_cb.rst <= req.rst;
	//	vif.drv_cb.load <= req.load; 
		
	//	@(vif.drv_cb); 
		`uvm_info(get_type_name, $sformatf("Printing from driver: %s", req.sprint()), UVM_LOW)
	endtask
endclass
