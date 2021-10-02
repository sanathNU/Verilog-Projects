`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2017 01:36:42 PM
// Design Name: 
// Module Name: TOP
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TOP(
    input clk, 
    input reset, btnCnt,
    output [15:0] LED,
    output [6:0] segment,
    output dp,
    output [3:0] digit
    );
    
    //
    // look at the counter input (btnCnt).  use that to make a 1-shot 
    // use a longer period clock than 10ns for the 1-shot just to get rid
    // of "bouncing"
    //
    reg [19:0] clock_count;
    always @ (posedge clk) 
        if (reset) clock_count <= 0;
        else clock_count <= clock_count + 1;
    reg [15:0] the_count;
    reg [3:0] the_count_d0;
    reg [3:0] the_count_d1;
    reg [3:0] the_count_d2;
    reg [3:0] the_count_d3;
    wire [15:0] count_d = {the_count_d3,the_count_d2,the_count_d1,the_count_d0};
    wire slow_clk = clock_count[14];
    reg trigger;
    always @ (posedge slow_clk) trigger <= btnCnt;
    //
    // now count "triggers"
    always @ (posedge trigger or posedge reset)
        if (reset) begin
            the_count <= 0;
            the_count_d0 <= 0;
            the_count_d1 <= 0;
            the_count_d2 <= 0;
            the_count_d3 <= 0;
            end
        else begin
            //
            // check each digit of the_count decimal parts
            //
            if ( the_count_d0 == 'h9 ) begin
                the_count_d0 <= 0;
                if ( the_count_d1 == 'h9 ) begin
                    the_count_d1 <= 0;
                    if ( the_count_d2 == 'h9 ) begin
                        the_count_d2 <= 0;
                        if ( the_count_d3 == 'h9 ) the_count_d3 <= 0;
                        else the_count_d3 <= the_count_d3 + 1;
                    end
                    else the_count_d2 <= the_count_d2 + 1;
                end
                else the_count_d1 <= the_count_d1 + 1;
            end
            else the_count_d0 <= the_count_d0 + 1;
            
            the_count <= the_count + 1;
        end
    wire [3:0] which_digit;
    wire [6:0] dnumber;
    wire period;
    display4 DISPLAY (
        .clk100(clk),
        .digit(which_digit),
        .segments(dnumber),
        .period(period),
        .number(count_d));
//        .number(the_count));

    assign LED = the_count;
    assign dp = 1;
    assign segment = dnumber;
    assign digit = which_digit;
    
endmodule
