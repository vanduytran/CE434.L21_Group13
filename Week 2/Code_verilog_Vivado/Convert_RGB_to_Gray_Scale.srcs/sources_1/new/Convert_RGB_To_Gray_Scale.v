`timescale 1ns / 1ps

module Convert_RGB_To_Gray_Scale
#(
    parameter IMAGE_HEIGHT = 5,
    parameter IMAGE_WIDTH = 5,
    parameter TOTAL_NUMBER_CONVERT = IMAGE_HEIGHT * IMAGE_WIDTH,
    parameter DATA_COLOR_WIDTH = 8,
    parameter DATA_IN_WIDTH = DATA_COLOR_WIDTH * 3,
    parameter FIXED_POINT_WIDTH = 32,
    parameter POINT_POSITION = FIXED_POINT_WIDTH / 2,
    parameter ADRR_WIDTH_BRAM = 6,
    parameter LINK_BRAM_READ = "",
    parameter LINK_BRAM_WRITE = ""
)
(
    input en, reset_n, clk,
    input [FIXED_POINT_WIDTH - 1 : 0] scale_red, scale_green, scale_blue,
    
    output [DATA_IN_WIDTH - 1 : 0] out_1_bram_read,
    output [DATA_COLOR_WIDTH - 1 : 0] out_0_bram_write, out_1_bram_write
);
    wire [DATA_IN_WIDTH - 1 : 0] in0_bram_read, in1_bram_read;
    wire [ADRR_WIDTH_BRAM - 1 : 0] addr0_bram_read, addr1_bram_read;
    wire ena_bram_read, enb_bram_read;  
    wire we_a_bram_read, we_b_bram_read;
    
    wire [DATA_COLOR_WIDTH - 1 : 0] in1_bram_write;
    wire [ADRR_WIDTH_BRAM - 1 : 0] addr0_bram_write, addr1_bram_write;
    wire ena_bram_write, enb_bram_write;
    wire we_a_bram_write, we_b_bram_write;
    
    wire [FIXED_POINT_WIDTH - 1 : 0] scale_red_data_path, scale_green_data_path, scale_blue_data_path;
    wire en_calculate;

    Controller
    #(
        .IMAGE_HEIGHT(IMAGE_HEIGHT),
        .IMAGE_WIDTH(IMAGE_WIDTH),
        .TOTAL_NUMBER_CONVERT(TOTAL_NUMBER_CONVERT),
        .DATA_COLOR_WIDTH(DATA_COLOR_WIDTH),
        .DATA_IN_WIDTH(DATA_IN_WIDTH),
        .FIXED_POINT_WIDTH(FIXED_POINT_WIDTH),
        .ADRR_WIDTH_BRAM(ADRR_WIDTH_BRAM)
    )
    ins0
    (
        .en(en), .reset_n(reset_n), .clk(clk),
        .scale_red(scale_red), .scale_green(scale_green), .scale_blue(scale_blue),
        
        .in0_bram_read(in0_bram_read), .in1_bram_read(in1_bram_read),
        .addr0_bram_read(addr0_bram_read), .addr1_bram_read(addr1_bram_read),
        .ena_bram_read(ena_bram_read), .enb_bram_read(enb_bram_read),  
        .we_a_bram_read(we_a_bram_read), .we_b_bram_read(we_b_bram_read),
        
        .in1_bram_write(in1_bram_write),
        .addr0_bram_write(addr0_bram_write), .addr1_bram_write(addr1_bram_write),
        .ena_bram_write(ena_bram_write), .enb_bram_write(enb_bram_write),
        .we_a_bram_write(we_a_bram_write), .we_b_bram_write(we_b_bram_write),
        
        .scale_red_data_path(scale_red_data_path), .scale_green_data_path(scale_green_data_path), .scale_blue_data_path(scale_blue_data_path),
        .en_calculate(en_calculate)
    );
    
    Data_Path
    #(
        .DATA_COLOR_WIDTH(DATA_COLOR_WIDTH),
        .DATA_IN_WIDTH(DATA_IN_WIDTH),
        .FIXED_POINT_WIDTH(FIXED_POINT_WIDTH),
        .POINT_POSITION(POINT_POSITION),
        .LINK_BRAM_READ(LINK_BRAM_READ),
        .LINK_BRAM_WRITE(LINK_BRAM_WRITE),
        .ADRR_WIDTH_BRAM(ADRR_WIDTH_BRAM)
    )
    ins1
    (
        .in0_bram_read(in0_bram_read), .in1_bram_read(in1_bram_read),
        .addr0_bram_read(addr0_bram_read), .addr1_bram_read(addr1_bram_read),
        .ena_bram_read(ena_bram_read), .enb_bram_read(enb_bram_read),  
        .we_a_bram_read(we_a_bram_read), .we_b_bram_read(we_b_bram_read),
        .out_1_bram_read(out_1_bram_read),
        
        .in1_bram_write(in1_bram_write),
        .addr0_bram_write(addr0_bram_write), .addr1_bram_write(addr1_bram_write),
        .ena_bram_write(ena_bram_write), .enb_bram_write(enb_bram_write),
        .we_a_bram_write(we_a_bram_write), .we_b_bram_write(we_b_bram_write),
        .out_0_bram_write(out_0_bram_write), .out_1_bram_write(out_1_bram_write),
        
        .scale_red(scale_red_data_path), .scale_green(scale_green_data_path), .scale_blue(scale_blue_data_path),
        .en_calculate(en_calculate),
        .clk(clk)
    );
    
endmodule
