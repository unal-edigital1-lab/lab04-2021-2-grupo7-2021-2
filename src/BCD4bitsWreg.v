`timescale 1ns / 1ps
module BCD4bitsWreg(
    input [3:0] num1,
    input [3:0] num2,
    input clk,
    output [0:6] sseg,
    output reg [3:0] an,
	  input rst
    );

reg [3:0]bcd=0;
//wire [15:0] num1=16'h4321;

BCDtoSSeg bcdtosseg(.BCD(bcd), .SSeg(sseg));

reg [26:0] cfreq=0;
wire enable;

// Divisor de frecuecia

assign enable = cfreq[16];
always @(posedge clk) begin
  if(rst==0) begin
		cfreq <= 0;
	end else begin
		cfreq <=cfreq+1;
	end
end

reg [1:0] count =0;
always @(posedge enable) begin
		if(rst==0) begin
			count<= 0;
			an<=4'b1111;
		end else begin
			count<= count+1;
			an<=4'b1101;
  		case (num1)
        4'ha:
          case (count)
            2'h2: begin bcd <= 4'h0;   an<=4'b1011; end
            2'h3: begin bcd <= 4'h1;   an<=4'b0111; end
          endcase
        4'hb:
          case (count)
            2'h2: begin bcd <= 4'h1;   an<=4'b1011; end
            2'h3: begin bcd <= 4'h1;   an<=4'b0111; end
          endcase
        4'hc:
          case (count)
            2'h2: begin bcd <= 4'h2;   an<=4'b1011; end
            2'h3: begin bcd <= 4'h1;   an<=4'b0111; end
          endcase
        4'hd:
          case (count)
            2'h2: begin bcd <= 4'h3;   an<=4'b1011; end
            2'h3: begin bcd <= 4'h1;   an<=4'b0111; end
          endcase
        4'he:
          case (count)
            2'h2: begin bcd <= 4'h4;   an<=4'b1011; end
            2'h3: begin bcd <= 4'h1;   an<=4'b0111; end
          endcase
        4'hf:
          case (count)
            2'h2: begin bcd <= 4'h5;   an<=4'b1011; end
            2'h3: begin bcd <= 4'h1;   an<=4'b0111; end
          endcase
        default:
          case (count)
            2'h2: begin bcd <= num1[3:0];   an<=4'b1011; end
            2'h3: begin bcd <= 4'b0000;   an<=4'b0111; end
          endcase
      endcase
      case (num2)
        4'ha:
          case (count)
            2'h0: begin bcd <= 4'h0;   an<=4'b1110; end
            2'h1: begin bcd <= 4'h1;   an<=4'b1101; end
          endcase
        4'hb:
          case (count)
            2'h0: begin bcd <= 4'h1;   an<=4'b1110; end
            2'h1: begin bcd <= 4'h1;   an<=4'b1101; end
          endcase
        4'hc:
          case (count)
            2'h0: begin bcd <= 4'h2;   an<=4'b1110; end
            2'h1: begin bcd <= 4'h1;   an<=4'b1101; end
          endcase
        4'hd:
          case (count)
            2'h0: begin bcd <= 4'h3;   an<=4'b1110; end
            2'h1: begin bcd <= 4'h1;   an<=4'b1101; end
          endcase
        4'he:
          case (count)
            2'h0: begin bcd <= 4'h4;   an<=4'b1110; end
            2'h1: begin bcd <= 4'h1;   an<=4'b1101; end
          endcase
        4'hf:
          case (count)
            2'h0: begin bcd <= 4'h5;   an<=4'b1110; end
            2'h1: begin bcd <= 4'h1;   an<=4'b1101; end
          endcase
        default:
          case (count)
            2'h0: begin bcd <= num2[3:0];   an<=4'b1110; end
            2'h1: begin bcd <= 4'b0000;   an<=4'b1101; end
          endcase
      endcase
		end
end

endmodule
