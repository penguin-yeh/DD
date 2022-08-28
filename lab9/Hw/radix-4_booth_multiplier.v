//以前者(1ns)為單位，以後者(1ps)的時間，查看一次電路的行為
`timescale 1ns/1ps

//宣告module名稱,輸出入名稱
module lab9_hw(
	CLK, 
	RST, 
	in_a, 
	in_b, 
	Product, 
	Product_Valid
);
// in_a * in_b = Product
// in_a is Multiplicand , in_b is Multiplier
					
//定義port, 包含input, output
input 			CLK, RST;
input 	[7:0]	in_a;			// Multiplicand(8 bit)
input 	[7:0]	in_b;			// Multiplier(8 bit)
output 	[15:0]  Product;        // 16 bit
output  		Product_Valid;

reg 	[7:0]	Mplicand;		//被乘數(8 bit 前面補0)
reg 	[7:0]	Mplier;			//乘數(8 bit)
reg 	[15:0]	Product;        //16 bit
reg 			Product_Valid;
reg 	[5:0]	Counter ;
reg				sign;			//正負號判斷 (signed)
reg     [16:0] temp_product;
reg     [7:0]  temp;
reg     [8:0]  temp2;
reg     ov;

//Counter
always @(posedge CLK or posedge RST)
begin
	if(RST)
		Counter <= 6'b0;
	else
		Counter <= Counter + 6'b1;

end

//Product
always @(posedge CLK or posedge RST)
begin
	//初始化數值
	if(RST) begin
		temp_product  <= 17'b0;
		Product <= 16'b0;
		Mplicand <= 8'b0;
		Mplier   <= 8'b0;	
		ov <= 1'b0;	
	end 
	//輸入乘數與被乘數
	else if(Counter == 6'd0) begin
		temp_product <= {8'b0,in_b,1'b0};
		Product     <= 16'b0;
		Mplicand 	<= in_a;
		Mplier	 	<= in_b;	
		ov <= 1'b0;	
	end 
	//乘法與數值移位
	else if(Counter <=6'd4) 
	begin
		if(temp_product[2:0] == 3'b001 || temp_product[2:0] == 3'b010) 
			if(ov == 0)
				temp_product = temp_product + {Mplicand,9'b0};
			else
				{ov, temp_product} = {ov, temp_product} + {Mplicand,9'b0}; 

		else if(temp_product[2:0] == 3'b101 || temp_product[2:0] == 3'b110)begin
				temp = ~Mplicand + 1;
			if(ov == 0)
				temp_product = temp_product + {temp,9'b0};
			else 
				{ov, temp_product} = {ov, temp_product} + {temp,9'b0}; 
		end

		else if(temp_product[2:0] == 3'b011)begin
			temp = Mplicand + Mplicand;
			if(temp[7] == 1)begin
				temp2 = ~{1'b0,temp} + 1;
				{ov, temp_product} = temp_product + {temp2,9'b0};
			end
			else begin
				temp = ~temp + 1;
				{ov, temp_product} = temp_product + {temp,9'b0};
			end
		end

		else if(temp_product[2:0] == 3'b100)begin
			temp = Mplicand + Mplicand;
			if(temp[7] == 1)begin
				temp2 = ~{1'b0,temp} + 1;
				{ov, temp_product} = temp_product + {temp2,9'b0};
			end
			else begin
				temp = ~temp + 1;
				{ov, temp_product} = temp_product + {temp,9'b0};
			end
		end

                if(temp_product[16] == 1 || ov == 1)begin
			temp_product = temp_product >> 2'b10;//shift right 2 bit
			temp_product[16] = 1;
			temp_product[15] = 1;
		end

		else			
			temp_product = temp_product >> 2'b10;//shift right 2 bit

		Product = temp_product[16:1];
		// $display ("//////////");
		// $display ("product is %b\n",{ov, temp_product});
		//Mplicand 	<= Mplicand << 1'b1;//shift left
		//Mplier 		<= Mplier >> 1'b1;//shift right
		
	end 
	else begin
		temp_product 	<= temp_product;
		Product     <= Product;
		Mplicand	<= Mplicand;
		Mplier 		<= Mplier;
	end
end

//Product_Valid
always @(posedge CLK or posedge RST)
begin
	if(RST)
		Product_Valid <=1'b0;
	else if(Counter==6'd5)
		Product_Valid <=1'b1;
	else
		Product_Valid <=1'b0;
end

endmodule
