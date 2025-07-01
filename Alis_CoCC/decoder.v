`include "symbols.vh"

module decoder (input wire [7:0] instruction, input wire c_da, output reg [2:0] iaddr, output reg [2:0] oaddr,
output wire [2:0] operand1,  output wire [2:0] operand2 , output reg[7:0] opcode,
output reg [3:0] alu_mode);

assign operand1 = instruction[5:3];
assign operand2 = instruction[2:0];

always @ (*) begin
casez (instruction)
    8'b00_000_???:  opcode <= `OP_LDI;
    8'b00_???_???:  opcode <= `OP_MOV;
    8'b00_000_???:  opcode <= `OP_LDX;
    8'b00_000_???:  opcode <= `OP_STX;
    8'b00_000_???:  opcode <= `OP_ALU;
    8'b00_000_???:  opcode <= `OP_JMP;
    8'b00_000_???: opcode <= `OP_PUSH;
    8'b00_000_???:  opcode <= `OP_POP;  			
    `PATTERN_NOP:  opcode <= `OP_NOP;
    `PATTERN_CALL: opcode <= `OP_CALL;
    `PATTERN_RET:  opcode <= `OP_RET;			
    `PATTERN_HLT:  opcode <= `OP_HLT;
    `PATTERN_CMP:  opcode <= `OP_CMP;
    `PATTERN_LDA:  opcode <= `OP_LDA;
    `PATTERN_STA:  opcode <= `OP_STA;
default : opcode <= instruction;
endcase
end

always @ (*) begin
case ( opcode )
`OP_ALU : alu_mode <= operand2;
`OP_CMP : alu_mode <= `ALU_SUB;
default : alu_mode <= 4'bx;
endcase
end

always @ (*) begin
case (opcode)                   //TODO sta und lda 
    `OP_ALU:   iaddr <= `REG_A; //Akumulator 
    `OP_CALL:  iaddr <= `REG_H; //rechenregister
    `OP_LDI:   iaddr <= operand2;
    `OP_LDX:   iaddr <= operand2;
    `OP_MOV:   iaddr <= operand1;
    `OP_POP:   iaddr <= operand2;
    //LDA UND STA
    `OP_LDA:   iaddr <= operand2;
    default:   iaddr <= 3'bx;
endcase
end

always @ (*) begin
case ( opcode )
    `OP_CALL:  oaddr <= `REG_H;
    `OP_MOV:   oaddr <= operand2;
    `OP_STX:   oaddr <= operand2;
    `OP_PUSH:  oaddr <= operand2;	
    //LDA UND STA	    
    `OP_LDA:   oaddr <= `REG_A;
    `OP_STA:   begin
        if (c_da) oaddr <= `REG_A;
        else oaddr <= operand2;
    end
    default:   oaddr <= 3'bx;
endcase
end

endmodule