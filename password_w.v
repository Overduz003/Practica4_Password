module password_w (
	input [9:0] SW,
	input [1:0] KEY,
	input MAX10_CLK1_50,
	output [9:0] LEDR,
	output reg [0:6] HEX0, HEX1, HEX2, HEX3
	);
	
	wire [2:0] cable_estado;
	wire [6:0] cable_un, cable_de, cable_ce, cable_mi;
	wire [15:0] cable_display;
	
password maquina_estados(
	.clk(MAX10_CLK1_50),
	.rst(~KEY[1]),
	.fms_in(SW[3:0]),
	.KEY(KEY[0]),
	.fms_out(LEDR[0]),
	.state_out(cable_estado),
	.display_val(cable_display));
	
//Traductor
BCD_module TRAD1 (
	.bcd_in(cable_display[15:12]),
	.bcd_out(cable_mi));

BCD_module TRAD2 (
	.bcd_in(cable_display[11:8]),
	.bcd_out(cable_ce));
	
BCD_module TRAD3 (
	.bcd_in(cable_display[7:4]),
	.bcd_out(cable_de));
	
BCD_module TRAD4 (
	.bcd_in(cable_display[3:0]),
	.bcd_out(cable_un));
	
//------MENSAJE GOOD / BAD -----------------------

always@(*)
	case(cable_estado)
		5: begin
			HEX3 = ~7'b1011111;
			HEX2 = ~7'b0011101;
			HEX1 = ~7'b0011101;
			HEX0 = ~7'b0111101;
		end
		6: begin
			HEX3 = ~7'b0000000;
			HEX2 = ~7'b0011111;
			HEX1 = ~7'b1110111;
			HEX0 = ~7'b0111101;
		end
		default: begin
			HEX3 = cable_mi;
			HEX2 = cable_ce;
			HEX1 = cable_de;
			HEX0 = cable_un;
		end
	endcase
	
endmodule