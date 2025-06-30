module top_level_tb;

  // Clock
  reg clk = 1;
  always 
    #20 clk = ~clk;

  // Machine
  reg reset = 1;
  reg[7:0]  iport = 8'h0;
  wire[7:0] oport;
  computer m5(
    .clk(clk),
    .reset(reset),
    .iport(iport),
    .oport(oport)
  );

  // iport test
  always 
    #630 iport = iport + 1;
    
  always @(posedge m5.c_halt) begin
    $display("============================================");
    $display("CPU halted normally.");
    $display(
      "REGISTERS: A: %h B: %h C: %h D: %h E: %h F: %h G: %h H: %h\nFLAGS:     CF: %b ZF: %b",
      m5.cpu_reg0.registers[0],
      m5.cpu_reg0.registers[1],
      m5.cpu_reg0.registers[2],
      m5.cpu_reg0.registers[3],
      m5.cpu_reg0.registers[4],
      m5.cpu_reg0.registers[5],
      m5.cpu_reg0.registers[6],
      m5.cpu_reg0.registers[7],
      m5.flag_carry,
      m5.flag_zero
    );
    $finish;
  end

  always 
    @(negedge m5.internal_clk) begin
      if (m5.c_go)
        $display("%8d OUTPUT: %3d (0x%2h 0b%8b)", $time, oport, oport, oport);
      if (m5.c_gi)
        $display("%8d INPUT:  %3d (0x%2h 0b%8b)", $time, iport, iport, iport);
    end

/*
  always @(posedge m5.ram0.clk) begin
    if (m5.ram0.we) begin
      $display("%0d MEMORY: set [0x%h] => 0x%h (%d)", $time, m5.ram0.addr, m5.ram0.data_bus, m5.ram0.data_bus);
    end else begin
//      $display("MEMORY: get [0x%h] => 0x%h (%d)", m5.ram0.addr, m5.ram0.data, m5.ram0.data);
    end
  end
*/


  always @* begin
 //            1 2  3  4  5  6  7   8  9  10 11 12 13 14 15 16 17 18 19  20 21  22 23 24 25 26 27 28 30
    $display("%0d %b %b %b %b %b %0d %b %b %b %b %b %b %b %b %b %b %b %0d %b %0d %b %b %b %b %b %b %b %b Sig", 
      $time, 			// 1
      { 			// 2
        m5.internal_clk,
        m5.ram_clk, 
        m5.cycle_clk, 
        m5.clk
      }, 
      m5.data_bus, 		// 3
      m5.addr_bus,		// 4
      {				// 5
        m5.c_ri,
        m5.c_ro
      },
      m5.fsm0.reset_cycle,	// 6
      m5.fsm0.cycle,		// 7
      {				// 8
        m5.c_ci,
        m5.c_co,
        m5.c_cs
      },
      {				// 9
        m5.c_rfi,
        m5.c_rfo
      },
      m5.iaddr,			// 10
      m5.oaddr,			// 11
      m5.c_ii,			// 12
      m5.instruction,		// 13
      m5.rega_out,		// 14
      m5.regb_out,		// 15
      m5.c_mi,			// 16
      {				// 17
        m5.c_si,		
        m5.c_so,
        m5.c_sd
      },
      {				// 18
        m5.flag_zero,
        m5.flag_carry
      },
      m5.alu_mode,		// 19
      {				// 20
        m5.c_eo,
        m5.c_ee
      },
      m5.state,			// 21
      m5.opcode,		// 22
      {				// 23
        reset,
        m5.c_halt
      },
      {				// 24
        m5.c_gi,
        m5.c_go
      },
      m5.iport,			// 25
      m5.oport,			// 26
      m5.pc_cnt0.r_out,		// 27
      m5.sp_cnt0.r_out,		// 28
      m5.cpu_reg0.registers[7]	// 29
    );
  end

/*
  always begin
    #10 
    $display("%0d %b DB=%h AD=%h %b I=%0d OC=%0d %b IN=%h %b OUT=%h %b MEM=%h BU=%h S=%0d", 
      $time, 			
      { 			// 2
        m5.internal_clk,
        m5.ram_clk, 
        m5.cycle_clk, 
        m5.clk
      }, 
      m5.data_bus, 		
      m5.addr_bus,		
      m5.c_rfo,
      m5.instruction,	
      m5.opcode,
      m5.c_gi,
      iport,
      m5.c_go,
      oport,
      {
        m5.c_ri,
        m5.c_ro
      },
      m5.ram0.mem[3],
      m5.in0.buffer,
      m5.state
    );
  end
*/

  initial begin
//#0      m5.cpu_reg0.registers[0] = 8'ha5;
//        m5.cpu_reg0.registers[1] = 5;
    @(negedge clk) reset = 0;
//    #100 iport = 8'ha5;
  end
endmodule

              