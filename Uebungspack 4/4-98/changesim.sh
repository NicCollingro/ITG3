echo 25 > system_soll.dat

sleep 20

echo 30 > system_soll.dat

sleep 20

echo 10 > system_soll.dat

sleep 40

echo 50 > system_soll.dat

sleep 50

for i in $(seq 50 100); do
  echo $i > system_soll.dat
  sleep 1
done

# Schleife von 100 bis 0
for i in $(seq 100 -1 0); do
  echo $i > system_soll.dat
  sleep 0.5
done


echo 999999 > system_soll.dat
