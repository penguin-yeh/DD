
module HA(clk, a, b, s, c);
    input clk;
    input a, b;
    output  reg s, c;
    always @(posedge clk) begin
        s <=  a ^ b ;//XOR
        c <=  a & b ;
    end
endmodule