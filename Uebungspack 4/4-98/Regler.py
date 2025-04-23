import time as ti

# Dateinamen fuer Kommunikation mit System
fn_ist   = "system_ist.dat"
fn_soll  = "system_soll.dat"
fn_stell = "system_stell.dat"
fn_log   = "system_all.dat"

# Initialisierungen
sum = 0
abwalt = 0
Vsoll = 0
Vstell = 0

while Vsoll!=999999:
  try:
    f_ist = open(fn_ist, "r+")
    f_soll = open(fn_soll, "r+")
    Vist = float(f_ist.readline().split()[0])
    Vsoll = float(f_soll.readline().split()[0])
    f_ist.close()
    f_soll.close()

    # Variablen fuer verschiedene Regler-Typen
    abw = Vsoll - Vist
    abw = 50 #für Sprungantwort
    sum = sum + abw
    dif = abw - abwalt
    abwalt = abw

    #gleichungen aus Aufgabenstellung

    # P-Regler
    #Vstell = 0.5*abw
    
    # PT1-Regler
    #Vstell = 0.1*abw + 0.9 * Vstell
    
    # PI-Regler
    #Vstell = 0.2*abw + 0.01*sum
    
    # PID-Regler
    Vstell = 0.2*abw + 0.01 * sum + dif

    # Stellgroesse beschraenken auf [-100..100]
    if Vstell>+100: Vstell=+100
    if Vstell<-100: Vstell=-100

    # Ausgabe
    f_stell = open(fn_stell,"w+")
    print(Vstell, file=f_stell)
    print ("Stellgroesse: "+ str(Vstell))
    f_stell.close()

    ti.sleep(0.12)
  except Exception as e:
    print("Fehler im Regler:", e)
    # Falls konkurrierender Zugriff auf Files
