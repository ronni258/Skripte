%%%  Legende fuer Ergebnisvektor
%   1. Längengrad Kreismittelpunkt der jeweiligen Kurve
%   2. Breitengrad Kreismittelpunkt
%   3. Kurvenradius in m
%   4. Gibt den Punkt an bis zu dem die Messwerte verwendet wurden (vom vorherigen Abschnitt), um diese
%   Kurve anzunaehren
%   5. 0
%   6. Minimale Querbeschleunigung im jeweiligen Abschnitt
%   7. Maximale Querbeschleunigung im jeweiligen Abschnitt
%   8. Durschnittliche Querberschleunigung im jeweiligen Abschnitt
%-% 9. Minimale Querbeschleunigung + Maximale Querbeschleunigung (soll als
%-% Inikator dienen, ob es sich um eine Rechts- oder Linkskurve handelt:
%-% positiv = Linkskurve; negativ = Rechtskurve)
%   10. Laenge des jeweiligen Abschnitts in m
%   11. 0
%   12. Minimale Geschwindigkeit im jeweiligen Abschnitt
%   13. Maximale Geschwindigkeit im jeweiligen Abschnitt
%   14. Durchschnittliche Geschwindigkeit im jeweiligen Abschnitt
%   15. 0
%   16. Verhaeltnis Querbeschleunigung zur Durschnittsgeschwindigkeit
%   17. 0
%   18. Radius aus dem Kehrwert der Extrema der durschnittlichen geglaetteten Kruemmung
%   19. Radius aus dem Kehrwert des Gesamtdurchschnitts der Krümmungswerter pro Abschnitt
%   20. 0
%   21. Gerundete durchschnittliche Spurbreite
%   22. Maximale Querablage (positive Werte = fahrzeug befindet sich auf der linken Seite der Fahrbahnmitte; negative Werte Fahrzeug befindet sich auf der rechten Seite der Fahrbahnmitte)
%   23. Normierte maximale Querablage auf Spurbreite (maximale Querablage / Spurbreite)
%   24. Offset zu Kurvenbeginn
%   25. Normierter Offset zu Kurvengebinn auf Spurbreite (Querablage zu Kurvenbeginn / Spurbreite)
%   26. Kurvenschneidefaktor (normierte maximale Querablage - normierten Offset zu Kurvenbeginn)
%   28. Messpunkt der Maximalen Querablage
%   29. Querbeschleunigung bei der maximalen Querablage
%   30. Kruemmung bei der maximalen Querablage
%   31. 0
%   32. Aufintegration der Kruemmung in den jeweiligen Abschnitten : Vorzeichen deutet auf Art der Kurve hin (+ = Linkskurve; - = Rechtskurve)
%   33. %Verhaeltnis der Bereichsstrecke zum Umfang des Radius-Kreises (Indikator ob es sich um eine Gerade handeln koennte <=~0,018)
%

% normierter Kurvenschneiderfaktor über normierten Offset
fig_1=figure ('Name','Kurvenschneiderfaktor/Offset_norm_0100_0150');
title ('Kurvenschneiderfaktor ueber normierten Offset zu Kurvenbeginn')
subtitle('Kurvenradius 100-150m')
grid on
hold on
scatter(Ergebnis_Linkskurve_0100_0150(:,25),Ergebnis_Linkskurve_0100_0150(:,26),10,'blue','filled')
scatter(Ergebnis_Rechtskurve_0100_0150(:,25),Ergebnis_Rechtskurve_0100_0150(:,26),10,'red','filled')
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
scatter(Ergebnis_Linkskurve_0100_0150(:,29),Ergebnis_Linkskurve_0100_0150(:,23),10,'blue','filled')
scatter(Ergebnis_Rechtskurve_0100_0150(:,29),Ergebnis_Rechtskurve_0100_0150(:,23),10,'red','filled')
xlabel ('Querbeschleunigung')
ylabel ('normierte maximale Querablage')
legend ('Linkskurve','Rechtskurve')
hold off

% maximale Querablage über normiertem Offset
fig_3=figure ('Name','Qab_max_norm/Offset_norm_0100_0150');
title ('Normierte maximale Querablage ueber normiertem Offset')
subtitle('Kurvenradius 100-150m')
grid on
hold on 
scatter(Ergebnis_Linkskurve_0100_0150(:,25),Ergebnis_Linkskurve_0100_0150(:,23),10,'blue','filled')
scatter(Ergebnis_Rechtskurve_0100_0150(:,25),Ergebnis_Rechtskurve_0100_0150(:,23),10,'red','filled')
xlabel ('normiertet Offset zur Kurvenbeginn')
ylabel ('normierte maximale Querablage')
legend ('Linkskurve','Rechtskurve')
hold off

fig_4=figure ('Name','Qab_max_norm/v_durchschnitt_0100_0150');
title ('Normierte maximale Querablage ueber Durchschnittsgeschwindigkeit')
subtitle('Kurvenradius 100-150m')
grid on
hold on 
scatter(Ergebnis_Linkskurve_0100_0150(:,14),Ergebnis_Linkskurve_0100_0150(:,23),10,'blue','filled')
scatter(Ergebnis_Rechtskurve_0100_0150(:,14),Ergebnis_Rechtskurve_0100_0150(:,23),10,'red','filled')
xlabel ('durchschnittliche Geschwindigkeit')
ylabel ('normierte maximale Querablage')
legend ('Linkskurve','Rechtskurve')
hold off

% regression=polyfit(Ergebnis_Linkskurve_0100_0150(:,29),Ergebnis_Linkskurve_0100_0150(:,23),1)
% yfit = polyval(regression,Ergebnis_Linkskurve_0100_0150)

