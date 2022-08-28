
//include ur design
module testbench_add2;

//Data type declaration
reg [3:0] a, b;
reg clk = 0;
reg rst = 0;
wire [3:0] sum;
wire ov;
wire [4:0] res;
//module instantiation
add2 DUT(a, b, sum, overflow); //呼叫 module name 為 add2 的檔案 (add_2.v)

//初始化
initial begin
	clk <= 0;
	rst <= 0;
	a <= 4'b0000; 
	b <= 4'b0000;
	//印出結果
    $monitor("%4dns a=%d b=%d res=%d ", $stime, a, b, res);
end

always@(posedge clk or negedge rst)
begin
    if(a <= 15) begin 
		a <= a + 1;
	end 
	if(a == 15) begin
		b <= b + 1;
	end
	
end

assign res = {overflow, sum};
always #0.1 clk = ~clk;
always #0.1 rst = ~rst;

endmodule




