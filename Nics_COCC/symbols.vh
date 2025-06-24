//TAKT
`define T0 3'b000;
`define T1 3'b001;
`define T2 3'b010;
`define T3 3'b011;
`define T4 3'b100;
`define T5 3'b101;
`define T6 3'b110;
`define T7 3'b111;

//STATE

`define STATE_FETCH_PC 8'h00
`define STATE_FETCH_INST 8'h01
`define STATE_LOAD_ADDR 8'h02
`define STATE_JUMP 8'h03
`define STATE_HALT 8'h04
`define STATE_INC_SP 8'h05
`define STATE_MOV_REG 8'h06
`define STATE_FETCH_SP 8'h07
`define STATE_SET_MEM 8'h08
`define STATE_STORE_PC 8'h09
`define STATE_SET_REG 8'h0A
`define STATE_ALU_EXEC 8'h0B
`define STATE_RET 8'h0C
`define STATE_STACK_REG 8'h0D
`define STATE_TMP_JUMP 8'h0E
`define STATE_ALU_OUT 8'h10
`define STATE_NEXT 8'h11

//PATTERN

`define PATTERN_NOP (8'b00_000_000)
`define PATTERN_HLT (8'b00_000_001)
`define PATTERN_CALL (8'b00_000_010)
`define PATTERN_RET (8'b00_000_011)
`define PATTERN_CMP (8'b00_000_100)
`define PATTERN_ALU (8'b00_010_???)
`define PATTERN_LDI (8'b01_000_???)
`define PATTERN_LDX (8'b01_001_???)
`define PATTERN_STX (8'b01_010_???)
`define PATTERN_PUSH (8'b01_011_???)
`define PATTERN_POP (8'b01_100_???)
`define PATTERN_JMP (8'b01_101_???)
`define PATTERN_MOV (8'b10_???_???)

//OPCODES

`define OP_NOP (8'b00_000_000)
`define OP_HLT (8'b00_000_001)
`define OP_CALL (8'b00_000_010)
`define OP_RET (8'b00_000_011)
`define OP_CMP (8'b00_000_100)
`define OP_ALU (8'b00_010_000)
`define OP_LDI (8'b01_000_000)
`define OP_LDX (8'b01_001_000)
`define OP_STX (8'b01_010_000)
`define OP_PUSH (8'b01_011_000)
`define OP_POP (8'b01_100_000)
`define OP_JMP (8'b01_101_000)
`define OP_MOV (8'b10_000_000)

//MAKROS

//JUMP-MODES

`define JMP_JMP 3'b000  //unbedingter Sprung
`define JMP_JZ 3'b001   //jump if zero
`define JMP_JNZ 3'b010  //jump if not zero
`define JMP_JC 3'b011   //jump if carry
`define JMP_JNC 3'b100  //jump if not carry

//ALU-MODES

`define ALU_ADD 3'b000
`define ALU_ADC 3'b001
`define ALU_SUB 3'b010
`define ALU_INC 3'b011
`define ALU_DEC 3'b100
`define ALU_AND 3'b101
`define ALU_OR 3'b110
`define ALU_XOR 3'b111

//CPU-REG

`define REG_A 3'b000
`define REG_B 3'b001
`define REG_C 3'b010
`define REG_D 3'b011
`define REG_E 3'b100
`define REG_F 3'b101
`define REG_G 3'b110
`define REG_H 3'b111