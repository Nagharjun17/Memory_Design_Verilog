`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.09.2020 15:57:07
// Design Name: 
// Module Name: memory_tb
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


module memory_tb();

parameter addr_width = 16;
parameter data_width = 32;
integer count;
reg cs, clk, reset, re, we;
reg [addr_width - 1 : 0] addr;
reg [data_width - 1 : 0] data_in;
wire [data_width - 1 : 0] data_out;

memory memory_inst(addr, cs, re, we, clk, reset, data_in, data_out);

initial begin
    clk = 0;
    reset = 0;
end

always #5 clk = ~clk;

initial begin
    for(count = 0; count < 'h10; count = count + 1) begin
        write_task(count);
        read_task(count);
    end
    $finish;
end

initial
$monitor($time," addr = &h data_in = %h, data_out = %h", addr, data_in, data_out);

initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
end

task write_task;
input [addr_width - 1 : 0] addr_in;
begin
    @(posedge clk);
    cs = 1; we = 1; re = 0; //data_in = $random;
    data_in = $random;
    addr = addr_in;
    @(posedge clk)
    we = 0; 
end
endtask

task read_task;
input [addr_width - 1 : 0] addr_in;
begin
    @(posedge clk);
    cs = 1; we = 0; re = 1; //data_in = $random;
    addr = addr_in;
    @(posedge clk)
    re = 0; 
end
endtask

endmodule
