import TuMa
import itertools as itl

delta = { ('q0', '_') : ('q0', '_', 'R'),	
          ('q0', '1') : ('q1', '_', 'R'),
          ('q1', '1') : ('q1', '1', 'R'),	
          ('q1', '_') : ('q2', '1', 'L'),	
          ('q2', '1') : ('q2', '1', 'L'),	
          ('q2', '_') : ('qh', '_', 'R'),
        }
tm = TuMa.TuringMachine( ' q0 ' , ' qh ' , delta )
tm.run (1000 , " 1101 " )

Sigma = { 'a ' , 'b '}
for t in itl.product ( Sigma , repeat =3):
    tm.run (1000, ' '. join (t))
    print ("= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =")