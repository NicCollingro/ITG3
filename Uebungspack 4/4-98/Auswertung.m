clear all;

data = readmatrix('C:\Users\NicCo\Documents\ITG3\Uebungspack 4\4-98\system_all.dat', 'Delimiter', ' ');

Zeit = data(:,1);
Vsoll = data(:,2);
Vist = data(:,3);
Vstell = data(:,4);

plot(Zeit, Vstell, Color='red')
hold on
plot(Zeit, Vsoll, Color='blue')
plot(Zeit, Vist, Color='black')
xlabel('Zeit t in [s]');
ylabel('Stell-/Soll-/Istwert');
ylim([0, max(Vstell)+5]);
title('PID-Regler Wasserreservoir');
hold off;