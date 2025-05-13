import numpy as np
import time as t

clock_delay = 0
clk = 0

class DL:
    def __init__(self,D,E):
        self.D = D
        self.E = E
        Q = 0

    def D_Latch(self,D, E,Q):
        if E == 0:
            return Q
        elif E == 1:
            Q = D
            return D
        else:
            return ValueError

class DFF():
    def __init__(self,D,clk):
        self.D = D
        self.clk = clk
        Q = 0
         
    def flipflop(self,D ,clk, Q):
        if clk == 1 & clock_delay == 0:
            Q = D
            return D
        else:
            return Q

class wire:
    def wire(self,state):
        if state == 0:
            return True
        elif state == 1:
            return False
        else:
            return ValueError
    

      
def main():
    B1 = DL(1, 1)
    return

