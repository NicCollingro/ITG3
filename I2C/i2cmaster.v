module I2C_master (input wire CLOCK_50, inout wire sda, output wire scl, input wire send, output reg busy = 0,
input wire [6:0] addr, input wire [7:0] data , input wire rw);
reg sda_oe = 1, sda_r = 1, clk, scl_r = 1;
reg [20:0] help;
assign sda = sda_oe ? sda_r : 1'bz;
assign scl = scl_r;
always @(posedge CLOCK_50) begin
    help <= help + 1;
    clk <= help[1];
end
reg [7:0] zustand = 8'd0;
reg send_old;
reg check = 0;
always @(posedge clk) begin
    if (send == 1) begin
        check <= 1'd1;
    end
        if (check == 1) begin
        case (zustand)
        8'd0: begin
            busy <= 1;
            sda_oe = 1;
            sda_r <= 1;
            scl_r <= 1;
            zustand <= zustand +1;
        end 

        8'd1: begin
            sda_r <= 0;
            scl_r <= 1;
            zustand <= zustand +1;
        end

        8'd2: begin
            sda_r <= 0;
            scl_r <= 0;
            zustand <= zustand +1;
        end

        8'd3: begin
                sda_r <= addr[6];
                scl_r <= 0;
                zustand <= zustand +1;
            
        end
        
        8'd4: begin
            sda_r <= addr[6];
            scl_r <= 1;
            zustand <= zustand +1;
        end

        8'd5: begin
            sda_r <= 0;
            scl_r <= 0;
            zustand <= zustand +1;
        end

        8'd6: begin
            sda_r <= addr[5];
            scl_r <= 0;
            zustand <= zustand +1;
        end
        
        8'd7: begin
            sda_r <= addr[5];
            scl_r <= 1;
            zustand <= zustand +1;
        end
        //
        8'd8: begin
            sda_r <= 0;
            scl_r <= 0;
            zustand <= zustand +1;
        end

        8'd9: begin
            sda_r <= addr[4];
            scl_r <= 0;
            zustand <= zustand +1;
        end
        
        8'd10: begin
            sda_r <= addr[4];
            scl_r <= 1;
            zustand <= zustand +1;
        end
        //10
        8'd11: begin
            sda_r <= 0;
            scl_r <= 0;
            zustand <= zustand +1;
        end

        8'd12: begin
            sda_r <= addr[3];
            scl_r <= 0;
            zustand <= zustand +1;
        end
        
        8'd13: begin
            sda_r <= addr[3];
            scl_r <= 1;
            zustand <= zustand +1;
        end
        //13
        8'd14: begin
            sda_r <= 0;
            scl_r <= 0;
            zustand <= zustand +1;
        end

        8'd15: begin
            sda_r <= addr[2];
            scl_r <= 0;
            zustand <= zustand +1;
        end
        
        8'd16: begin
            sda_r <= addr[2];
            scl_r <= 1;
            zustand <= zustand +1;
        end
        //16
        8'd17: begin
            sda_r <= 0;
            scl_r <= 0;
            zustand <= zustand +1;
        end

        8'd18: begin
            sda_r <= addr[1];
            scl_r <= 0;
            zustand <= zustand +1;
        end
        
        8'd19: begin
            sda_r <= addr[1];
            scl_r <= 1;
            zustand <= zustand +1;
        end
        //19
        8'd20: begin
            sda_r <= 0;
            scl_r <= 0;
            zustand <= zustand +1;
        end

        8'd21: begin
            sda_r <= addr[0];
            scl_r <= 0;
            zustand <= zustand +1;
        end
        
        8'd22: begin
            sda_r <= addr[0];
            scl_r <= 1;
            zustand <= zustand +1;
        end
        //22
        8'd23: begin
            sda_r <= 0;
            scl_r <= 0;
            zustand <= zustand +1;
        end

        8'd24: begin
            if (rw) begin
                sda_r <= 1;
                scl_r <= 0;
                zustand <= zustand +1;
            end else begin
                sda_r <= 0;
                scl_r <= 0;
                zustand <= zustand +1;
            end
        end
        
        8'd25: begin
            if (rw) begin
                sda_r <= 0;
                scl_r <= 1;
                zustand <= zustand +1;
            end else begin
                sda_r <= 0;
                scl_r <= 1;
                zustand <= zustand +1;
            end
        end
        //ak
        8'd26: begin
            sda_r <= 0;
            scl_r <= 0;
            zustand <= zustand +1;
        end

        8'd27: begin
            sda_oe <= 0;
            scl_r <= 0;
            zustand <= zustand +1;
        end
        
        8'd28: begin
            scl_r <= 1;
            if (sda) begin
                zustand <= 8'd0;
            end else begin
                zustand <= zustand +1;
            end
            sda_oe <= 1;
        end
        //data
        8'd29: begin
            sda_r <= 0;
            scl_r <= 0;
            zustand <= zustand +1;
        end

        8'd30: begin
            if (rw == 0) begin
            sda_r <= data[7];
            scl_r <= 0;
            zustand <= zustand +1;
        end
        end
        
        8'd31: begin
            if (rw == 0) begin
            sda_r <= data[7];
            scl_r <= 1;
            zustand <= zustand +1;
            end
        end
        //37
        8'd32: begin
            sda_r <= 0;
            scl_r <= 0;
            zustand <= zustand +1;
        end

        8'd33: begin
            if (rw == 0) begin
            sda_r <= data[6];
            scl_r <= 0;
            zustand <= zustand +1;
        end
        end
        
        8'd34: begin
            if (rw == 0) begin
            sda_r <= data[6];
            scl_r <= 1;
            zustand <= zustand +1;
            end
        end

        8'd35: begin
            sda_r <= 0;
            scl_r <= 0;
            zustand <= zustand +1;
        end

        8'd36: begin
            if (rw == 0) begin
            sda_r <= data[5];
            scl_r <= 0;
            zustand <= zustand +1;
        end
        end
        
        8'd37: begin
            if (rw == 0) begin
            sda_r <= data[5];
            scl_r <= 1;
            zustand <= zustand +1;
            end
        end

        8'd38: begin
            sda_r <= 0;
            scl_r <= 0;
            zustand <= zustand +1;
        end

        8'd39: begin
            if (rw == 0) begin
            sda_r <= data[4];
            scl_r <= 0;
            zustand <= zustand +1;
        end
        end
        
        8'd40: begin
            if (rw == 0) begin
            sda_r <= data[4];
            scl_r <= 1;
            zustand <= zustand +1;
            end
        end
        8'd41: begin
            sda_r <= 0;
            scl_r <= 0;
            zustand <= zustand +1;
        end

        8'd42: begin
            if (rw == 0) begin
            sda_r <= data[3];
            scl_r <= 0;
            zustand <= zustand +1;
        end
        end
        
        8'd43: begin
            if (rw == 0) begin
            sda_r <= data[3];
            scl_r <= 1;
            zustand <= zustand +1;
            end
        end

        8'd44: begin
            sda_r <= 0;
            scl_r <= 0;
            zustand <= zustand +1;
        end

        8'd45: begin
            if (rw == 0) begin
            sda_r <= data[2];
            scl_r <= 0;
            zustand <= zustand +1;
        end
        end
        
        8'd46: begin
            if (rw == 0) begin
            sda_r <= data[2];
            scl_r <= 1;
            zustand <= zustand +1;
            end
        end

        8'd47: begin
            sda_r <= 0;
            scl_r <= 0;
            zustand <= zustand +1;
        end

        8'd48: begin
            if (rw == 0) begin
            sda_r <= data[1];
            scl_r <= 0;
            zustand <= zustand +1;
        end
        end
        
        8'd49: begin
            if (rw == 0) begin
            sda_r <= data[1];
            scl_r <= 1;
            zustand <= zustand +1;
            end
        end

        8'd50: begin
            sda_r <= 0;
            scl_r <= 0;
            zustand <= zustand +1;
        end

        8'd51: begin
            if (rw == 0) begin
            sda_r <= data[0];
            scl_r <= 0;
            zustand <= zustand +1;
        end
        end
        
        8'd52: begin
            if (rw == 0) begin
            sda_r <= data[0];
            scl_r <= 1;
            zustand <= zustand +1;
            end
        end

        8'd53: begin
            sda_oe <= 1;
            sda_r <= 0;
            scl_r <= 0;
            zustand <= zustand + 1;
        end

        8'd54: begin
            scl_r <= 1;
            sda_r <= 0;
            zustand <= zustand + 1;
        end
        
        8'd55: begin
            scl_r <= 1;
            sda_r <= 1;
            zustand <= zustand +1;
        end

        8'd56: begin
            busy <= 0;
            check <= 0;
        end

        default: begin
            zustand <= zustand + 1;
            busy <= 0;
            check <= 0;
        end
        endcase
    end
end
endmodule