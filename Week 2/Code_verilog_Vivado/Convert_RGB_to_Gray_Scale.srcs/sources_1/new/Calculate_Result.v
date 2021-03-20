`timescale 1ns / 1ps

module Calculate_Result
#(
    parameter DATA_COLOR_WIDTH = 8,
    parameter DATA_IN_WIDTH = DATA_COLOR_WIDTH * 3,
    parameter FIXED_POINT_WIDTH = 32,
    parameter POINT_POSITION = FIXED_POINT_WIDTH / 2
)
(
    input [DATA_IN_WIDTH - 1 : 0] data_in,
    input [FIXED_POINT_WIDTH - 1 : 0] scale_red, scale_green, scale_blue,
    input en,
    input clk,
    output [DATA_COLOR_WIDTH - 1 : 0] data_out
);
    wire [DATA_COLOR_WIDTH - 1 : 0] red, green, blue;
    reg [DATA_COLOR_WIDTH + FIXED_POINT_WIDTH - 1 : 0] post_scale_red, post_scale_green, post_scale_blue;
    reg [DATA_COLOR_WIDTH + FIXED_POINT_WIDTH + 2 - 1 : 0] data_out_temp_0, data_out_temp_1, data_out_temp_2;
    
    assign blue = data_in[DATA_IN_WIDTH - 1 -: DATA_COLOR_WIDTH];
    assign green = data_in[DATA_IN_WIDTH - DATA_COLOR_WIDTH - 1 -: DATA_COLOR_WIDTH];
    assign red = data_in[DATA_IN_WIDTH - 2 * DATA_COLOR_WIDTH - 1 : 0];
    assign data_out = data_out_temp_2[POINT_POSITION + DATA_COLOR_WIDTH - 1 : POINT_POSITION];
    
    always @(posedge clk) begin
        if(en) begin
            post_scale_red <= red * scale_red;
            post_scale_green <= green * scale_green;
            post_scale_blue <= blue * scale_blue;
            data_out_temp_0 = post_scale_red + post_scale_green + post_scale_blue;
            data_out_temp_1 = ({data_out_temp_0[DATA_COLOR_WIDTH + FIXED_POINT_WIDTH + 2 - 1 : POINT_POSITION]} > {2**DATA_COLOR_WIDTH - 1})?{(2**DATA_COLOR_WIDTH - 1) << POINT_POSITION}:data_out_temp_0;
            data_out_temp_2 = (data_out_temp_1[POINT_POSITION - 1] == 1)?{data_out_temp_1 + (1 << POINT_POSITION)}:data_out_temp_1;
        end
    end
endmodule
