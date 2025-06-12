# Aufgabe 12-175

### tabelle war mir zu aufwendig und ich habe wichtige zeitstellen in den texten unten angegeben, lasse aber die tabelle einfach mal hier drin stehen
| tick | z1 | z2 | z3 | z4 | z5 | z6 | z7 | z8 |
|-|-|-|-|-|-|-|-|-|
|1 | x, da rst = 0| alles analog zu z1, im prinzip wurde das wire z1 assigned
|2 | -"-| -"- |
|3 | -"-| -"- |
|4 | 0 da rst = 1 |-"- |
|5 | -"- |-"- |
|6 | -"- |-"- |
|7 | x, da rst auf 0 geht|-"- |
|8 | -"- |-"- |
|9| 0 da rst = 1 |-"- |
|a| -"- |-"- |
|b| -"- |-"- |
|c| -"- |-"- |
|d| -"- |-"- |
|e| 1, da rst = 0 ist es x und x = 1, wie oben |-"- |
|f| 0, s. oben|-"- |
|g| -"- |-"- |
|h| -"- |-"- |
|i| -"- |-"- |
|j| 1, s. oben|-"- |


### z1:
ist immer 0 wenn rst = 1 ist ansonsten entspricht es immer x.

### z2:
ist im prinzip assigned auf z1.

### z3:
verhält sich wie z1 / z2 allerdings wird z3 immer nur dann geändert wenn die clk angeht, daher ist es im gegensatz zu z1 auf 0 bis t3 und nicht bis t1.

### z4:
verhält sich genauso wie z3 allerdings werden die werte nun auch beim wechsel von 0 auf 1 der rst geändert. das führt zu einem früheren wechsel in z.b. t4

### z5:
z5 ist analog zu z4 allerdings updated es seinen eintrag immer nur dann wenn die oderverknüpfung von rst und clk von 0 auf 1 geht. daher ist es zum zeitpunkt T_e noch auf 1, da die clk auf 1 war und dann rst dazu kam, was aber an der oder verknüpfung nichts änderte, diese bleib auf 1.

### z6:
z6 geht bei dem wechsel von 0 auf 1 der clock auf x und beim wechsel von 0 auf 1 der posedge auf 0. Siehe T_B und T_e

### z7:
updated immer nur bei einer änderung in clk oder rst nicht wenn sich beide ändern, siehe T_j. Dabei wird bei rst = 1 wieder 0 zugewiesen und bei rst = 0 wieder x.

### z8:
z8 sollte sich wie ein DFF verhalten, dessen clock eine Oder verknüpfung von clk und rst ist, und bekommt als input entweder x wenn rst = 0 ist und wenn rst = 1 ist wieder 0. dieser flipflop sollte sich also genauso wie oben z5 verhalten, tut es aber nicht. Da fällt mir leider nichts ein ):