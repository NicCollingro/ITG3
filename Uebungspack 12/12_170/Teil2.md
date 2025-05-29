# Aufgabenteil 2

## Zusatandsübergangstabelle:

Da nonblocking und blocking gleich aussehen, betrache nur abc

| Zustand | Input | Output | Zustand'|
|-|-|-|-|
| | abc | a'b'c' |  |
|A | 000 | 000 | A |
|B | 001 | 110 | G |
|C | 010| 111 | H |
|D | 011| 011 | D |
|E | 100| 110 | G |
|F | 101| 010 | C |
|G | 110| 001 | B |
|H | 111| 111 | H |