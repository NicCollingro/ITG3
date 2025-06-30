#!/usr/bin/env python2.7

import re
import sys

progf = sys.argv[1]

reg = ["A", "B", "C", "D", "E", "F", "G", "M"]
alu = ["add", "sub", "inc", "dec", "and", "or", "xor", "adc"]
jmp = ["jmp", "jz", "jnz", "jc", "jnc"]
data = []
dataseg = 0

with open(progf) as f:
  pc = 0;
  print(".text\n")
  for l in f:
    l = l.strip()
    wlist = iter(l.split(" "))
    for w in wlist:
      v = int(w,16)
      if data.count(pc)>0 and dataseg == 0:
        print("\n.data\n")
        dataseg = 1
      if dataseg == 1:
        print(str(hex(pc))+"\t0x"+w)
        dpc = 1
      elif v == 0b00000000:				# nop
        print(str(hex(pc))+"\tnop")
        dpc = 1
      elif v == 0b00000001:				# call D
        w = wlist.next()
        print(str(hex(pc))+"\tcall 0x"+w)
        dpc = 2
      elif v == 0b00000010:				# ret
        print(str(hex(pc))+"\tret")
        dpc = 1
      elif v == 0b00000011:				# out D
        w = wlist.next()
        v = int(w,16)
        print(str(hex(pc))+"\tout 0x"+w)
        dpc = 2
      elif v == 0b00000100:				# in D
        w = wlist.next()
        v = int(w,16)
        print(str(hex(pc))+"\tin "+str(v))
        dpc = 2
      elif v == 0b00000101:				# hlt
        print(str(hex(pc))+"\thlt")
        dpc = 1
      elif v == 0b00000110:				# cmp
        print(str(hex(pc))+"\tcmp")
        dpc = 1
      elif v&0b11111000 == 0b00010000:			# ldi R I
        r = v&0b00000111
        w = wlist.next()
        print(str(hex(pc))+"\tldi "+reg[r]+" 0x"+w)
        dpc = 2
      elif v&0b11000111 == 0b01000000:			# alu
        r = (v&0b00111000)>>3
        print(str(hex(pc))+"\t"+alu[r])
        dpc = 1
      elif v&0b11111000 == 0b00011000:			# jmp D
        r = v&0b00000111
        w = wlist.next()
        print(str(hex(pc))+"\t"+jmp[r]+" 0x"+w)
        dpc = 2
      elif v&0b11111000 == 0b00100000:			# push R
        r = v&0b00000111
        print(str(hex(pc))+"\tpush "+reg[r])
        dpc = 1
      elif v&0b11111000 == 0b00101000:			# pop R
        r = v&0b00000111
        print(str(hex(pc))+"\tpop "+reg[r])
        dpc = 1
      elif v&0b11000000 == 0b10000000:			# mov R2 R1 [D]
        r1 = v&0b00000111
        r2 = (v&0b00111000)>>3
        if (r1 == 0b111 or r2 == 0b111):
          w = wlist.next()
          print(str(hex(pc))+"\tmov "+reg[r2]+" "+reg[r1]+" 0x"+w)
          data.append(int(w,16))
          dpc = 2
        else:
          print(str(hex(pc))+"\tmov "+reg[r2]+" "+reg[r1])
          dpc = 1
      pc = pc + dpc

print(data)
