`define ALU_ADD      3'b000
`define ALU_ADC      3'b001
`define ALU_SUB      3'b010
`define ALU_INC      3'b011
`define ALU_DEC      3'b100
`define ALU_AND      3'b101
`define ALU_OR       3'b110
`define ALU_XOR      3'b111

`define CYCLE_CLK1   3'b001
`define RAM_CLK1     3'b010
`define INTERNAL_CLK 3'b100

`define JMP_JMP 3’b000 //unbedingter Sörung
`define JMP_JZ  3’b001 //jump if zero
`define JMP_JNZ 3’b010 //jump if not zero
`define JMP_JC  3’b011 //jump if carry
`define JMP_JNC 3’b100 //jump if not carry

`define PATTERN_NOP  (8’b00_000_000) 
`define PATTERN_HLT  (8’b00_000_001) 
`define PATTERN_CALL (8’b00_000_010)
`define PATTERN_RET  (8’b00_000_011) 
`define PATTERN_CMP  (8’b00_000_100) 
`define PATTERN_ALU  (8’b00_010_???) 
`define PATTERN_LDI  (8’b01_000_???) 
`define PATTERN_LDX  (8’b01_001_???) 
`define PATTERN_STX  (8’b01_010_???) 
`define PATTERN_PUSH (8’b01_011_???)
`define PATTERN_POP  (8’b01_100_???) 
`define PATTERN_JMP  (8’b01_101_???) 
`define PATTERN_MOV  (8’b10_???_???) 

`define OP_NOP  (8’b00_000_000)
`define OP_HLT  (8’b00_000_001)
`define OP_CALL (8’b00_000_010)
`define OP_RET  (8’b00_000_011)
`define OP_CMP  (8’b00_000_100)
`define OP_ALU  (8’b00_010_000)
`define OP_LDI  (8’b01_000_000)
`define OP_LDX  (8’b01_001_000)
`define OP_STX  (8’b01_010_000)
`define OP_PUSH (8’b01_011_000)
`define OP_POP  (8’b01_100_000)
`define OP_JMP  (8’b01_101_000)
`define OP_MOV  (8’b10_000_000)