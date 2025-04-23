echo 25 > system_soll.dat

sleep 50

echo 30 > system_soll.dat

sleep 50

echo 10 > system_soll.dat

sleep 80

echo 50 > system_soll.dat

sleep 100

foreach i (`seq 50 100`)
	echo $i > system_soll.dat
	sleep 1
end

foreach i (`seq 100 -1 0`)
	echo $i > system_soll.dat
	sleep 1
end


echo 999999 > system_soll.dat
