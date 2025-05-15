#Da wir in 8-133 die vorarbeit geleistet haben, muss ich den code nur copy paste und dann noch den Volladdierer Implementieren

import time as t

#CODE aus 8-133
class Wire:
    def __init__(self, p=0):
        self.gates = []
        self.state = p
    def connect(self, wire):
        self.gates.append(wire)
    def readState(self):
        return self.state
    def writeState(self, input):
        if self.state != input:
            self.state = input
            for gate in self.gates:
                gate.update()

class NOT:
    def __init__(self, inputWire, OutputWire):
        self.input = inputWire
        self.input.connect(self)
        self.output = OutputWire
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

startTime = t.time()

def clock():
    return int((t.time() - startTime)/1000)%2
