`timescale 1ns/1ns
`define clock_period 20

module traffic_led_tb;

	reg clk,rst_n;
	wire r1,r2,g1,g2,y1,y2;

	traffic_led utb(
		.rst_n(rst_n),
		.clk(clk),
		.r1(r1),
		.g1(g1),
		.y1(y1),
		.r2(r2),
		.g2(g2),
		.y2(y2)
	);
	
	initial clk = 1;
	always #(`clock_period/2) clk = ~clk;
	
	initial begin
		rst_n = 1'b0;
		#(`clock_period*5+5);
		rst_n = 1'b1;
	end



endmodule
