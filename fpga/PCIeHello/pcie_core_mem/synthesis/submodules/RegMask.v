module RegMask 
	(
		input wire clk,
		input wire reset_n,
		input wire write_n,
		input wire address,
		input wire[31:0] writedata,
		output wire[31:0] readdata,
		
		output wire[31:0] reg_data
	);

	reg[31:0] regmask;
	
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