`timescale 1ns / 1ps

module TestBench_Calculate_Result();
    parameter IMAGE_HEIGHT = 120;
    parameter IMAGE_WIDTH = 50;
    parameter TOTAL_NUMBER_CONVERT = IMAGE_HEIGHT * IMAGE_WIDTH;
    parameter DATA_COLOR_WIDTH = 8;
    parameter DATA_IN_WIDTH = DATA_COLOR_WIDTH * 3;
    parameter FIXED_POINT_WIDTH = 32;
    parameter POINT_POSITION = FIXED_POINT_WIDTH / 2;
    parameter ADRR_WIDTH_BRAM = 13;
    //parameter LINK_BRAM_READ = "E:\\Hoc_Tap\\Nam_3_Ki_2\\Chuyen_De_Thiet_Ke_Vi_Mach_1\\Exercises\\Week_2\\Convert_RGB_to_Gray_Scale\\Convert_RGB_to_Gray_Scale.srcs\\sources_1\\new\\original_image.txt";
    //parameter LINK_BRAM_WRITE = "E:\\Hoc_Tap\\Nam_3_Ki_2\\Chuyen_De_Thiet_Ke_Vi_Mach_1\\Exercises\\Week_2\\Convert_RGB_to_Gray_Scale\\Convert_RGB_to_Gray_Scale.srcs\\sources_1\\new\\converted_image.txt";
    parameter LINK_BRAM_READ = "E:\\Hoc_Tap\\Nam_3_Ki_2\\Chuyen_De_Thiet_Ke_Vi_Mach_1\\Exercises\\Week_2\\original_image.txt";
    parameter LINK_BRAM_WRITE = "E:\\Hoc_Tap\\Nam_3_Ki_2\\Chuyen_De_Thiet_Ke_Vi_Mach_1\\Exercises\\Week_2\\converted_image.txt";
    parameter t = 20;
    
    reg en, reset_n, clk;
    reg [FIXED_POINT_WIDTH - 1 : 0] scale_red, scale_green, scale_blue;
    
    wire [DATA_IN_WIDTH - 1 : 0] out_1_bram_read;
    wire [DATA_COLOR_WIDTH - 1 : 0] out_0_bram_write, out_1_bram_write;
    
    initial begin
        #(100);
            clk = 0;
            en = 0;
            reset_n = 0;
            scale_red = 0;
            scale_green = 0;
            scale_blue = 0;
        #(t/2);
            en = 1;
            reset_n = 1;
            scale_red = 16384; //  = 0.25
            scale_green = 16384; // = 0.25
            scale_blue = 16384; // = 0.25
        #(t/2);
        #(t*70);
            $stop;
    end
    
    always @(clk) begin
        #t;
        clk <= ~clk;
    end
    
    Convert_RGB_To_Gray_Scale
    #(
        .IMAGE_HEIGHT(IMAGE_HEIGHT),
        .IMAGE_WIDTH(IMAGE_WIDTH),
        .TOTAL_NUMBER_CONVERT(TOTAL_NUMBER_CONVERT),
        .DATA_COLOR_WIDTH(DATA_COLOR_WIDTH),
        .DATA_IN_WIDTH(DATA_IN_WIDTH),
        .FIXED_POINT_WIDTH(FIXED_POINT_WIDTH),
        .POINT_POSITION(POINT_POSITION),
        .ADRR_WIDTH_BRAM(ADRR_WIDTH_BRAM),
        .LINK_BRAM_READ(LINK_BRAM_READ),
        .LINK_BRAM_WRITE(LINK_BRAM_WRITE)
    )
    ins0
    (
        .en(en), .reset_n(reset_n), .clk(clk),
        .scale_red(scale_red), .scale_green(scale_green), .scale_blue(scale_blue),
        
        .out_1_bram_read(out_1_bram_read),
        .out_0_bram_write(out_0_bram_write), .out_1_bram_write(out_1_bram_write)
    );

endmodule
