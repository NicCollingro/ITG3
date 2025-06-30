
`include "symbols.vh"

module computer(
  input  wire 		clk,		// external control
  input  wire 		reset,
  input  wire[7:0]	iport,
  output wire[7:0]	oport
);


  ////////////////////
  // Signal-Control //
  ////////////////////
  wire[7:0] state;
  wire[2:0] operand1;
  wire[2:0] operand2;
  wire flag_zero;
  wire flag_carry;
  wire c_da;				// Dekoder
  wire c_ri, c_ro;			// RAM
  wire c_ii;				// IR
  wire c_rfi, c_rfo;			// CPU-Registerblock
  wire c_mi;				// MAR
  wire c_co, c_ci, c_cs;			// PC
  wire c_si, c_sd, c_so;		// SP
  wire c_eo, c_ee;			// ALU
  wire c_gi, c_go;			// GPIO
  wire c_halt;				// Machine

  control ctrl0(
    .state	(state),
    .operand1   (operand1),
    .operand2   (operand2),
    .flag_zero  (flag_zero),
    .flag_carry (flag_carry),
    .c_halt     (c_halt),
    .c_da	(c_da),
    .c_ro       (c_ro),			
    .c_ri       (c_ri),			
    .c_ii       (c_ii),
    .c_rfi      (c_rfi),
    .c_rfo      (c_rfo),
    .c_mi       (c_mi),
    .c_ci       (c_ci),
    .c_co       (c_co),
    .c_cs        (c_cs),
    .c_so       (c_so),
    .c_sd       (c_sd),
    .c_si       (c_si),
    .c_eo       (c_eo),
    .c_ee       (c_ee),
    .c_gi	(c_gi),
    .c_go	(c_go)
  );


  /////////////////////
  // Command-Decoder //
  /////////////////////
  wire[7:0] instruction;
  wire[7:0] opcode;
  wire[2:0] iaddr;
  wire[2:0] oaddr;
  wire[3:0] alu_mode;
  
  decoder dcdr0(
    .instruction(instruction),
    .c_da       (c_da),
    .operand1   (operand1),
    .operand2   (operand2),
    .opcode	(opcode),
    .iaddr	(iaddr),
    .oaddr      (oaddr),
    .alu_mode   (alu_mode)
  );


  ////////////
  // Clocks //
  ////////////
  wire cycle_clk, ram_clk, internal_clk;

  clocks clk0(
    .clk	(clk),
    .reset	(reset),
    .halt	(c_halt),
    .cycle_clk	(cycle_clk),
    .ram_clk	(ram_clk),
    .internal_clk(internal_clk)
  );


  ///////////
  // Busse //
  //////////
  wire[7:0]	data_bus;
  wire[7:0]	addr_bus;
  wire[7:0] 	rega_out;
  wire[7:0] 	regb_out;

  assign data_bus = 8'bz;
  
  
  //////////
  //  RAM //
  //////////
  ram ram0(
    .clk	(ram_clk),
    .addr	(addr_bus),
    .data_bus	(data_bus),
    .we		(c_ri),
    .oe		(c_ro)
  );


  ///////////////////
  // GPIO-Register //
  ///////////////////
  buffer in0(
    .clk	(ram_clk),
    .in 	(iport),
    .we		(1'b1),			//XXX
    .oe		(c_gi),
    .out	(data_bus)
  );

  register out0(
    .clk	(internal_clk),
    .in		(data_bus),
    .en		(c_go),
    .out	(oport)
  );


  /////////////////
  // Register IR //
  /////////////////
  register instr_reg0(
    .clk 	(internal_clk),
    .in	 	(data_bus),
    .en	 	(c_ii),
    .out 	(instruction)
  );


  /////////
  // FSM //
  /////////
  fsm fsm0(
    .clk	(cycle_clk),
    .opcode	(opcode),
    .state	(state),
    .reset      (reset)
  );


  ///////////////////////
  // CPU Registerblock //
  ///////////////////////
  regblock cpu_reg0(
    .clk	(internal_clk),
    .we		(c_rfi),
    .oe		(c_rfo),
    .iaddr	(iaddr),
    .oaddr	(oaddr),
    .idata	(data_bus),
    .odata	(data_bus),
    .rega	(rega_out),
    .regb	(regb_out)
  );


  //////////////////
  // Register MAR //
  //////////////////
  register mar_reg0(
    .clk	(internal_clk),
    .in		(data_bus),
    .en		(c_mi),
    .out	(addr_bus)
  );


  ////////////////
  // Counter PC //
  ////////////////
  counter pc_cnt0(
    .clk	(c_ci & internal_clk),	// increment 
    .oe		(c_co),			// output latch enable
    .in		(data_bus),		// set pc_counter on...
    .set	(c_cs),			// ...set==1
    .reset	(reset),		// reset
    .down	(1'b0),			// up/down
    .out	(data_bus)		// pc_counter out
  );


  ////////////////
  // Counter SP //
  ////////////////
  counter sp_cnt0(
    .clk	(c_si & internal_clk),
    .oe		(c_so),
    .in		(8'hFF),
    .set	(reset),
    .reset	(1'b0),
    .down	(c_sd),
    .out	(data_bus)
  );


  /////////
  // ALU //
  /////////
  alu alu0(
    .ee		(c_ee),			// enable exec für 'cmp'
    .eo		(c_eo),			// enable out für alle außer 'cmp'
    .in_a	(rega_out),
    .in_b	(regb_out),
    .out	(data_bus),
    .mode	(alu_mode),
    .flag_zero	(flag_zero),
    .flag_carry	(flag_carry)
  );

endmodule
