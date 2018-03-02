module Actuator
(
	input wire clk,
	input wire reset_n,
	input wire write_n,
	input wire address,
	input wire[7:0] writedata,
	output wire[7:0] readdata,
	
	//signal to know when done
	input wire done,
	
	//signal to start OrAtom
	output reg en
	
);

reg[7:0] status;

always @(posedge clk or negedge reset_n)
begin
	if(reset_n == 0) 
		status = 0;
	else if(~write_n && address == 0)
		status = writedata;
	else if(done == 1)
		status = 0;
	else 
		status = 1;
end

assign readdata = status;

always @(*)
begin
	if(status == 1) 
		en = 1'b1;
	else 
		en = 1'b0;
end

endmodule
