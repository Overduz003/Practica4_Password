module password ( //Utilizando maquina de estados --> 4 nibbles (16 bits)
	input clk, rst,
	input [3:0]fms_in,
	input KEY,
	output reg fms_out,
	output [2:0] state_out,
	output reg [15:0] display_val);
//Estados
parameter IDLE=0,
			 N_1=1,
			 N_2=2,
			 N_3=3,
			 V_good=5,
			 V_bad=6;
			 
//Password
parameter [15:0] pass_value = 16'h1234;
			 
reg [2:0] current_state, next_state;
wire confirmar = ~KEY;
reg confirmar_ant;
wire pulso_confirmar;

//reloj de cambio de boton
always @(posedge clk or posedge rst) begin
	if(rst)
		confirmar_ant <= 0;
	else
		confirmar_ant <= confirmar;
end

assign pulso_confirmar = confirmar && !confirmar_ant; //el pulso ocurre cuando confirmar sea 1 y ant 0 

	
always @(*)//(current_state, fms_in)
	begin
		case(current_state)
			IDLE: begin
				if(fms_in == pass_value[15:12] && confirmar)
					next_state = N_1;
				else
					next_state = V_bad;
				end
				
			N_1: begin
				if(fms_in == pass_value[11:8] && confirmar)
					next_state = N_2;
				else
					next_state = V_bad;
				end
			
			N_2: begin
				if(fms_in == pass_value[7:4] && confirmar )
					next_state = N_3;
				else
					next_state = V_bad;
				end
			
			N_3: begin
				if(fms_in == pass_value[3:0] && confirmar)
					next_state = V_good;
				else
					next_state = V_bad;
				end
							
			V_good : next_state = V_good;
			V_bad : next_state = V_bad;
			default: next_state = IDLE;
			
		endcase
	end
	
//Salida

always@(*)//(current_state, fms_in)
	begin
		fms_out = (current_state == V_good);
	end

assign state_out = current_state; // madar el mensaje hacia afuera	

//Memoria del display // reloj de cambio

always@(posedge clk or posedge rst) begin
	if (rst) begin
		current_state <= IDLE;
		display_val <= ~16'b1111111111111111;
	end
	else if(pulso_confirmar) begin
		current_state <= next_state;
		
		case(current_state)
			IDLE: display_val[15:12] <= fms_in;
			N_1: display_val[11:8] <= fms_in;
			N_2: display_val[7:4] <= fms_in;
			N_3: display_val[3:0] <= fms_in;
		endcase
	end
end
endmodule