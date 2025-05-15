import time as t
startTime = t.time()

# Zur idee hinter der Funktionsweise: Jedes Gate hat input und output Wires, die je nach Gate unterschiedlich voneinander abhängen.
# Dabei ist pegel 0 äquivalent zu False und pegel 1 äquivalent zu true werden aber hier als Zahlen dargestellt, die operationen dann gleich der Boolschen algebra ist. z.b. AND = a*b

class Wire:
    def __init__(self, p=0): #Init Func
        self.gates = []
        self.state = p

    def connect(self, wire): #Connect Func; writes list of wires connected to this, needed to make update func work
        self.gates.append(wire)

    def readState(self):
        return self.state

    def writeState(self, input):
        if self.state != input: #check if value is supposed to change
            self.state = input #change value
            for gate in self.gates: #execute update function of every gate connected to the wire
                gate.update() #update func

# Die Grundklasse des Wires ist damit implementiert und wir machen weiter mit den Gates. Da mehrpolige Gates einfach durch n Gates erstellt werden können, implementiere ich hier nur Gates mit max. 2 Inputs

class NOT:
    def __init__(self, inputWire, OutputWire):
        self.input = inputWire        #read input of input wire
        self.input.connect(self)
        self.output = OutputWire    #set start output
        self.update()

    def update(self):
        self.output.writeState((self.input.readState() - 1) % 2)

class AND:
    def __init__(self, inputWire1, inputWire2, OutputWire):
        self.input1 = inputWire1
        self.input2 = inputWire2
        self.output = OutputWire
        self.input1.connect(self)
        self.input2.connect(self)
        self.update()

    def update(self):
        self.output.writeState(self.input1.readState() * self.input2.readState())

class NAND:
    def __init__(self, inputWire1, inputWire2, OutputWire):
        self.input1 = inputWire1
        self.input2 = inputWire2
        self.output = OutputWire
        self.input1.connect(self)
        self.input2.connect(self)
        self.update()

    def update(self):
        self.output.writeState((self.input1.readState() * self.input2.readState() - 1) % 2)

class OR:
    def __init__(self, inputWire1, inputWire2, OutputWire):
        self.input1 = inputWire1
        self.input2 = inputWire2
        self.output = OutputWire
        self.input1.connect(self)
        self.input2.connect(self)
        self.output.connect(self)
        self.update()

    def update(self):
        if self.input1.readState() == 1 and self.input2.readState() == 1:
            self.output.writeState(1)
        else:
            self.output.writeState(self.input1.readState() + self.input2.readState())

class NOR:
    def __init__(self, inputWire1, inputWire2, OutputWire):
        self.input1 = inputWire1
        self.input2 = inputWire2
        self.output = OutputWire
        self.input1.connect(self)
        self.input2.connect(self)
        self.update()

    def update(self):
        if self.input1.readState() == 1 and self.input2.readState() == 1:
            self.output.writeState(0)
        else:
            self.output.writeState((self.input1.readState() + self.input2.readState() -1)%2)

class XOR:
    def __init__(self, inputWire1, inputWire2, OutputWire):
        self.input1 = inputWire1
        self.input2 = inputWire2
        self.output = OutputWire
        self.input1.connect(self)
        self.input2.connect(self)
        self.update()

    def update(self):
        self.output.writeState((self.input1.readState() + self.input2.readState()) % 2)

class DL:
    def __init__(self, D, E, Q):
        self.D = D
        self.E = E
        self.Q = Q
        self.E.connect(self)
        self.update()

    def update(self):
        if self.E.readState() == 1:
            self.Q.writeState(self.D.readState())

class DFF:
    def __init__(self, D, CLK, Q):
        self.D = D
        self.CLK = CLK
        self.Q = Q
        self.CLK.connect(self) #nur clock interessant da wenn sich d änder nichts passieren soll, außer clock änder sich
        self.update()

    def update(self):
        if self.CLK.readState() == 1:
            self.Q.writeState(self.D.readState())

#hier implementiere ich die Clock
def clock():
    return int((t.time() - startTime)/1000)%2 #Clock wechselt alle sekunde den pegel zwischen 0 und 1

#Check Code

D = Wire()
Clock = Wire()
Q = Wire()

DFF(D, Clock, Q)

for i in 0,1,0,1:
    for j in 0,1,1,0:
        D.writeState(i)
        Clock.writeState(j)
        print(str(i) + "\t" + str(j) + " | " + str(Q.readState()))