`include "symbols.vh"

module control(input wire[7:0] state, input wire [2:0] operand1, 
input wire [2:0]operand2, input wire flag_carry, input wire flag_zero,
output wire c_ii, output wire c_ci, output wire c_co, output wire c_cs, 
output wire c_rfi, output wire c_rfo, output wire c_eo, output wire c_ee, 
output wire c_mi, output wire c_ro, output wire c_ri, output wire c_so, 
output wire c_sd, output wire c_si, output wire c_halt, output wire c_da);

  wire jump_allowed =   operand2 == `JMP_JMP
                      | operand2 == `JMP_JZ   &  flag_zero
                      | operand2 == `JMP_JNZ  & ~flag_zero
                      | operand2 == `JMP_JC   &  flag_carry
                      | operand2 == `JMP_JNC  & ~flag_carry;
                                       
  assign c_da         =   (state == `STATE_SET_MAR);

  assign c_ii         =   (state == `STATE_FETCH_INST);

  assign c_ci         =   (state == `STATE_FETCH_PC) 
                        | (state == `STATE_JUMP & jump_allowed) 
                        | (state == `STATE_RET) 
                        | (state == `STATE_TMP_JUMP);

  assign c_co         =   (state == `STATE_FETCH_PC)
                        | (state == `STATE_STORE_PC);

  assign c_cs          =   (state == `STATE_JUMP & jump_allowed) 
                        | (state == `STATE_RET) 
                        | (state == `STATE_TMP_JUMP);

  assign c_rfi        =   (state == `STATE_ALU_OUT)
                        | (state == `STATE_SET_REG)		
                        | (state == `STATE_MOV_REG)
                        | (state == `STATE_SET_REG);

  assign c_rfo        =   (state == `STATE_MOV_REG)
                        | (state == `STATE_SET_MEM) 
                        | (state == `STATE_SET_MAR) 		
                        | (state == `STATE_STACK_REG) 
                        | (state == `STATE_TMP_JUMP);
  assign c_eo         =   (state == `STATE_ALU_OUT);

  assign c_ee         =   (state == `STATE_ALU_EXEC);

  assign c_mi         =   (state == `STATE_FETCH_PC) 
                        | (state == `STATE_FETCH_SP) 
                        | (state == `STATE_SET_MAR) 
                        | (state == `STATE_LOAD_ADDR);

  assign c_ri         =   (state == `STATE_SET_MEM) 		
                        | (state == `STATE_STORE_PC)
                        | (state == `STATE_STACK_REG);

  assign c_ro         =   (state == `STATE_FETCH_INST) 
                        | (state == `STATE_JUMP & jump_allowed) 
                        | (state == `STATE_LOAD_ADDR) 		
                        | (state == `STATE_SET_REG)		
                        | (state == `STATE_RET) 
                        | (state == `STATE_SET_REG);
                        
  assign c_si         =   (state == `STATE_INC_SP)
                        | (state == `STATE_STACK_REG) 
                        | (state == `STATE_TMP_JUMP);

  assign c_so         =   (state == `STATE_FETCH_SP);

  assign c_sd         =   (state == `STATE_STACK_REG)
                        | (state == `STATE_TMP_JUMP); 

  assign c_halt       =   (state == `STATE_HALT);

endmodule