import datetime as dt
import time as ti

# Start- und Default-Werte
Vist   = 50
Vsoll  = 50
Vstell = 0

# Dateinamen fuer Kommunikation mit Regler
fn_ist   = "system_ist.dat"
fn_soll  = "system_soll.dat"
fn_stell = "system_stell.dat"
fn_log   = "system_all.dat"

f_ist   = open(fn_ist,"w+")
f_soll  = open(fn_soll,"w+")
f_stell = open(fn_stell,"w+")
f_log   = open(fn_log,"w+")
print(Vist, file=f_ist)
print(Vsoll, file=f_soll)
print(Vstell, file=f_stell)
f_ist.close()
f_soll.close()
f_stell.close()
f_log.close()

# fuer die Zeitausgabe in ns
t0 = float((dt.datetime.now()-dt.datetime(1970,1,1)).total_seconds())

while Vsoll!=999999:		# Ende-Bedingung in "system_soll.dat"
  try:
    # Einlesen des Stellwerts
    f_stell = open(fn_stell,"r+")
    Vstell = float(f_stell.readline().split()[0])
    f_stell.close()


    # System 1: Wasserreservoir
    Vist = max(0, Vist + 0.1*Vstell)
        
    # System 2: rotierende traege Scheibe
    #Vist = 2*Vstell - 0.1*Vist
    
    # System 3: heizbarer Metallblock mit Abkuehlung
    Tmax = 300
    Tmin = 20
    # Vist = Vist + 0.001 * (Tmax - Vist)*max(0, Vstell)- 0.05*max(0,Vist-Tmin)

    # Ausgabe und Abspeichern der Daten
    f_log = open(fn_log,"a")
    f_ist = open(fn_ist, "w+")
    f_soll = open(fn_soll,"r+")
    t1 = float((dt.datetime.now()-dt.datetime(1970,1,1)).total_seconds())
    print(Vist, file=f_ist)
    print(t1 - t0, Vsoll, Vist, Vstell, file=f_log)
    print(t1 - t0, Vsoll, Vist, Vstell)
    Vsoll = float(f_soll.readline().split()[0])
    f_log.close()
    f_ist.close()
    f_soll.close()

    ti.sleep(0.5)
  except:
    True			# Falls konkurrierender Zugriff auf Files
    