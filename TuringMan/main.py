import TuMa
import itertools as itl

"""
delta = { ('q0', '_') : ('q0', '_', 'R'),	
          ('q0', '1') : ('q1', '_', 'R'),
          ('q1', '1') : ('q1', '1', 'R'),	
          ('q1', '_') : ('q2', '1', 'L'),	
          ('q2', '1') : ('q2', '1', 'L'),	
          ('q2', '_') : ('qh', '_', 'R'),
        }
tm = TuMa.TuringMachine( ' q0 ' , ' qh ' , delta )
tm.run (1000 , " 1101 " )
"""

delta = {('q0', '_') : ('q0', '_', 'R'), #delta für den Spiegler 
         ('q0', 'a') : ('q1', '_', 'R'),
         ('q0', 'b') : ('q1', '_', 'R'),

         ('q1', 'a') : ('q1', 'a', 'R'),
         ('q1', 'b') : ('q1', 'b', 'R'),
         ('q1', '_') : ('q2', '_', 'L'),

         ('q2', 'a') : ('q2', '_', 'L'),
         ('q2', 'b') : ('q2', '_', 'L'),
         ('q2', '_') : ('qh', '_', 'R')
}

delta = {('q0', '_') : ('q0', '_', 'R'), #delta für 2.
}

tm = TuMa.TuringMachine( 'q0' , 'qh' , delta)
tm.run (1000, " abbab ")
