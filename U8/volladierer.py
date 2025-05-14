import main
import time as t

x = 0
y = 0
cin = 0
start = t.time()
clock_delay = 0
clk = 0

s = main.WIRE()
a1 = main.AND()
o1 = main.OR()
xo1 = main.XOR()
n1 = main.NOT()
s.add_and(a1)
s.add_or(o1)
s.add_xor(xo1)
s.add_not(n1)

def volladdierer(x,y ,cin):
    b = s[0]
    q = b.und2(x,y)
    reg1 = main.REG(q)
    b = s[2]
    q = b.xor2[x,y]
    reg2 = main.REG(q)
    b = s[0]
    q = b.und2(cin,reg2)
    reg3 = main.REG(q)
    b = s[1]
    cout = b.oder2(reg3,reg1)
    b = s[3]
    q = b.xor2(reg2,cin)
    return q, cout

q, cout =(volladdierer(0,0,0))
print(q,cout)