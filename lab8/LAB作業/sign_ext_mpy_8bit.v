module MPY(clk, a, b, product);
    input clk;
    input [7:0] a, b;
    wire [7:0] ab0, ab1, ab2, ab3, ab4, ab5, ab6, ab7;
    wire [15:0] add0, add1, add2, add3, add4, add5, add6, add7;
    wire [15:0] ext0, ext1, ext2, ext3, ext4, ext5, ext6, ext7;
    wire [15:0] sum0, sum1, sum2, sum3, sum4, sum5, sum6, sum7, sum8, sum9, sum10, sum11, sum12;
    output [15:0] product;

    arrand and0(a, b[0], ab0);
    arrand and1(a, b[1], ab1);
    arrand and2(a, b[2], ab2);
    arrand and3(a, b[3], ab3);
    arrand and4(a, b[4], ab4);
    arrand and5(a, b[5], ab5);
    arrand and6(a, b[6], ab6);
    arrand and7(a, b[7], ab7);

    assign add0 = {{8{ab0[7]}}, ab0};
    assign add1 = {{7{ab1[7]}}, ab1, 1'b0};
    assign add2 = {{6{ab2[7]}}, ab2, 2'b0};
    assign add3 = {{5{ab3[7]}}, ab3, 3'b0};
    assign add4 = {{4{ab4[7]}}, ab4, 4'b0};
    assign add5 = {{3{ab5[7]}}, ab5, 5'b0};
    assign add6 = {{2{ab6[7]}}, ab6, 6'b0};
    assign add7 = {1'b0, ab7, 7'b0};
	assign ext0 = {{2{ab7[6]}}, 14'b0};
	assign ext1 = {{3{ab7[5]}}, 13'b0};
	assign ext2 = {{4{ab7[4]}}, 12'b0};
    assign ext3 = {{5{ab7[3]}}, 11'b0};
    assign ext4 = {{6{ab7[2]}}, 10'b0};
    assign ext5 = {{7{ab7[1]}}, 9'b0};
    assign ext6 = {{8{ab7[0]}}, 8'b0};
	
    adder adder1(clk,add0,add1,sum0);
    adder adder2(clk,sum0,add2,sum1);
    adder adder3(clk,sum1,add3,sum2);
    adder adder4(clk,sum2,add4,sum3);
    adder adder5(clk,sum3,add5,sum4);
    adder adder6(clk,sum4,add6,sum5);
    adder adder7(clk,sum5,add7,sum6);
    adder adder8(clk,sum6,ext0,sum7);
    adder adder9(clk,sum7,ext1,sum8);
    adder adder10(clk,sum8,ext2,sum9);
    adder adder11(clk,sum9,ext3,sum10);
    adder adder12(clk,sum10,ext4,sum11);
    adder adder13(clk,sum11,ext5,sum12);
    adder adder14(clk,sum12,ext6,product);

endmodule

module arrand(a, b, ab);
    input [7:0] a;
    input b;
    output [7:0] ab;

    assign ab[0] = a[0] & b;
    assign ab[1] = a[1] & b;
    assign ab[2] = a[2] & b;
    assign ab[3] = a[3] & b;
    assign ab[4] = a[4] & b;
    assign ab[5] = a[5] & b;
    assign ab[6] = a[6] & b;
    assign ab[7] = a[7] & b;

endmodule

module adder(clk, a, b, sum);
    input clk;
    input [15:0] a, b;
    output [15:0] sum;
    wire [15:0]c;
    
    HA HA1(clk, a[0], b[0], sum[0], c[0]);
    FA FA1(clk, a[1], b[1], c[0], sum[1], c[1]);
    FA FA2(clk, a[2], b[2], c[1], sum[2], c[2]);
    FA FA3(clk, a[3], b[3], c[2], sum[3], c[3]);
    FA FA4(clk, a[4], b[4], c[3], sum[4], c[4]);
    FA FA5(clk, a[5], b[5], c[4], sum[5], c[5]);
    FA FA6(clk, a[6], b[6], c[5], sum[6], c[6]);
    FA FA7(clk, a[7], b[7], c[6], sum[7], c[7]); 
    FA FA8(clk, a[8], b[8], c[7], sum[8], c[8]);
    FA FA9(clk, a[9], b[9], c[8], sum[9], c[9]);
    FA FA10(clk, a[10], b[10], c[9], sum[10], c[10]);
    FA FA11(clk, a[11], b[11], c[10], sum[11], c[11]);
    FA FA12(clk, a[12], b[12], c[11], sum[12], c[12]);
    FA FA13(clk, a[13], b[13], c[12], sum[13], c[13]);
    FA FA14(clk, a[14], b[14], c[13], sum[14], c[14]);
    FA FA15(clk, a[15], b[15], c[14], sum[15], c[15]);
                           
endmodule

module FA(clk, a, b, cin, s, c);
    input clk;
    input a, b, cin;
    output  reg s, c;
    always @(posedge clk) begin
        s <= (a ^ b ^ cin);
        c <= ( a & b ) + ( b & cin ) + ( cin & a );
    end
endmodule

module HA(clk, a, b, s, c);
    input clk;
    input a, b;
    output  reg s, c;
    always @(posedge clk) begin
        s <=  a ^ b ;//XOR
        c <=  a & b ;
    end
endmodule
