module clock_5(clk,rst_n,en5,c5);

	input clk,rst_n,en5;
	
	output reg c5;
	
	reg [17:0] cnt5;
	
	
	//5ms = 5_000us = 5_000_000ns/20 = 250_000 = 18bit
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				cnt5 <= 18'd0;//
				c5 <= 1'b0;
			end
		else if(en5 == 1'b1)
			begin
				if(cnt5 == 18'd249_999)//249_999
					begin
						cnt5 <= 18'd0;//
						c5 <= 1'b1;
					end
				else
					begin
						cnt5 <= cnt5 + 1'b1;
						c5 <= 1'b0;
					end
			end	
		else
			cnt5 <= 18'd0;
	end
endmodule