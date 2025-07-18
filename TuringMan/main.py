import TuMa
import itertools as itl

delta = {( ' q0 ' , '_ ') : ( ' q0 ' , '_ ' , 'R ') ,#TODO
}
tm = TuMa.TuringMachine( ' q0 ' , ' qh ' , delta )
tm.run (1000 , " 1101 " )

Sigma = { 'a ' , 'b '}
for t in itl.product ( Sigma , repeat =3):
    tm.run (1000, ' '. join (t))
    print ("= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =")