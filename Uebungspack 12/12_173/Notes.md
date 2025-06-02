# Aufgabe 173

Da diese Aufgabe ähnlich wie die ist, die ich im Grundpraktikum betreut habe, wandle ich den counter direkt in 3 Ausgänge um; A, B, C, also :

| A | B | C |cnt| Zustand   |
|---|---|---|---|-----------|
| 0 | 0 | 0 | 0 | Rot, Gelb |
| 0 | 0 | 1 | 1 | Grün      |
| 0 | 1 | 0 | 2 | Grün      |
| 0 | 1 | 1 | 3 | Gelb      |
| 1 | 0 | 0 | 4 | Gelb      |
| 1 | 0 | 1 | 5 | Rot       |
| 1 | 1 | 0 | 6 | Rot       |
| 1 | 1 | 1 | 7 | Rot       |

=> Grün: B XOR C
=> Gelb: ((B AND C) XOR A) OR (NOT (B AND C))
=> Rot: (NOT A,B,C) OR (A AND (B OR C))

Jetzt in anderer Schreibweise:

Rot: N(ABC) + A*N(BC)
Gelb: ((BC) | A)+ N(BC)
Grün: N(A)*(B|C)