import time as t
import math as m

start = t.time()
clock_delay = 0
clk = 0

class DL:
    def __init__(self, D, E):
        self.D = D
        self.E = E
        Q = 0

    def D_Latch(D, E, Q):
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

    def flipflop(D ,clk, Q):
        if clk == 1 & clock_delay == 0:
            Q = D
            return D
        elif clk !=1 | clk != 0: return ValueError
        else:
            return Q

class WIRE:
    def __init__(self,state):
        self.state = state
    
    def wire(state):
        return state

class REG:
    def __init__(self,val):
        self.val = val

    def reg(self,val):
        return val
    
class AND:
    def __init__(self, x,y,z):
        self.x = x
        self.y = y
        self.z = z
    
    def und2(x,y):
        if x == y:
            return x
        else:return 0
    
    def und3(x,y,z):
        if x == y & y == z:
            return x
        else:return 0

class OR:
    def __init__(self,x,y,z):
        self.x = x
        self.y = y

    def oder2(x,y):
        if x == y & x == 0:
            return x
        else: return 1

    def oder3(x,y,z):
        if x == y == z & x == 0:
            return x
        else: return 1
    
class XOR:
    def __init__(self,x,y,z):
        self.x = x
        self.y = y
        self.z = z
    
    def xor2(x,y):
        if x != y:
            return 1
        else:return 0

    def xor3(x,y,z):
        #TODO
        pass
    
class NOT:
    def __init__(self,x):
        this.x = x

    def nicht(x):
        if x == 0:return 1
        else: return 0
