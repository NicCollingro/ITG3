class TuringMachine ():
    def __init__ (self, qi, qh, delta):
        self.qi = qi
        self.qh = qh
        self.delta = delta
        self.tape = []
        self.tpos = 0

    def write_tape (self, w, d) :
        self.tape [self.tpos] = w
        if d == 'R':
            self.tpos += 1
            if len(self.tape) <= self.tpos: self.tape.append('_')
        else :
            self.tpos -= 1
            if self.tpos < 0:
                self.tape.insert(0, '_') 
                self.tpos = 0

    def printer (self, q):
        if self.tpos > 0:
            print ( ' ' + ' '. join (self.tape[0: self.tpos]) + ' [ ' + self.tape [self.tpos] + '] ' + ' '. join (self.tape [self.tpos +1:]) + ' ' , q)
        else :
            print ( '[ ' + self.tape[self.tpos ] + '] ' + ' '. join (self.tape[self.tpos +1:]) + ' ' , q)

    def run (self, maxsteps, band) :
        self.tape = [*('__' + band + '____')]
        self.tpos = 0
        q = self.qi
        for t in range(maxsteps):
            self.printer(q)
            if (q,self.tape[self.tpos]) not in self.delta:
                print("kek")
                break
            q,w,d = self.delta[(q, self.tape[self.tpos])]
            self.write_tape(w,d)
            if q == self.qh:
                break
        self.printer(q)