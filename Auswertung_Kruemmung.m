%% Legende Ergebnis_Kr
% 01.   Messpunkt des minimalen Radius/maximalen Kruemmung der Gesamtkurve
% 02.   minimaler Radius der Gesamtkurve [m] (kleinster Radius definiert die Kurve)  
% 03.   Laenge des Abschnitts [m]
% 04.   0
% 05.   Messpunkt bei Kurvenbeginn
% 06.   Messpunkt bei 0.2 der Kurve
% 07.   Messpunkt bei 0.4 der Kurve
% 08.   Messpunkt bei 0.6 der Kurve
% 09.   Messpunkt bei 0.8 der Kurve
% 10.   Messpunkt bei Kurvenende
% 11.   Messpunkt bei der maximalen Querablage
% 12.   0
% 13.   0
% 14.   Querablage bei Kurvenbeginn
% 15.   Querablage bei 0.2 der Kurve
% 16.   Querablage bei 0.4 der Kurve
% 17.   Querablage bei 0.6 der Kurve
% 18.   Querablage bei 0.8 der Kurve
% 19.   Querablage bei Kurvenende
% 20.   maxmimale Querablage
% 21.   durchschnittliche Querablage
% 22.   0
% 23.   0
% 24.   0
% 25.   Spurbreite bei Kurvenbeginn
% 26.   Spurbreite bei 0.2 der Kurve
% 27.   Spurbreite bei 0.4 der Kurve
% 28.   Spurbreite bei 0.6 der Kurve
% 29.   Spurbreite bei 0.8 der Kurve
% 30.   Spurbreite bei Kurvenende
% 31.   Spurbreite bei maximaler Querablage
% 32.   durchschnittliche Spurbreite
% 33.   0
% 34.   normierte Querablage bei Kurvenbeginn
% 35.   normierte Querablage bei 0.2 der Kurve
% 36.   normierte Querablage bei 0.4 der Kurve
% 37.   normierte Querablage bei 0.6 der Kurve
% 38.   normierte Querablage bei 0.8 der Kurve
% 39.   normierte Querablage bei Kurvenende
% 40.   maxmimale normierte Querablage
% 41.   durchschnittliche normierte Querablage
% 42.   normierter Kurvenschneiderfaktor
% 43.   0
% 44.   0
% 45.   Kruemmung bei Kurvenbeginn
% 46.   Kruemmung bei 0.2 der Kurve
% 47.   Kruemmung bei 0.4 der Kurve
% 48.   Kruemmung bei 0.6 der Kurve
% 49.   Kruemmung bei 0.8 der Kurve
% 50.   Kruemmung bei Kurvenende
% 51.   Kruemmung bei maximaler Querablage
% 52.   maxmimale Kruemmung
% 53.   durchschnittliche Kruemmung
% 54.   0
% 55.   0
% 56.   Querbeschleunigung bei Kurvenbeginn
% 57.   Querbeschleunigung bei 0.2 der Kurve
% 58.   Querbeschleunigung bei 0.4 der Kurve
% 59.   Querbeschleunigung bei 0.6 der Kurve
% 60.   Querbeschleunigung bei 0.8 der Kurve
% 61.   Querbeschleunigung bei Kurvenende
% 62.   Querbeschleunigung bei maximaler Querablage
% 63.   maxmimale Querbeschleunigung
% 64.   minimale Querbeschleunigung
% 65.   durchschnittliche Querbeschleunigung
% 66.   0
% 67.   Geschwindigkeit bei Kurvenbeginn
% 68.   Geschwindigkeit bei 0.2 der Kurve
% 69.   Geschwindigkeit bei 0.4 der Kurve
% 70.   Geschwindigkeit bei 0.6 der Kurve
% 71.   Geschwindigkeit bei 0.8 der Kurve
% 72.   Geschwindigkeit bei Kurvenende
% 73.   Geschwindigkeit bei maximaler Querablage
% 74.   maxmimale Geschwindigkeit
% 75.   minimale Geschwindigkeit
% 76.   durchschnittliche Geschwindigkeit
% 77.   0
% 78.   0
%% Plots
% normierter Kurvenschneiderfaktor über normierten Offset
fig_1=figure ('Name','Kurvenschneiderfaktor/Offset_norm_0100_0150');
title ('Kurvenschneiderfaktor ueber normierten Offset zu Kurvenbeginn')
subtitle('Kurvenradius 100-150m')
grid on
hold on
scatter(mean(Ergebnis_Linkskurve_0100_0150(:,34)),mean(Ergebnis_Linkskurve_0100_0150(:,42)),200,'blue','filled')
scatter(mean(Ergebnis_Rechtskurve_0100_0150(:,34)),mean(Ergebnis_Rechtskurve_0100_0150(:,42)),200,'red','filled')
scatter(Ergebnis_Linkskurve_0100_0150(:,34),Ergebnis_Linkskurve_0100_0150(:,42),10,'blue','filled')
scatter(Ergebnis_Rechtskurve_0100_0150(:,34),Ergebnis_Rechtskurve_0100_0150(:,42),10,'red','filled')
% plot(Ergebnis_Linkskurve_0100_0150,yfit)
xlabel ('normiertet Offset zur Kurvenbeginn')
ylabel ('Kurvenschneidefaktor')
legend ('Linkskurve','Rechtskurve')
hold off

