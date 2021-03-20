`timescale 1ns / 1ps

module BRAM_Store_Data
#(
    parameter DATA_WIDTH = 4,
    parameter ADDR_WIDTH = 4,
    parameter LINK = "ram.txt"
)
(
	input [(DATA_WIDTH - 1) : 0] data_a, data_b,
	input [(ADDR_WIDTH - 1) : 0] addr_a, addr_b,
	input we_a, we_b, ena, enb, clk,
	output reg [(DATA_WIDTH - 1) : 0] q_a, q_b
);

	// Declare the RAM variable
	reg [DATA_WIDTH - 1 : 0] ram [2**ADDR_WIDTH - 1 : 0];
	
	integer file_id;
	
	always @ (posedge clk) begin
	   if(ena) begin
           if (we_a) begin
               ram[addr_a] <= data_a;
               q_a <= data_a;
           end
           else begin
               q_a <= ram[addr_a];
           end
	   end
	   
	   if(enb) begin
           if (we_b) begin
            ram[addr_b] <= data_b;
            q_b <= data_b;
           end
           else begin
               q_b <= ram[addr_b];
           end 
       end
       $writememh(LINK, ram);
	end 
endmodule