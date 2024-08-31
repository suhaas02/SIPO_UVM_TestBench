/*module sipo(din,clock, q, qn); 
	input din, clock; 
	output reg [3:0]q, qn; 
	
	//sipo
	dff d0(din, clock, q[0], qn[0]);
	dff d1(q[0], clock, q[1], qn[1]); 
	dff d2(q[1], clock, q[2], qn[2]); 
	dff d3(q[2], clock, q[3], qn[3]); 	
endmodule */


/*
module sipo(input din, clear, clock, output [3:0] q); 
    reg [3:0] temp; 
    always@(posedge clock) 
        begin 
            if(clear)
                temp <= 0; 
            else
                temp <= {din, temp[3:1]};
        end

    assign q = temp; 
endmodule 
*/
module sipo (
    input wire clk,          
    input wire reset,        
    input wire serial_in,    
  //  input wire load,         
    output reg [3:0] parallel_out 
);

    reg [3:0] shift_reg;     
   initial parallel_out = 4'b0;  
    always @(posedge clk or posedge reset) begin
        if (reset) begin
		parallel_out <= 4'b0; 
            //shift_reg <= 4'b0; 
        end else begin
		//parallel_out <= {parallel_out[2:0], serial_in}; 
		parallel_out <= {serial_in, parallel_out[3:1]}; 
            //shift_reg <= {shift_reg[2:0], serial_in}; 
        end
    end
    /*
    always @(posedge clk) begin
        if (load) begin
            parallel_out <= shift_reg; 
        end
    end
	*/
endmodule

