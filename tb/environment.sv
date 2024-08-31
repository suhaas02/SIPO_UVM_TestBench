class environment extends uvm_env; 
	`uvm_component_utils(environment)
	agent agth; 
	scoreboard sbh; 	
	function new(string name = "environment", uvm_component parent); 
		super.new(name, parent); 
	endfunction 

	function void build_phase(uvm_phase phase); 
		super.build_phase(phase); 
		agth = agent::type_id::create("agth", this);
		sbh = scoreboard::type_id::create("sbh", this);  
	endfunction 

	function void connect_phase(uvm_phase phase); 
		agth.monh.anys_port.connect(sbh.fifoh.analysis_export); 
	endfunction 

endclass
