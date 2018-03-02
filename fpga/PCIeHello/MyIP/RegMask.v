module RegMask 
	#(
		parameter B = 32
	)
	(
		input wire clk,
		input wire reset_n,
		input wire write_n,
		input wire address,
		input wire[B-1:0] writedata,
		output wire[B-1:0] readdata,
		
		output wire[B-1:0] reg_data
	);

	reg[B-1:0] regmask;
	
always @(posedge clk or negedge reset_n)
begin
	if(reset_n == 0) 
		regmask <= 0;
	else if(~write_n && address == 0)
		regmask <= writedata;
end

assign readdata = regmask;
assign reg_data = readdata;

endmodule