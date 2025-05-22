`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.02.2019 17:25:12
// Design Name: 
// Module Name: Weight_Memory
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
`include "include.v"

module Weight_Memory #(parameter numWeight = 3, neuronNo=5,layerNo=1,addressWidth=10,dataWidth=16,weightFile="w_1_15.mif") 
    ( 
    input clk,
    input wen,
    input ren,
    input [addressWidth-1:0] wadd,
    input [addressWidth-1:0] radd,
    input [dataWidth-1:0] win,
    output reg [dataWidth-1:0] wout);
    
	reg [dataWidth-1:0] mem [numWeight-1:0];//memory weigth and depth fror ram

    `ifdef pretrained
        initial
		begin
			$readmemb(weightFile, mem); //when pretrained data is used
	    end
	`else
		always @(posedge clk)
		begin
			if (wen) //when write enable
			begin
				mem[wadd] <= win; //instiate the win values to the mem of ram
			end
		end 
    `endif
    
    always @(posedge clk)
    begin
	    if (ren)//read enable
        begin
		wout <= mem[radd];//read it from the memory
        end
    end 
endmodule
