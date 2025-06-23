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

JMP_JMP 3’b000 //unbedingter Sörung
JMP_JZ  3’b001 //jump if zero
JMP_JNZ 3’b010 //jump if not zero
JMP_JC  3’b011 //jump if carry
JMP_JNC 3’b100 //jump if not carry