#!/usr/bin/env python3

# COCC assembler fuer erweiterten Befehlssatz (EIS)

import re
import sys

asmfile = sys.argv[1]

token = {
  "nop":   0b00000000,
  "hlt":   0b00000001,
  "call":  0b00000010,
  "ret":   0b00000011,
  "cmp":   0b00000100,
  "mout":  0b00000101,
  "min":   0b00000110,
  "add":   0b00010000,
  "adc":   0b00010001,
  "sub":   0b00010010,
  "inc":   0b00010011,
  "dec":   0b00010100,
  "and":   0b00010101,
  "or":    0b00010110,
  "xor":   0b00010111,
  "shl":   0b00011000,
  "shr":   0b00011001,
  "rol":   0b00011010,
  "ror":   0b00011011,
  "not":   0b00011100,
  "mlo":   0b00011101,
  "mhi":   0b00011110,
  "sqrt":  0b00011111,
  "lda":   0b00100000,
  "sta":   0b00101000,
  "ldi":   0b01000000,
  "ldx":   0b01001000,
  "stx":   0b01010000,
  "push":  0b01011000,
  "pop":   0b01100000,
  "jmp":   0b01101000,
  "jz":    0b01101001,
  "jnz":   0b01101010,
  "je":    0b01101001,
  "jne":   0b01101010,
  "jc":    0b01101011,
  "jnc":   0b01101100,
  "rout":  0b01110000,
  "rin":   0b01111000,
  "mov":   0b10000000
} 

regs = {
  "A": 0b000,
  "B": 0b001,
  "C": 0b010,
  "D": 0b011,
  "E": 0b100,
  "F": 0b101,
  "G": 0b110,
  "H": 0b111
}

TEXT, DATA = 0, 1
MEM_SIZE = 256

mem = [0 for _ in range(MEM_SIZE)]
cnt = 0

labels = {}
data = {}
data_addr = {}

def intconv(v):
  if v.startswith("0x"):
    return int(v, 16)
  elif v.startswith("0b"):
    return int(v, 2)
  else:
    return int(v)

with open(asmfile) as f:
  for l in f:
    l = re.sub(";.*", "", l)
    l = l.strip()
    if l == "":
      continue

    if l == ".text":
      section = TEXT
    elif l == ".data":
      section = DATA
    else:
      if section == DATA:
        n, v = map(str.strip, l.split("=", 2))
        data[str(n)] = intconv(v)
      elif section == TEXT:
        kw = l.split()
        if kw[0][-1] == ":":
          labels[kw[0].rstrip(":")] = cnt
        else:
          current_inst = kw[0]

          if current_inst == "ldi":
            op1 = regs[kw[1]]
            kw[0] = (token[kw[0]] & 0b11111000) | op1
            del kw[1]
            if kw[1][0] != "%":
                kw[1] = intconv(kw[1])
          elif current_inst in ("ldx", "stx", "lda", "sta", "push", "pop"):
            op1 = regs[kw[1]]
            kw[0] = (token[kw[0]] & 0b11111000) | op1
            del kw[1]
          elif current_inst in ("mout", "min"):
            kw[0] = (token[kw[0]] & 0b11111111)
          elif current_inst in ("rout", "rin"):
            op1 = regs[kw[1]]
            kw[0] = (token[kw[0]] & 0b11111000) | op1
            del kw[1]
          elif current_inst == "mov":
            op1 = regs[kw[1]]
            op2 = regs[kw[2]]
            kw[0] = (token[kw[0]] & 0b11111000) | op2
            kw[0] = (kw[0] & 0b11000111) | (op1 << 3)
            del kw[2]
            del kw[1]
          else:
            kw[0] = token[kw[0]]

          for a in kw:
            mem[cnt] = a
            cnt += 1

# Write data into memory
for k, v in data.items():
  data_addr[k] = cnt
  mem[cnt] = v
  cnt += 1

data_addr.update(labels)


# Replace variables
for i, b in enumerate(mem):
  if str(b).startswith("%"):
    mem[i] = data_addr[b.lstrip("%")]

print(' '.join(['%02x' % int(b) for b in mem]))
