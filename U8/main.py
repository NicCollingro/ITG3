import time as t
import math as m

clock_delay = 0 # Keine Ahnung wie ich diese positive flancke programmiere also hab ich einfach ne verzügerung eingebaut is
clk = 0         # zumindest physikalisch kein kompletter humbuk

def taktgenerator():
    x = 0
    while (x != 50000):
        x = x + 1
    if clk == 0:
        clk = 1
    else: clk == 0
        
def clock():
    x = 0        
    while (x != 50000):
        taktgenerator
        l=0
        while (l != 500): l = l + 1  # positive und negative flanke
        clock_delay = clk
         
class DL:
    def __init__(self):
        self.Q = 0

    def D_Latch(D, E, Q):
        if E == 0:
            return Q
        elif E == 1:
            Q = D
            return D
        else:
            return ValueError

class DFF():
    def __init__(self):
        self.Q = 0

    def flipflop(D ,clk, Q):
        if clk == 1 & clock_delay == 0:
            Q = D
            return D
        elif clk !=1 | clk != 0: return ValueError
        else:
            return Q
        
class WIRE:
    def __init__(self):
        self.liste = []
    
    def wire(self):
        return self.liste
    
    def add_and(self,und):
        self.liste.append(und)
        
    def add_or(self,oder):
        self.liste.append(oder)
        
    def add_xor(self,xor):
        self.liste.append(xor)
        
    def add_not(self,nicht):
        self.liste.append(nicht)

class REG:
    def __init__(self,val):
        self.val = val

    def reg(self,val):
        return val
########################################################################################################################
# Das hier ist 133 glaube das sollte alles sein
########################################################################################################################
class AND:
    
    def und2(self,x,y):
        if x == y:
            return x
        else:return 0
    
    def und3(self,x,y,z):
        if x == y & y == z:
            return x
        else:return 0

class OR:
    
    def oder2(self,x,y):
        if x != y:return 1
        else:
            if x == 1:
                return 1
            else: return 0

    def oder3(self,x,y,z):
        if x == y == z & x == 0:
            return x
        else: return 1
    
class XOR:
    
    def xor2(self,x,y):
        if x != y:
            return 1
        else:return 0

    def xor3(self,x,y,z):
        #TODO                            # unklar wie man 3 input xor-en soll bei 0 und 1 is ja dann immer falsch oder nicht ???
        pass
    
class NOT:
    def nicht(x):
        if x == 0:return 1
        else: return 0
        
class WIRE:
    def __init__(self):
        self.liste = []
    
    def wire(self):
        return self.liste
    
    def add_and(self,und):
        self.liste.append(und)
        
    def add_or(self,oder):
        self.liste.append(oder)
        
    def add_xor(self,xor):
        self.liste.append(xor)
        
    def add_not(self,nicht):
        self.liste.append(nicht)

class REG:
    def __init__(self,val):
        self.val = val

    def reg(self,val):
        return val

