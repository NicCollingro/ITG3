`include "symbols.vh"
  
module control(
  input  wire[7:0] state,
  input  wire[2:0] operand1,
  input  wire[2:0] operand2,
  input  wire      flag_zero,
  input  wire      flag_carry,
  output wire	   c_da,			// Dekoder 
  output wire      c_ii,			// IR
  output wire      c_ci, c_co, c_cs,		// PC
  output wire      c_rfi, c_rfo,		// CPU-Register
  output wire      c_eo, c_ee,			// ALU
  output wire      c_mi,			// MAR
  output wire      c_ro, c_ri,			// RAM
  output wire      c_so, c_sd, c_si,		// SP
  output wire      c_gi, c_go,			// GPIO
  output wire      c_halt
);

  wire jump_allowed =   operand2 == `JMP_JMP
                      | operand2 == `JMP_JZ   &  flag_zero
                      | operand2 == `JMP_JNZ  & ~flag_zero
                      | operand2 == `JMP_JC   &  flag_carry
                      | operand2 == `JMP_JNC  & ~flag_carry;
                                       


  // Dekoder
  assign c_da         =   (state == `STATE_SET_MAR);

  // IR
  assign c_ii         =   (state == `STATE_FETCH_INST);

  // PC
  assign c_ci         =   (state == `STATE_FETCH_PC) 
                        | (state == `STATE_JUMP & jump_allowed) 
                        | (state == `STATE_RET) 
                        | (state == `STATE_TMP_JUMP);

  assign c_co         =   (state == `STATE_FETCH_PC)
                        | (state == `STATE_STORE_PC);

  assign c_cs          =   (state == `STATE_JUMP & jump_allowed) 
                        | (state == `STATE_RET) 
                        | (state == `STATE_TMP_JUMP);

  // CPU-Register
  assign c_rfi        =   (state == `STATE_ALU_OUT)
                        | (state == `STATE_SET_REG)		
                        | (state == `STATE_MOV_REG)
                        | (state == `STATE_SET_REG)
                        | (state == `STATE_RIN_STORE);		// GPIO Reg

  assign c_rfo        =   (state == `STATE_MOV_REG)
                        | (state == `STATE_SET_MEM) 
                        | (state == `STATE_SET_MAR) 		
                        | (state == `STATE_STACK_REG) 
                        | (state == `STATE_TMP_JUMP)
                        | (state == `STATE_ROUT_STORE);		// GPIO Reg

  // ALU
  assign c_eo         =   (state == `STATE_ALU_OUT);

  assign c_ee         =   (state == `STATE_ALU_EXEC);

  // MAR
  assign c_mi         =   (state == `STATE_FETCH_PC) 
                        | (state == `STATE_FETCH_SP) 
                        | (state == `STATE_SET_MAR) 
                        | (state == `STATE_LOAD_ADDR);

  // RAM
  assign c_ri         =   (state == `STATE_SET_MEM) 		
                        | (state == `STATE_STORE_PC)
                        | (state == `STATE_STACK_REG)
                        | (state == `STATE_MIN_STORE);		// GPIO


  assign c_ro         =   (state == `STATE_FETCH_INST) 
                        | (state == `STATE_JUMP & jump_allowed) 
                        | (state == `STATE_LOAD_ADDR) 		
                        | (state == `STATE_SET_REG)		
                        | (state == `STATE_RET) 
                        | (state == `STATE_SET_REG)
                        | (state == `STATE_MOUT_STORE);		// GPIO

  // SP
  assign c_si         =   (state == `STATE_INC_SP)
                        | (state == `STATE_STACK_REG) 
                        | (state == `STATE_TMP_JUMP);

  assign c_so         =   (state == `STATE_FETCH_SP);

  assign c_sd         =   (state == `STATE_STACK_REG)
                        | (state == `STATE_TMP_JUMP); 
  
  // Machine
  assign c_halt       =   (state == `STATE_HALT);

  // GPIO
  assign c_gi         =   (state == `STATE_MIN_STORE)		// GPIO Mem
                        | (state == `STATE_RIN_STORE);		// GPIO Reg

  assign c_go         =   (state == `STATE_MOUT_STORE)		// GPIO Mem
                        | (state == `STATE_ROUT_STORE);		// GPIO Reg

endmodule
