module add4(a, b, c, d, sum, ov);

       input [3:0] a, b, c, d;
       output [4:0] sum;
       output ov;


       assign sum = a + b + c + d + sum;
       assign ov = 1'b0;

endmodule
