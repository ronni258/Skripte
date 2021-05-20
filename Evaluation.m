%% Evaluation

%um das Einschwingverhalten des Einspurmodells zu umgehen, wird vor jeder
%Kurve ein Abschnitt ergänzt, der 20 Sekunden lang ist und für die
%Geschwindigkeits- und den Radienverlauf den ersten Wert den anschließenden
%Kurve haelt


%Auswahl welche Kurve aus dem Ergebnisvektor betrachtet werden soll
% n=2;
%Zeitvektor fuer Radieneingangsverlauf (Kruemmungsverlauf aus erkannter Spurmarkierung) 
simin_radius.time=[];
Zeitzwischenspeicher=[];
Zeitzwischenspeicher=allg_t00(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n))';
simin_radius.time(:,1)=[(allg_t00(Ergebnis_Kr(5,n))-20:0.01:allg_t00(Ergebnis_Kr(5,n))-0.01)'; Zeitzwischenspeicher];


%Zeitvektor fuer Geschwindigkeitsverlauf (Kruemmungsverlauf aus erkannter Spurmarkierung) 
simin_v.time=[];
simin_v.time=simin_radius.time;


%Radieneingangsverlauf (Kruemmungsverlauf aus erkannter Spurmarkierung) 
simin_radius.signals.values=[];
Radienzwischenspeicher=[];
Radienzwischenspeicher=(1./fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n)))';
simin_radius.signals.values(1:Ergebnis_Kr(10,n)-Ergebnis_Kr(5,n)+1+2000,1)=Radienzwischenspeicher(1,1);
simin_radius.signals.values(2001:Ergebnis_Kr(10,n)-Ergebnis_Kr(5,n)+1+2000,1)=Radienzwischenspeicher;


%Geschwindigkeitsverlauf (Kruemmungsverlauf aus erkannter Spurmarkierung) 
simin_v.signals.values=[];
Geschwindigkeitszwischenspeicher=[];
Geschwindigkeitszwischenspeicher=(fzg_xp_t00(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n)))';
simin_v.signals.values(1:Ergebnis_Kr(10,n)-Ergebnis_Kr(5,n)+1+2000,1)=Geschwindigkeitszwischenspeicher(1,1);
simin_v.signals.values(2001:Ergebnis_Kr(10,n)-Ergebnis_Kr(5,n)+1+2000,1)=Geschwindigkeitszwischenspeicher;



Init_Sim;

%Giergeschwindigkeit
simin_psip.time=[];
simin_psip.time=simin_radius.time(1:end-1,1);
simin_psip.signals.values=[];
simin_psip.signals.values=simout.signals.values(:,2);

%Schwimmwinkel
simin_beta.time=[];
simin_beta.time=simin_psip.time;
simin_beta.signals.values=[];
simin_beta.signals.values=simout.signals.values(:,3);

%Geschwindigkeit fuer Koordinatenbestimmung (gleich der anderen
%Geschwindigkeit nur ohne den letzten Wert)
simin_vkoord.time=[];
simin_vkoord.time=simin_psip.time;
simin_vkoord.signals.values=[];
simin_vkoord.signals.values=simin_v.signals.values(1:end-1,1);

sim('Gierwinkel_Schwimmwinkel_zu_Koordinaten.slx');


%Bestimmung des Pfads mit Querablage
ypp_sim_soll=simout.signals.values(:,1);
x_SP_soll=x_SP.signals.values;
y_SP_soll=y_SP.signals.values;







%%Plots

% % origialer Steckenverlauf mit dem aus dem ESM durch Umrechnung erhaltenen
% 
% %Rotation der Koordinaten der gefahrenen Kurve (GPS-Daten als Ausgangsdaten), um diese mit dem Ergebnis
% %des ESM vergleichen zu können (Kruemmungsverlauf als Ausgangsdaten)
% x_rot=x*cosd(310)-y*sind(310);
% y_rot=x*sind(310)+y*cosd(310);
% % 
% figure  ('Name','Vergleich simulierter  mit realer Kurve');
% title ('Vergleich einer simulierten mit einer realen Kurve ')
% subtitle('minimaler Kurvenradius: 106m')
% grid on
% hold on 
% plot(x_SP.signals.values(2001:end)-x_SP.signals.values(2001),y_SP.signals.values(2001:end)-y_SP.signals.values(2001))
% plot(x_rot(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n))-x_rot(Ergebnis_Kr(5,n)),y_rot(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n))-y_rot(Ergebnis_Kr(5,n)))
% daspect([1 1 100000])
% pbaspect([16 9 9])
% xlabel ('x-Koordinate [m]')
% ylabel ('y-Koordinate [m]')
% legend ('simulierte Kurve','real Kurve')
% hold off
% 
% 
% % Vergleich der Querbeschleunigungen
% 
% figure  ('Name','Vergleich der Querbeschleunigungen');
% title ('Vergleich der Querbeschleunigungen')
% subtitle('minimaler Kurvenradius: 106m')
% hold on
% plot(simout.signals.values(2001:Ergebnis_Kr(10,n)-Ergebnis_Kr(5,n)+2000,1))
% plot(fzg_ypp_t00_average(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n)))
% xlabel ('Zeit [cs]')
% ylabel ('Querbeschleunigung [m/s²]')
% legend ('simulierte Kurve','reale Kurve')
% hold off