% normierte maximale Querablage über Querbeschleunigung an der Stelle
fig_2=figure ('Name','Qab_max_norm/ypp_0100_0150');
title ('Normierte maximale Querablage ueber Querbeschleunigung an der Stelle')
subtitle('Kurvenradius 100-150m')
grid on
hold on 
scatter(mean(Ergebnis_Linkskurve_0100_0150(:,62)),mean(Ergebnis_Linkskurve_0100_0150(:,40)),200,'blue','filled')
scatter(mean(Ergebnis_Rechtskurve_0100_0150(:,62)),mean(Ergebnis_Rechtskurve_0100_0150(:,40)),200,'red','filled')
scatter(Ergebnis_Linkskurve_0100_0150(:,62),Ergebnis_Linkskurve_0100_0150(:,40),10,'blue','filled')
scatter(Ergebnis_Rechtskurve_0100_0150(:,62),Ergebnis_Rechtskurve_0100_0150(:,40),10,'red','filled')
xlabel ('Querbeschleunigung')
ylabel ('normierte maximale Querablage')
legend ('Linkskurve','Rechtskurve')
hold off

% normierte maximale Querablage über normiertem Offset
fig_3=figure ('Name','Qab_max_norm/Offset_norm_0100_0150');
title ('Normierte maximale Querablage ueber normiertem Offset')
subtitle('Kurvenradius 100-150m')
grid on
hold on 
scatter(mean(Ergebnis_Linkskurve_0100_0150(:,34)),mean(Ergebnis_Linkskurve_0100_0150(:,40)),200,'blue','filled')
scatter(mean(Ergebnis_Rechtskurve_0100_0150(:,34)),mean(Ergebnis_Rechtskurve_0100_0150(:,40)),200,'red','filled')
scatter(Ergebnis_Linkskurve_0100_0150(:,34),Ergebnis_Linkskurve_0100_0150(:,40),10,'blue','filled')
scatter(Ergebnis_Rechtskurve_0100_0150(:,34),Ergebnis_Rechtskurve_0100_0150(:,40),10,'red','filled')
xlabel ('normiertet Offset zur Kurvenbeginn')
ylabel ('normierte maximale Querablage')
legend ('Linkskurve','Rechtskurve')
hold off

% normierte maximale Querablage über Durchschnittsgeschwindigkeit
fig_4=figure ('Name','Qab_max_norm/v_durchschnitt_0100_0150');
title ('Normierte maximale Querablage ueber Durchschnittsgeschwindigkeit')
subtitle('Kurvenradius 100-150m')
grid on
hold on 
scatter(mean(Ergebnis_Linkskurve_0100_0150(:,76)),mean(Ergebnis_Linkskurve_0100_0150(:,40)),200,'blue','filled')
scatter(mean(Ergebnis_Rechtskurve_0100_0150(:,76)),mean(Ergebnis_Rechtskurve_0100_0150(:,40)),200,'red','filled')
scatter(Ergebnis_Linkskurve_0100_0150(:,76),Ergebnis_Linkskurve_0100_0150(:,40),10,'blue','filled')
scatter(Ergebnis_Rechtskurve_0100_0150(:,76),Ergebnis_Rechtskurve_0100_0150(:,40),10,'red','filled')
xlabel ('durchschnittliche Geschwindigkeit')
ylabel ('normierte maximale Querablage')
legend ('Linkskurve','Rechtskurve')
hold off



% Querbeschleunigung ueber Kurvenlaenge
fig_5=figure ('Name','Verlauf Querbeschleunigung/Kurvenlänge');
for n=1:size(Ergebnis_Kr,2)
Zsm=sortrows([Ergebnis_Kr(79:85,n),Ergebnis_Kr(96:102,n)],1);%Zwischenspeichermatrix um die maximale Querlage mit einzureihen
Zsm2=sortrows([Ergebnis_Kr(5:11,n)-Ergebnis_Kr(5,n),Ergebnis_Kr(56:62,n)],1);
title ('Verlauf Querbeschleunigung ueber Kurvenlänge')
subtitle('Kurvenradius 100-150m')
grid on
hold on 
ax(1)=subplot(2,1,1);
hold on
xlabel ('Kurvenlaenge')
ylabel ('Querbeschleunigung')
plot(Zsm(:,1),Zsm(:,2))
hold off
ax(2)=subplot(2,1,2);
hold on
plot(Zsm2(:,1),Zsm2(:,2))
xlabel ('Messpunkte')
ylabel ('Querbeschleunigung')
% legend ('Linkskurve','Rechtskurve')
hold off

end


