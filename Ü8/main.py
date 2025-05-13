import numpy as np
import time as t 

Q_Global_D_Latch = 0
Q_Global_D_FlipFlop = 0
clock_delay = 0
clk = 0
zp = 0

class bauelement:
    def D_Latch(self,D, E):
        if E == 0:
            return Q_Global_D_Latch
        elif E == 1:
            Q_Global_D_Latch = D
            return D
        else:
            return ValueError
    def D_FlipFlop(self,D, clk):
        if clock_delay == 0 & clk == 1:
            Q_Global_D_FlipFlop = D
            return D
        elif D != 1 | D!= 0:
            return ValueError
        else:
            return Q_Global_D_FlipFlop
        
class wire:
    def wire(self,state):
        if state == 0:
            return True
        elif state == 1:
            return False
        else:
            return ValueError
    
class register:
    def register(val):
      zp = val