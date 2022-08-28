module CLA_64bit(a,b,cin,sum);

    input [63:0] a,b;
    input cin;
    output [63:0] sum;

    wire [63:0] g,p;
    wire [63:1] c;
    wire [15:0] gG,gP;
    wire [3:0] a_gG,a_gP;
    
    //Write down your design here ---//
	
	  //generate g & p
        gp_generator gp0(a[3:0],b[3:0],g[3:0],p[3:0]);
        gp_generator gp1(a[7:4],b[7:4],g[7:4],p[7:4]);
        gp_generator gp2(a[11:8],b[11:8],g[11:8],p[11:8]);
        gp_generator gp3(a[15:12],b[15:12],g[15:12],p[15:12]);
        gp_generator gp4(a[19:16],b[19:16],g[19:16],p[19:16]);
        gp_generator gp5(a[23:20],b[23:20],g[23:20],p[23:20]);
        gp_generator gp6(a[27:24],b[27:24],g[27:24],p[27:24]);
        gp_generator gp7(a[31:28],b[31:28],g[31:28],p[31:28]);
        gp_generator gp8(a[35:32],b[35:32],g[35:32],p[35:32]);
        gp_generator gp9(a[39:36],b[39:36],g[39:36],p[39:36]);
        gp_generator gp10(a[43:40],b[43:40],g[43:40],p[43:40]);
        gp_generator gp11(a[47:44],b[47:44],g[47:44],p[47:44]);
        gp_generator gp12(a[51:48],b[51:48],g[51:48],p[51:48]);
        gp_generator gp13(a[55:52],b[55:52],g[55:52],p[55:52]);
        gp_generator gp14(a[59:56],b[59:56],g[59:56],p[59:56]);
        gp_generator gp15(a[63:60],b[63:60],g[63:60],p[63:60]);
		
	  //generate gG & gP, all 4 bits
        carry_generator c0(g[3:0],p[3:0],cin,c[3:1],gG[0],gP[0]);
        carry_generator c1(g[7:4],p[7:4],c[4],c[7:5],gG[1],gP[1]);
        carry_generator c2(g[11:8],p[11:8],c[8],c[11:9],gG[2],gP[2]);
        carry_generator c3(g[15:12],p[15:12],c[12],c[15:13],gG[3],gP[3]);
        carry_generator c4(g[19:16],p[19:16],c[16],c[19:17],gG[4],gP[4]);
        carry_generator c5(g[23:20],p[23:20],c[20],c[23:21],gG[5],gP[5]);
        carry_generator c6(g[27:24],p[27:24],c[24],c[27:25],gG[6],gP[6]);
        carry_generator c7(g[31:28],p[31:28],c[28],c[31:29],gG[7],gP[7]);
        carry_generator c8(g[35:32],p[35:32],c[32],c[35:33],gG[8],gP[8]);
        carry_generator c9(g[39:36],p[39:36],c[36],c[39:37],gG[9],gP[9]);
        carry_generator c10(g[43:40],p[43:40],c[40],c[43:41],gG[10],gP[10]);
        carry_generator c11(g[47:44],p[47:44],c[44],c[47:45],gG[11],gP[11]);
        carry_generator c12(g[51:48],p[51:48],c[48],c[51:49],gG[12],gP[12]);
        carry_generator c13(g[55:52],p[55:52],c[52],c[55:53],gG[13],gP[13]);
        carry_generator c14(g[59:56],p[59:56],c[56],c[59:57],gG[14],gP[14]);
        carry_generator c15(g[63:60],p[63:60],c[60],c[63:61],gG[15],gP[15]);

      //generate 16 bits G/P
        carry_generator g16_1(gG[3:0],gP[3:0],,,a_gG[0],a_gP[0]);
        carry_generator g16_2(gG[7:4],gP[7:4],,,a_gG[1],a_gP[1]);
        carry_generator g16_3(gG[11:8],gP[11:8],,,a_gG[2],a_gP[2]);
        carry_generator g16_4(gG[15:12],gP[15:12],,,a_gG[3],a_gP[3]);

      //generate c16,c32..
        carry_generator c_16bit(a_gG[3:0],a_gP[3:0],cin,{c[48],c[32],c[16]},,);
	
	  //generate c4,c8....
        carry_generator g_1(gG[3:0],gP[3:0],cin,{c[12],c[8],c[4]},,);
        carry_generator g_2(gG[7:4],gP[7:4],c[16],{c[28],c[24],c[20]},,);
        carry_generator g_3(gG[11:8],gP[11:8],c[32],{c[44],c[40],c[36]},,);
        carry_generator g_4(gG[15:12],gP[15:12],c[48],{c[60],c[56],c[52]},,);
	    
      //generate all
        carry_generator c_0(g[3:0],p[3:0],cin,c[3:1],,);
        carry_generator c_1(g[7:4],p[7:4],c[4],c[7:5],,);
        carry_generator c_2(g[11:8],p[11:8],c[8],c[11:9],,);
        carry_generator c_3(g[15:12],p[15:12],c[12],c[15:13],,);
        carry_generator c_4(g[19:16],p[19:16],c[16],c[19:17],,);
        carry_generator c_5(g[23:20],p[23:20],c[20],c[23:21],,);
        carry_generator c_6(g[27:24],p[27:24],c[24],c[27:25],,);
        carry_generator c_7(g[31:28],p[31:28],c[28],c[31:29],,);
        carry_generator c_8(g[35:32],p[35:32],c[32],c[35:33],,);
        carry_generator c_9(g[39:36],p[39:36],c[36],c[39:37],,);
        carry_generator c_10(g[43:40],p[43:40],c[40],c[43:41],,);
        carry_generator c_11(g[47:44],p[47:44],c[44],c[47:45],,);
        carry_generator c_12(g[51:48],p[51:48],c[48],c[51:49],,);
        carry_generator c_13(g[55:52],p[55:52],c[52],c[55:53],,);
        carry_generator c_14(g[59:56],p[59:56],c[56],c[59:57],,);
        carry_generator c_15(g[63:60],p[63:60],c[60],c[63:61],,);
  		
	  //generate sum
        sum_generator s(a[63:0],b[63:0],cin,c[63:1],sum[63:0]);
    
    //-------------------------------//

endmodule

module gp_generator(a,b,g,p);

    input [3:0] a,b;
    output [3:0] g,p;

    assign g = a & b;
    assign p = a | b;

endmodule

module carry_generator(g,p,cin,c,gG,gP);

    input [3:0] g,p;
    input cin;
    output gG,gP;
    output [3:1] c;

	assign gG = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);
	assign gP = p[3] & p[2] & p[1] & p[0];

    assign c[1] = g[0] | (p[0] & cin);
    assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
    assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & cin);

endmodule

module sum_generator(a,b,cin,c,sum);

    input [63:0] a,b;
    input cin;
    input [63:1] c;
    output [63:0] sum;
	

    assign sum = a ^ b ^ {c,cin};

endmodule
