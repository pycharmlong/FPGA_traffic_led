module clock_25(clk,rst_n,en25,c25);

	input clk,rst_n,en25;
	
	output reg c25;
	
	reg [20:0] cnt25;
	
	
	//25ms = 25_000us = 25_000_000ns/20 = 1250_000 = 21bit
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				cnt25 <= 21'd0;//
				c25 <= 1'b0;
			end
		else if(en25 == 1'b1)
			begin
				if(cnt25 == 21'd1249_999)//1499_999_999
					begin
						cnt25 <= 21'd0;
						c25 <= 1'b1;
					end
				else
					begin
						cnt25 <= cnt25 + 1'b1;
						c25 <= 1'b0;
					end
			end	
		else
			cnt25 <= 21'd0;
	end
	
endmodule