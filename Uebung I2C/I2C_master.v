module I2C_master(input wire clk, inout wire sda, input wire scl, input wire send, output wire busy, input wire [6:0] addr, input wire [7:0] data, input wire rw);
    reg sda_oe, sda_r, scl_r;
    assign sda = sda_oe ? sda_r : 1'bz;
    reg [8:0] clk_safe;
    reg i2c_clk;
    reg [6:0] statec = 0;

    always @(posedge clk) begin
        i2c_clk = 0;
        clk_safe = clk + 1;
        if (clk_safe == 500) begin
            i2c_clk = 1;
            clk_safe = 0;
        end 
    end

    always @(posedge i2c_clk) begin
        case(state)
            // Startcondition (optional, falls du sie brauchst)
            7'd0: begin sda_oe = 1; sda_r <= 1; scl_r <= 1; state = state + 1; end
            7'd1: begin sda_oe = 1; sda_r <= 0; scl_r <= 1; state = state + 1; end
            7'd2: begin sda_oe = 1; sda_r <= 0; scl_r <= 0; state = state + 1; end
            7'd3: begin sda_oe = 1; sda_r <= 0; state = state + 1; end // SDA bleibt 0 für erstes Bit

            // Adresse: 0 0 1 1 0 1 0
            // Bit 1: 0
            7'd4: begin sda_r <= addr[6]; scl_r <= 0; state = state + 1; end
            7'd5: begin scl_r <= 1; state = state + 1; end
            7'd6: begin scl_r <= 0; state = state + 1; end
            7'd7: begin sda_r <= 0; state = state + 1; end

            // Bit 2: 0
            7'd8: begin sda_r <= addr[5]; scl_r <= 0; state = state + 1; end
            7'd9: begin scl_r <= 1; state = state + 1; end
            7'd10: begin scl_r <= 0; state = state + 1; end
            7'd11: begin sda_r <= 0; state = state + 1; end

            // Bit 3: 1
            7'd12: begin sda_r <= addr[4]; scl_r <= 0; state = state + 1; end
            7'd13: begin scl_r <= 1; state = state + 1; end
            7'd14: begin scl_r <= 0; state = state + 1; end
            7'd15: begin sda_r <= 1; state = state + 1; end

            // Bit 4: 1
            7'd16: begin sda_r <= addr[3]; scl_r <= 0; state = state + 1; end
            7'd17: begin scl_r <= 1; state = state + 1; end
            7'd18: begin scl_r <= 0; state = state + 1; end
            7'd19: begin sda_r <= 1; state = state + 1; end

            // Bit 5: 0
            7'd20: begin sda_r <= addr[2]; scl_r <= 0; state = state + 1; end
            7'd21: begin scl_r <= 1; state = state + 1; end
            7'd22: begin scl_r <= 0; state = state + 1; end
            7'd23: begin sda_r <= 0; state = state + 1; end

            // Bit 6: 1
            7'd24: begin sda_r <= addr[1]; scl_r <= 0; state = state + 1; end
            7'd25: begin scl_r <= 1; state = state + 1; end
            7'd26: begin scl_r <= 0; state = state + 1; end
            7'd27: begin sda_r <= 1; state = state + 1; end

            // Bit 7: 0
            7'd28: begin sda_r <= addr[0]; scl_r <= 0; state = state + 1; end
            7'd29: begin scl_r <= 1; state = state + 1; end
            7'd30: begin scl_r <= 0; state = state + 1; end
            7'd31: begin sda_r <= 0; state = state + 1; end

            //rw
            7'd32: begin sda_r <= rw; scl_r <=0; state = state + 1; end
            7'd33: begin scl_r <= 1; state = state + 1; end
            7'd34: begin scl_r <= 0; state = state + 1; end
            7'd35: begin sda_r <= 0; state = state + 1; end

            //AKN
            7'd36: begin sda_oe = 0; scl_r <= 0; state = state + 1; end
            7'd37: begin scl_r <= 1; state = state + 1; end
            7'd38: begin scl_r <= 0; state = state + 1; end
            7'd39: begin sda_oe <= 1; state = state + 1; end

            //DATA
            // Bit 1: 1
            7'd40: begin sda_r <= data[7]; scl_r <= 0; state = state + 1; end
            7'd41: begin scl_r <= 1; state = state + 1; end
            7'd42: begin scl_r <= 0; state = state + 1; end
            7'd43: begin sda_r <= 0; state = state + 1; end

            // Bit 2: 0
            7'd44: begin sda_r <= data[6]; scl_r <= 0; state = state + 1; end
            7'd45: begin scl_r <= 1; state = state + 1; end
            7'd46: begin scl_r <= 0; state = state + 1; end
            7'd47: begin sda_r <= 0; state = state + 1; end

            // Bit 3: 1
            7'd48: begin sda_r <= data[5]; scl_r <= 0; state = state + 1; end
            7'd49: begin scl_r <= 1; state = state + 1; end
            7'd50: begin scl_r <= 0; state = state + 1; end
            7'd51: begin sda_r <= 1; state = state + 1; end

            // Bit 4: 0
            7'd52: begin sda_r <= data[4]; scl_r <= 0; state = state + 1; end
            7'd53: begin scl_r <= 1; state = state + 1; end
            7'd54: begin scl_r <= 0; state = state + 1; end
            7'd55: begin sda_r <= 1; state = state + 1; end

            // Bit 5: 0
            7'd56: begin sda_r <= data[3]; scl_r <= 0; state = state + 1; end
            7'd57: begin scl_r <= 1; state = state + 1; end
            7'd58: begin scl_r <= 0; state = state + 1; end
            7'd59: begin sda_r <= 0; state = state + 1; end

            // Bit 6: 1
            7'd60: begin sda_r <= data[2]; scl_r <= 0; state = state + 1; end
            7'd61: begin scl_r <= 1; state = state + 1; end
            7'd62: begin scl_r <= 0; state = state + 1; end
            7'd63: begin sda_r <= 1; state = state + 1; end

            // Bit 7: 0
            7'd64: begin sda_r <= data[1]; scl_r <= 0; state = state + 1; end
            7'd65: begin scl_r <= 1; state = state + 1; end
            7'd66: begin scl_r <= 0; state = state + 1; end
            7'd67: begin sda_r <= 0; state = state + 1; end
            
            // Bit 8: 1
            7'd68: begin sda_r <= data[0]; scl_r <= 0; state = state + 1; end
            7'd69: begin scl_r <= 1; state = state + 1; end
            7'd70: begin scl_r <= 0; state = state + 1; end
            7'd71: begin sda_r <= 0; state = state + 1; end
            
            //
            7'd72: begin scl_r <= 1; state = state + 1; end
            7'd73: begin sda_r <= 1; state = state + 1; end
        endcase

    end
endmodule