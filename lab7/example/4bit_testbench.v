`timescale 1ns/1ps
`include "4bit_CLA.v"
module testbench;

    reg [3:0] in_a, in_b;
    reg cin;

	reg clk;
	reg rst;

    reg [5:0] idx;
    reg [5:0] write;
    reg [5:0] correct_ct;
    reg [3:0] correct_ans;

    wire [3:0] sum;

    CLA_4bit CLA(in_a,in_b,cin,sum);

	initial begin    //初始化

        in_a = 0;
        in_b = 0;
        cin = 0;
        clk = 1'b0;
        correct_ct = 0;

        $dumpfile("CLA_4bit.fsdb");  //產生波形檔
        $dumpvars;
        
        #10 rst = 1;
        #20 rst = 0;

        for (idx = 1;idx < 10;idx=idx+1) begin
            #100 rst = 1;
            #20 rst = 0;
        end

        #50     $display ("//   CORRECT COUNT = %d  //",correct_ct);
        #100    $finish;

    end

    always #10 clk = ~clk;    //create clock

    always @(posedge clk or posedge rst) begin

        if (rst) begin

            in_a <= {$random} % 15;
			in_b <= {$random} % 15;
            cin  <= {$random} % 2;
            correct_ans <= 0;
            write <= 0;

        end else begin

            correct_ans <= in_a + in_b + cin;
            write <= write + 1;

            if (write == 1) begin

                if (sum == correct_ans) begin

                    correct_ct <= correct_ct + 1;
                    $display ("//////////Test %d//////////",idx);
                    $display ("//  Q :%d + %d + %d = ?   //",in_a,in_b,cin);
                    $display ("///////////////////////////");
                    $display ("//  Your answer          //");
                    $display ("//  Sum = %d    //",sum);
                    $display ("///////////////////////////");
                    $display ("//  Correct answer       //");
                    $display ("//  Sum = %d    //",correct_ans);    
                    $display ("///////////////////////////");
                    $display ("//       SUCCESSFUL !    //");
                    $display ("///////////////////////////\n");

                end else begin

                    $display ("//////////Test %d//////////",idx);
                    $display ("//  Q :%d + %d + %d = ?   //",in_a,in_b,cin);
                    $display ("//  Sum = %d    //",sum);
                    $display ("///////////////////////////");
                    $display ("//  Correct answer       //");
                    $display ("//  Sum = %d    //",correct_ans);           
                    $display ("///////////////////////////");
                    $display ("//         FAIL !        //");
                    $display ("///////////////////////////\n");

                end 
            end
        end
    end

endmodule
