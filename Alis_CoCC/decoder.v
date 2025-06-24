`include "symbols.vh"

module decoder (input wire [7:0] instruction, output reg [2:0] iaddr, output reg [2:0] oaddr,
output wire [2:0] operand1,  output wire [2:0] operand2 , output reg[7:0] opcode,
output reg [2:0] alu_mode);

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
default : opcode <= instruction;
endcase
end

always @ (*) begin
case ( opcode )
`OP_ALU : alu_mode <= operand2;
`OP_CMP : alu_mode <= `ALU_SUB;
default : alu_mode <= 3'bx;
endcase
end

always @ (*) begin
case (opcode)
    `OP_ALU:   iaddr <= 3'b000; //Akumulator 
    `OP_CALL:  iaddr <= 3'b111; //rechenregister
    `OP_LDI:   iaddr <= operand2;
    `OP_LDX:   iaddr <= operand2;
    `OP_MOV:   iaddr <= operand1;
    `OP_POP:   iaddr <= operand2;
    default:   iaddr <= 3'bx;
endcase
end

always @ (*) begin
case ( opcode )
    `OP_CALL:  oaddr <= 3'b111;
    `OP_MOV:   oaddr <= operand2;
    `OP_STX:   oaddr <= operand2;
    `OP_PUSH:  oaddr <= operand2;		
    default:   oaddr <= 3'bx;
endcase
end

endmodule