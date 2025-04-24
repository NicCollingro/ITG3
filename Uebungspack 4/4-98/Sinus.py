import time as ti
import datetime as dt
import numpy as np

# Dateinamen fuer Kommunikation mit System
fn_ist   = "system_ist.dat"
fn_soll  = "system_soll.dat"
fn_stell = "system_stell.dat"
fn_log   = "system_all.dat"

t0 = float((dt.datetime.now()-dt.datetime(1970,1,1)).total_seconds())
omega = 1
t1 = float((dt.datetime.now()-dt.datetime(1970,1,1)).total_seconds())

while t1-t0 < 1000:
    try:
        t1 = float((dt.datetime.now()-dt.datetime(1970,1,1)).total_seconds())
        f_soll = open(fn_soll, "w+")
        print(100*np.sin(omega*np.pi*(t1-t0)/100), file = f_soll)
        f_soll.close()

        ti.sleep(10)

    except:
        True

f_soll = open(fn_soll, "w+")
print(999999, file = f_soll)
f_soll.close()