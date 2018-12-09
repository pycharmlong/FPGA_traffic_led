module traffic_led(rst_n,clk,r1,g1,y1,r2,g2,y2);//c5,c25,c30分别是三个定时器的输出标志位,en分别是三个定时器的使能位
	
	input rst_n,clk;
	wire c5,c25,c30;
	
	reg [2:0] en;
	output reg r1,g1,y1,r2,g2,y2;  //输出端口能和输入端口链接吗？
	
	reg [3:0] current_state,next_state;
	
	localparam 
		s0 = 4'b0001,
		s1 = 4'b0010,
		s2 = 4'b0100,
		s3 = 4'b1000;
	
	clock_5 u0(
		.clk(clk),
		.rst_n(rst_n),
		.en5(en[0]),
		.c5(c5)
	);
	
	clock_25 u1(
		.clk(clk),
		.rst_n(rst_n),
		.en25(en[1]),
		.c25(c25)
	);
	
	clock_30 u2(
		.clk(clk),
		.rst_n(rst_n),
		.en30(en[2]),
		.c30(c30)
	);

	
	
	always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				current_state <= s0;
			end
		else
			current_state <= next_state;	
	end
	
	always@(*)
	begin
			case(current_state)
				s0:begin  //甲通行乙禁止
						en <= 3'b100;
						r1 <= 1'b0; r2 <= 1'b1;
						g1 <= 1'b1; g2 <= 1'b0;
						y1 <= 1'b0; y2 <= 1'b0;
						if(c30 == 1)
							next_state <= s1;
						else
							next_state <= s0;
					end
				s1:begin  //甲暂停乙禁止
						en <= 3'b001;
						r1 <= 1'b0; r2 <= 1'b1;
						g1 <= 1'b0; g2 <= 1'b0;
						y1 <= 1'b1; y2 <= 1'b0;
						if(c5 == 1)
							next_state <= s2;
						else	
							next_state <= s1;					
					end
				s2:begin  //甲禁止乙通行
						en <= 3'b010;
						r1 <= 1'b1; r2 <= 1'b0;
						g1 <= 1'b0; g2 <= 1'b1;
						y1 <= 1'b0; y2 <= 1'b0;
						if(c25 == 1)
							next_state <= s3;
						else
							next_state <= s2;				
					end
				s3:begin  //甲禁止乙暂停
						en <= 3'b001;
						r1 <= 1'b1; r2 <= 1'b0;
						g1 <= 1'b0; g2 <= 1'b0;
						y1 <= 1'b0; y2 <= 1'b1;
						if(c5 == 1)
							next_state <= s0;
						else
							next_state <= s3;
					end
				default: next_state <= s0;
			endcase
	end
endmodule
