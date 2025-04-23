clear all;

data = readmatrix('C:\Users\NicCo\Documents\ITG3\Uebungspack 4\4-98\system_all.dat', 'Delimiter', ' ');

Zeit = data(:,1);
Vsoll = data(:,2);
Vist = data(:,3);
Vstell = data(:,4);

plot(Zeit, Vstell)
xlabel('Zeit t in [s]');
ylabel('Stellwert');
ylim([0, max(Vstell)+5]);
title('PID-Regler Wasserreservoir');