module RamDes
#(
	parameter B = 32,
	parameter W = 10
)
(
	input wire clk,
	input wire reset_n,
	input wire write_n,
	input wire [B-1:0] writedata,
	input wire [W-1:0] address,
	output wire [B-1:0] readdata,
	
	//external user ip 
	input wire we,
	input wire [W-1:0] wr_addr,
	input wire [B-1:0] wr_data
	
);

	// Declare the RAM variable
	reg [B-1:0] ram[2**W-1:0];
	// Variable to hold the registered read address
	reg [W-1:0] address_reg;
	
	always @ (posedge clk)
	begin
		address_reg <= address;
		if(~write_n)
			ram[address] <= writedata;
		else if(we)
			ram[wr_addr] <= wr_data;
	end
	
	assign readdata = ram[address_reg];
	
endmodule
