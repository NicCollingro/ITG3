`include "symbols.vh"

module alu(
  input  wire 		ee,		// execute evaluation w/o output
  input  wire 		eo,		// output latch 
  input  wire[3:0] 	mode,		// instruction
  input  wire[7:0] 	in_a,		// 1. operand
  input  wire[7:0] 	in_b,		// 2. operand
  output wire[7:0]	out,		// result
  output reg 		flag_zero,	// zero flag
  output reg 		flag_carry  	// carry flag
);

  reg[7:0] r_out = 8'b0;
  assign out = (eo) ? r_out : 8'bz;

  // ALU in kombinatorischer Logik
  always @* begin
    if (ee) begin
      case (mode)
        `ALU_ADD:  {flag_carry, r_out} = in_a + in_b;
        `ALU_ADC:  {flag_carry, r_out} = in_a + in_b + flag_carry;
        `ALU_SUB:  {flag_carry, r_out} = in_a - in_b;
        `ALU_INC:  {flag_carry, r_out} = in_a + 1'b1;
        `ALU_DEC:  {flag_carry, r_out} = in_a - 1'b1;
        `ALU_AND:  r_out               = in_a & in_b;
        `ALU_OR:   r_out 	       = in_a | in_b;
        `ALU_XOR:  r_out  	       = in_a ^ in_b;
        `ALU_SHL:  r_out  	       = in_a << in_b;
        `ALU_SHR:  r_out  	       = in_a >> in_b;
        `ALU_ROL:  r_out  	       = {in_a[6:0], in_a[7]};
        `ALU_ROR:  r_out  	       = {in_a[0], in_a[7:1]};
        `ALU_NOT:  r_out  	       = ~in_a;
        `ALU_MLO:  {flag_carry, r_out} = {mcry, prod_lo};
        `ALU_MHI:  {flag_carry, r_out} = {mcry, prod_hi};
        `ALU_SQRT: r_out  	       = sqrt_lo;
        default:   r_out               = 8'hx;                      
      endcase
      flag_zero <= (r_out == 8'b0) ? 1'b1 : 1'b0;
    end
  end


  // Kombinatorische Multiplikation
  wire[7:0] prod_lo, prod_hi;
  wire mcry;
  mul mul0(
    .in_a(in_a),
    .in_b(in_b),
    .out_lo(prod_lo),
    .out_hi(prod_hi),
    .carry(mcry)
  );

  // Kombinatorisches SQRT
  wire[7:0] sqrt_lo;
  sqrt sqrt0(
    .in(in_a),
    .out(sqrt_lo)
  );

endmodule
