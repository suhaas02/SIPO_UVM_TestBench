class test extends uvm_test; 
	`uvm_component_utils(test)
	environment envh; 
	tb_config tb_cfg; 
	virtual sipo_if vif; 
	seqs seqh; 
	function new(string name = "test", uvm_component parent); 
		super.new(name, parent); 
	endfunction 

	function void build_phase(uvm_phase phase); 
		super.build_phase(phase); 
		tb_cfg = tb_config::type_id::create("tb_cfg"); 
		uvm_config_db #(virtual sipo_if)::get(this, "", "sipo_if", tb_cfg.vif); 
		
		uvm_config_db #(tb_config)::set(this, "*", "tb_config", tb_cfg); 
		envh = environment::type_id::create("envh", this); 
	endfunction

	task run_phase(uvm_phase phase); 
		phase.raise_objection(this); 
		seqh = seqs::type_id::create("seqh");
		seqh.start(envh.agth.seqrh); 
		#30; 
		phase.drop_objection(this); 
	endtask 
endclass
