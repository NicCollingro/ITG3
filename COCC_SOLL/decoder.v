`include "symbols.vh"

module decoder(
  input  wire[7:0] instruction,
  input wire c_da,
  output wire[2:0] operand1,
  output wire[2:0] operand2,
  output reg[7:0]  opcode,
  output reg[2:0]  iaddr,
  output reg[2:0]  oaddr,
  output reg[3:0]  alu_mode
);


  // Operanden
  assign operand1 = instruction[5:3];
  assign operand2 = instruction[2:0];

  // Opccode-Decoder
  always @(*) begin
    casez (instruction)
      `PATTERN_LDI:  opcode <= `OP_LDI;
      `PATTERN_MOV:  opcode <= `OP_MOV;
      `PATTERN_LDX:  opcode <= `OP_LDX;
      `PATTERN_STX:  opcode <= `OP_STX;
      `PATTERN_LDA:  opcode <= `OP_LDA;
      `PATTERN_STA:  opcode <= `OP_STA;
      `PATTERN_ALU:  opcode <= `OP_ALU;
      `PATTERN_JMP:  opcode <= `OP_JMP;
      `PATTERN_PUSH: opcode <= `OP_PUSH;
      `PATTERN_POP:  opcode <= `OP_POP; 
      `PATTERN_ROUT: opcode <= `OP_ROUT; 			// GPIO
      `PATTERN_RIN:  opcode <= `OP_RIN; 			// GPIO
      `PATTERN_NOP:  opcode <= `OP_NOP;
      `PATTERN_CALL: opcode <= `OP_CALL;
      `PATTERN_RET:  opcode <= `OP_RET;
      `PATTERN_MIN:  opcode <= `OP_MIN;				// GPIO
      `PATTERN_MOUT: opcode <= `OP_MOUT;			// GPIO
      `PATTERN_HLT:  opcode <= `OP_HLT;
      `PATTERN_CMP:  opcode <= `OP_CMP;
    endcase
  end

  // ALU-Mode Decoder  
  always @(*) begin
    case (opcode)
      `OP_ALU:   alu_mode <= instruction[3:0];
      `OP_CMP:   alu_mode <= `ALU_SUB;
      default:   alu_mode <= 4'bx;
    endcase
  end
  
  // iaddr-Decoder
  always @(*) begin
    case (opcode)
      `OP_ALU:   iaddr <= `REG_A;
      `OP_CALL:  iaddr <= `REG_H;
      `OP_LDI:   iaddr <= operand2;
      `OP_LDX:   iaddr <= operand2;
      `OP_LDA:   iaddr <= operand2;
      `OP_MOV:   iaddr <= operand1;
      `OP_POP:   iaddr <= operand2;
      `OP_RIN:   iaddr <= operand2;			// GPIO
      default:   iaddr <= 3'bx;
    endcase
  end
  
  // oaddr-Decoder
  always @(*) begin
    case (opcode)
      `OP_CALL:  oaddr <= `REG_H;
      `OP_MOV:   oaddr <= operand2;
      `OP_STX:   oaddr <= operand2;
      `OP_LDA:   oaddr <= `REG_A;
      `OP_STA:   oaddr <= c_da ? `REG_A : operand2;
      `OP_PUSH:  oaddr <= operand2;
      `OP_ROUT:  oaddr <= operand2;			// GPIO
      default:   oaddr <= 3'bx;
    endcase
  end
endmodule
