`timescale 1ns / 1ps

module TestBench_Calculate_Result();
    parameter DATA_COLOR_WIDTH = 8;
    parameter DATA_IN_WIDTH = DATA_COLOR_WIDTH * 3;
    parameter FIXED_POINT_WIDTH = 32;
    parameter POINT_POSITION = FIXED_POINT_WIDTH / 2;
    parameter t = 20;
    
    reg [DATA_IN_WIDTH - 1 : 0] data_in;
    reg [FIXED_POINT_WIDTH - 1 : 0] scale_red, scale_green, scale_blue;
    reg en;
    reg clk;
    wire [DATA_COLOR_WIDTH - 1 : 0] data_out;
    
    initial begin
        #(100);
            clk = 0;
            en = 0;
            data_in = 0;
            scale_red = 0;
            scale_green = 0;
            scale_blue = 0;
        #(t/2);
            en = 1;
            data_in = 592645; // 9->11->5
            scale_red = 32768; //  = 0.5
            scale_green = 16384; // = 0.25
            scale_blue = 163840; // = 1.25
        #(t/2);
        #(t*2);
            data_in = 985775; // 15->10->175
        #(t*6);
            $stop;
    end
    
    always @(clk) begin
        #t;
        clk <= ~clk;
    end
    
    Calculate_Result
    #(
        .DATA_COLOR_WIDTH(DATA_COLOR_WIDTH),
        .DATA_IN_WIDTH(DATA_IN_WIDTH),
        .FIXED_POINT_WIDTH(FIXED_POINT_WIDTH),
        .POINT_POSITION(POINT_POSITION)
    )
    ins0
    (
        .data_in(data_in),
        .scale_red(scale_red), .scale_green(scale_green), .scale_blue(scale_blue),
        .en(en),
        .clk(clk),
        .data_out(data_out)
    );

endmodule
