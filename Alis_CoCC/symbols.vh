`define ALU_ADD      (4'b0000)
`define ALU_ADC      (4'b0001)
`define ALU_SUB      (4'b0010)
`define ALU_INC      (4'b0011)
`define ALU_DEC      (4'b0100)
`define ALU_AND      (4'b0101)
`define ALU_OR       (4'b0110)
`define ALU_XOR      (4'b0111)
`define ALU_SQRT     (4'b1000)
`define ALU_SHL      (4'b1001)
`define ALU_SHR      (4'b1010)
`define ALU_ROL      (4'b1011)
`define ALU_ROR      (4'b1100)
`define ALU_NOT      (4'b1101)


`define REG_A        (3'b000)
`define REG_H        (3'b111)

`define CYCLE_CLK1   (3'b001)
`define RAM_CLK1     (3'b010)
`define INTERNAL_CLK (3'b100)

`define JMP_JMP (3'b000) //unbedingter Sörung
`define JMP_JZ  (3'b001) //jump if zero
`define JMP_JNZ (3'b010) //jump if not zero
`define JMP_JC  (3'b011) //jump if carry
`define JMP_JNC (3'b100) //jump if not carry

`define PATTERN_NOP  (8'b00_000_000) 
`define PATTERN_HLT  (8'b00_000_001) 
`define PATTERN_CALL (8'b00_000_010)
`define PATTERN_RET  (8'b00_000_011) 
`define PATTERN_CMP  (8'b00_000_100) 
`define PATTERN_ALU  (8'b00_01?_???) 
`define PATTERN_LDA  (8'b00_100_???)
`define PATTERN_STA  (8'b01_101_???)
`define PATTERN_LDI  (8'b01_000_???) 
`define PATTERN_LDX  (8'b01_001_???) 
`define PATTERN_STX  (8'b01_010_???) 
`define PATTERN_PUSH (8'b01_011_???)
`define PATTERN_POP  (8'b01_100_???) 
`define PATTERN_JMP  (8'b01_101_???) 
`define PATTERN_MOV  (8'b10_???_???) 


`define OP_NOP  (8'b00_000_000)
`define OP_HLT  (8'b00_000_001)
`define OP_CALL (8'b00_000_010)
`define OP_RET  (8'b00_000_011)
`define OP_CMP  (8'b00_000_100)
`define OP_ALU  (8'b00_010_000)
`define OP_LDA  (8'b00_100_000)
`define OP_STA  (8'b00_101_000)
`define OP_LDI  (8'b01_000_000)
`define OP_LDX  (8'b01_001_000)
`define OP_STX  (8'b01_010_000)
`define OP_PUSH (8'b01_011_000)
`define OP_POP  (8'b01_100_000)
`define OP_JMP  (8'b01_101_000)
`define OP_MOV  (8'b10_000_000)


`define STATE_NEXT             8'h00
`define STATE_HALT             8'h01
`define STATE_FETCH_PC         8'h02
`define STATE_FETCH_INST       8'h03
`define STATE_MOV_REG          8'h04
`define STATE_LOAD_ADDR        8'h05		
`define STATE_SET_MAR          8'h06
`define STATE_SET_REG          8'h07		
`define STATE_SET_MEM          8'h08		
`define STATE_ALU_EXEC         8'h09
`define STATE_ALU_OUT          8'h0a
`define STATE_JUMP             8'h0b
`define STATE_FETCH_SP         8'h0c
`define STATE_STORE_PC         8'h0d
`define STATE_TMP_JUMP         8'h0e
`define STATE_INC_SP           8'h0f
`define STATE_RET              8'h10
`define STATE_STACK_REG        8'h11

`define T0 3'b000
`define T1 3'b001
`define T2 3'b010
`define T3 3'b011
`define T4 3'b100
`define T5 3'b101
`define T6 3'b110
`define T7 3'b111