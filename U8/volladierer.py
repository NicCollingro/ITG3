import main
import time as t

x = 0
y = 0
cin = 0
start = t.time()
clock_delay = 0
clk = 0

s = main.WIRE()                        # die gates in die Liste gesteckt zum benutzen 8-134 (aufgabenstellung ???)
a1 = main.AND()                        # Problem liste lässt mich nichtmehr auf das objektr zugreifen ?????
o1 = main.OR()                         # logic gates maybe als funktion und nicht als klasse ?????
xo1 = main.XOR()                       
n1 = main.NOT()
s.add_and(a1)
s.add_or(o1)
s.add_xor(xo1)
s.add_not(n1)

def volladdierer(x,y ,cin):             #einfach den schaltvorgang vom Addierer verfolgt 
    b = s[0]                            #hab 2 und 2 xor und 1 oder gebraucht
    q = b.und2(x,y)                     #reg1 = 1stes und reg2 erstes xor von x,y 
    reg1 = main.REG(q)                  # reg 2 mit cin ge-and-ed und mit reg1 ge-oder't 
    b = s[2]                            #denn für q das reg2 mit dem cin ge xor-ed 
    q = b.xor2[x,y]                     #Problem von python unklar
    reg2 = main.REG(q)
    b = s[0]
    q = b.und2(cin,reg2.val)
    reg3 = main.REG(q)
    b = s[1]
    cout = b.oder2(reg3.val,reg1.val)
    b = s[3]
    q = b.xor2(reg2.val,cin)
    return q, cout

q, cout =(volladdierer(0,0,0))
print(q,cout)