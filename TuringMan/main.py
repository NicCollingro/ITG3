delta = { # move right to start of number block
( ' q0 ' , '_ ') : ( ' q0 ' , '_ ' , 'R ') ,#TODO
}
tm = TuMa . TuringMachine ( ' q0 ' , ' qh ' , delta )
tm . run (1000 , " 1101 " )