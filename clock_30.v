module clock_30(clk,rst_n,en30,c30);

	input clk,rst_n,en30;
	
	output reg c30;
	
	reg [20:0] cnt30;
	
	
	//30ms = 30_000us = 30_000_000ns/20 = 1500_000 = 21bit
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				cnt30 <= 21'd0;//
				c30 <= 1'b0;
			end
		else if(en30 == 1'b1)
			begin
				if(cnt30 == 21'd1499_999)//1499_999_999
					begin
						cnt30 <= 21'd0;//
						c30 <= 1'b1;
					end
				else
					begin
						cnt30 <= cnt30 + 1'b1;
						c30 <= 1'b0;
					end
			end	
		else
			cnt30 <= 21'd0;
	end
	
endmodule
