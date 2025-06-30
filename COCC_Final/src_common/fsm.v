`include "symbols.vh"

module fsm(
  input  wire 	   clk,
  input  wire[7:0] opcode,
  input  wire 	   reset,
  output reg[7:0]  state = 8'b0
);

  reg[3:0] cycle = 4'b0;

  wire reset_cycle = (state == `STATE_NEXT) | reset;

  // Hochzählen von cycle zeitverzögert wg. async reset_cycle
  always @(negedge clk) begin
    if (reset_cycle)
      cycle <= 0;
    else
      cycle <= cycle + 1'b1;
  end

// GPIO Mem
// OP_MIN  => FETCH_PC -> IN_LOAD  -> IN_STORE  -> NEXT
// OP_MOUT => FETCH_PC -> OUT_LOAD -> OUT_STORE -> NEXT
//
// GPIO Reg
// OP_RIN  => RIN_STORE  -> NEXT
// OP_ROUT => ROUT_STORE -> NEXT

  always @(posedge clk) begin
    case (cycle)
      `T0:              state <= `STATE_FETCH_PC;
      `T1:              state <= `STATE_FETCH_INST;
      `T2: case (opcode)
             `OP_ALU  : state <= `STATE_ALU_EXEC;
             `OP_CALL : state <= `STATE_FETCH_PC; 
             `OP_CMP  : state <= `STATE_ALU_EXEC;
             `OP_HLT  : state <= `STATE_HALT;
             `OP_JMP  : state <= `STATE_FETCH_PC; 
             `OP_LDI  : state <= `STATE_FETCH_PC; 
             `OP_MOV  : state <= `STATE_MOV_REG;
             `OP_LDX  : state <= `STATE_FETCH_PC;
             `OP_STX  : state <= `STATE_FETCH_PC;
             `OP_LDA  : state <= `STATE_SET_MAR;
             `OP_STA  : state <= `STATE_SET_MAR;
             `OP_POP  : state <= `STATE_INC_SP;
             `OP_PUSH : state <= `STATE_FETCH_SP;
             `OP_RET  : state <= `STATE_INC_SP;
             `OP_MIN  : state <= `STATE_FETCH_PC; 		// GPIO Mem
             `OP_MOUT : state <= `STATE_FETCH_PC;		// GPIO Mem
             `OP_RIN  : state <= `STATE_RIN_STORE; 		// GPIO Reg
             `OP_ROUT : state <= `STATE_ROUT_STORE;		// GPIO Reg
             default  : state <= `STATE_NEXT;     
           endcase
      `T3: case (opcode)
             `OP_ALU  : state <= `STATE_ALU_OUT;
             `OP_CALL : state <= `STATE_SET_REG;
             `OP_JMP  : state <= `STATE_JUMP;
             `OP_LDI  : state <= `STATE_SET_REG;
             `OP_LDX  : state <= `STATE_LOAD_ADDR;
             `OP_STX  : state <= `STATE_LOAD_ADDR;
             `OP_LDA  : state <= `STATE_SET_REG;
             `OP_STA  : state <= `STATE_SET_MEM;
             `OP_POP  : state <= `STATE_FETCH_SP;
             `OP_PUSH : state <= `STATE_STACK_REG;
             `OP_RET  : state <= `STATE_FETCH_SP;
             `OP_MIN  : state <= `STATE_LOAD_ADDR;		// GPIO Mem
             `OP_MOUT : state <= `STATE_LOAD_ADDR;		// GPIO Mem
             default  : state <= `STATE_NEXT;
           endcase
      `T4: case (opcode)
             `OP_CALL : state <= `STATE_FETCH_SP;
             `OP_LDX  : state <= `STATE_SET_REG;
             `OP_STX  : state <= `STATE_SET_MEM;
             `OP_POP  : state <= `STATE_SET_REG;
             `OP_RET  : state <= `STATE_RET;
             `OP_MIN  : state <= `STATE_MIN_STORE; 		// GPIO Mem
             `OP_MOUT : state <= `STATE_MOUT_STORE; 		// GPIO Mem
             default  : state <= `STATE_NEXT;
           endcase
      `T5: case (opcode)
             `OP_CALL : state <= `STATE_STORE_PC;
             default  : state <= `STATE_NEXT;
           endcase
      `T6: case (opcode)
             `OP_CALL : state <= `STATE_TMP_JUMP;
             default  : state <= `STATE_NEXT;
           endcase
      `T7:              state <= `STATE_NEXT;
    endcase
  end
endmodule
