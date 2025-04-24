clear all;

data = readmatrix('C:\Users\NicCo\Documents\ITG3\Uebungspack 4\4-98\system_all.dat', 'Delimiter', ' ');

Zeit = data(:,1);
Vsoll = data(:,2);
Vist = data(:,3);
Vstell = data(:,4);

%plot(Zeit, Vstell, Color='green', LineWidth=2)
hold on
%plot(Zeit, Vsoll, Color='red', LineStyle='- -', LineWidth=2)
plot(Zeit, Vist, Color='black', LineWidth=2)
xlabel('Frequenz in abh. von der Zeit t in [s]');
ylabel('Istwert');
ylim([min(Vstell)-5, max([Vstell(:); Vsoll(:); Vist(:)])+5]);
title('PID-Regler Sinus Wasserreservoir');
hold off;