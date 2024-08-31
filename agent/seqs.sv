class seqs extends uvm_sequence #(transaction); 
	`uvm_object_utils(seqs)

	function new(string name = "seqs"); 
		super.new(name); 	
	endfunction 

	task body(); 
		repeat(6)
			begin
				req = transaction::type_id::create("req"); 
				start_item(req); 
				assert(req.randomize());
				finish_item(req);
			end 
	endtask 
endclass
