class TuringMachine () :
    def __init__ ( self , qi , qh , delta ) :
        self . qi = qi
        self . qh = qh
        self . delta = delta

    def write_tape (self , w, d) :
        self.tape [self.tpos] = w
        if d == 'R ':
            self.tpos += 1
        else :
            self.tpos -= 1
            if self.tpos < 0:
                self.tape.insert(0, '_')  # Extend tape on the left
                self.tpos = 0

    def print ( self , q ) :
        if self . tpos > 0:
            print ( ' ' + ' '. join ( self . tape [0: self . tpos ]) + ' [ ' + self . tape [ self . tpos ] + '] ' + ' '. join ( self . tape [ self . tpos +1:]) + ' ' , q )
        else :
            print ( '[ ' + self . tape [ self . tpos ] + '] ' + ' '. join ( self . tape [ self . tpos +1:]) + ' ' ,q )

    def run ( self , maxsteps , band ) :
        self . tape = [*( ' __ ' + band + ' ____ ') ]
        self . tpos = 0
        q = self . qi
        for t in range ( maxsteps ) :
    
    
    
