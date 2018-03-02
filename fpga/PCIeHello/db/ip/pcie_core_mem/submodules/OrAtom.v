module OrAtom 
#(
	parameter W = 10,
	parameter B = 32
)
(
	input wire clk,
	
	//connect regmask
	input wire [B-1:0] reg_data,
	
	//connect ram source
	output reg oe,
	output reg [W-1:0] rd_addr,
	input wire [B-1:0] rd_data,
	
	//connect ram destination
	output reg we,
	output reg [W-1:0] wr_addr,
	output reg [B-1:0] wr_data,
	
	//enable
	input wire en,
	
	//ready
	output reg done
);


parameter IDLE        	= 5'b00001;
parameter PREP        	= 5'b00010;
parameter WRITE     	 	= 5'b00100;
parameter IS_DONE       = 5'b01000;
parameter DONE 		  	= 5'b10000;

reg[4:0] current_state;
reg[4:0] next_state;

always @(posedge clk)
begin
    current_state <= next_state;
end

always @(posedge clk)
begin
  if (next_state == IDLE)
	 rd_addr <= 0;
  else if (next_state == IS_DONE)
	 rd_addr <= rd_addr + 1;
end

always @(posedge clk)
begin
  if (next_state == IDLE)
	 wr_addr <= 0;
  else if (next_state == IS_DONE)
	 wr_addr <= wr_addr + 1;
end

always @(posedge clk)
begin
  if (next_state == WRITE)
		wr_data <= rd_data | reg_data;
  else 
		wr_data <= 0;
end

always @(*)
begin
  case (current_state)
    IDLE: 		begin
						if (en == 1'b1)
							next_state = PREP;
						else
							next_state = IDLE;
					end
	 PREP: 			next_state = WRITE;
    WRITE:  		next_state = IS_DONE;
	 IS_DONE:   begin
						if (wr_addr == 0) 
							next_state = DONE;
						else 
							next_state = PREP;
					end
	 DONE:		begin
						if (en == 1'b0)
							next_state = IDLE;
						else
							next_state = DONE;
					end
  endcase
end

always @(posedge clk)
begin
	case (next_state) 
		PREP,
		WRITE,
		IS_DONE:	begin
						oe = 1'b1;
						we = 1'b1;
					end
		default: begin
						oe = 1'b0;
						we = 1'b0;
					end
	endcase 
end

always @(posedge clk)
begin
	if (next_state == DONE) 
		done = 1'b1;
	else 
		done = 1'b0;
end

endmodule