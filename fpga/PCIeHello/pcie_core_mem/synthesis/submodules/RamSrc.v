module RamSrc
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
	input wire oe,
	input wire [W-1:0] rd_addr,
	output wire [B-1:0] rd_data
	
);

	// Declare the RAM variable
	reg [B-1:0] ram[2**W-1:0];
	// Variable to hold the registered read address
	reg [W-1:0] address_reg;
	
	reg [W-1:0] rd_addr_reg;
	
	always @ (posedge clk)
	begin
		address_reg <= address;
		rd_addr_reg <= {B{1'b0}};
		if(~write_n)
			ram[address] <= writedata;
		else if(oe)
			rd_addr_reg <= rd_addr;
	end
	
	assign readdata = ram[address_reg];
	assign rd_data = ram[rd_addr_reg];
	
endmodule
