%Auswahl welche Kurve aus dem Ergebnisvektor betrachtet werden soll
% n=2;
%Zeitvektor fuer Radieneingangsverlauf (Kruemmungsverlauf aus erkannter Spurmarkierung) 
simin_radius.time=[];
Zeitzwischenspeicher=allg_t00(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n))';
simin_radius.time(:,1)=[(allg_t00(Ergebnis_Kr(5,n))-20:0.01:allg_t00(Ergebnis_Kr(5,n))-0.01)'; Zeitzwischenspeicher];

%%Zeitvektor fuer Radieneingangsverlauf (Kruemmungsverlauf aus errechneter Querablage --> zwei Werte weniger)
simin_radius.time=simin_radius.time(1:end-2,1); %-2 da der Vektor zwei Werte weniger hat als der originale 




%Zeitvektor fuer Geschwindigkeitsverlauf (Kruemmungsverlauf aus errechneter Querablage --> zwei Werte weniger)
simin_v.time=[];
simin_v.time=simin_radius.time;



%%Radieneingangsverlauf (Kruemmungsverlauf aus errechneter Querablage --> zwei Werte weniger)
if Ergebnis_Kr(2,n)>0 % legt fest, welches Vorzeichen der Radius bekommt, abhaengig davon ob es sich um eine Rechts- (-) oder Linkskurve (+) handelt 
simin_radius.signals.values=[];
simin_radius.signals.values(1:Ergebnis_Kr(10,n)-Ergebnis_Kr(5,n)-1+2000,1)=R_smoothed(1,1);
simin_radius.signals.values(2001:Ergebnis_Kr(10,n)-Ergebnis_Kr(5,n)-1+2000,1)=R_smoothed;
elseif Ergebnis_Kr(2,n)<0
simin_radius.signals.values=[];
simin_radius.signals.values(1:Ergebnis_Kr(10,n)-Ergebnis_Kr(5,n)-1+2000,1)=-R_smoothed(1,1);
simin_radius.signals.values(2001:Ergebnis_Kr(10,n)-Ergebnis_Kr(5,n)-1+2000,1)=-R_smoothed;
end
    
       

%%Geschwindigkeitsverlauf (Kruemmungsverlauf aus errechneter Querablage --> zwei Werte weniger)
simin_v.signals.values=[];
Geschwindigkeitszwischenspeicher=[];
Geschwindigkeitszwischenspeicher=(fzg_xp_t00(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n)-2))';
simin_v.signals.values(1:Ergebnis_Kr(10,n)-Ergebnis_Kr(5,n)-1+2000,1)=Geschwindigkeitszwischenspeicher(1,1);
simin_v.signals.values(2001:Ergebnis_Kr(10,n)-Ergebnis_Kr(5,n)-1+2000,1)=Geschwindigkeitszwischenspeicher;


Init_Sim;


ypp_sim_qab=simout.signals.values(:,1);


%%%Plots


% origialer Steckenverlauf mit dem aus dem ESM durch Umrechnung erhaltenen

%Rotation der Koordinaten der gefahrenen Kurve (GPS-Daten als Ausgangsdaten), um diese mit dem Ergebnis
%des ESM vergleichen zu können (Kruemmungsverlauf als Ausgangsdaten)
x_rot=[];
y_rot=[];
x_rot=x*cosd(194.4)-y*sind(194.4);
y_rot=x*sind(194.4)+y*cosd(194.4);

figure  ('Name','Vergleich simulierter  mit realer Kurve');
title ('Vergleich einer simulierten mit einer realen Kurve ')
subtitle(' Kurvenradius: 284m (Kurve 19, Rechtskurve)')
grid on
hold on 
yyaxis left
plot(x_qab(:,1)-x_qab(1,1),(y_qab(:,1)-y_qab(1,1)),'-b')
plot(x_SP_soll(2001:end)-x_SP_soll(2001),y_SP_soll(2001:end)-y_SP_soll(2001),'-r')
plot(x_rot(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n))-x_rot(Ergebnis_Kr(5,n)),y_rot(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n))-y_rot(Ergebnis_Kr(5,n)),'-green')
ylabel ('y-Koordinate [m]')
yyaxis right
plot(x_qab-x_qab(1,1),QablV(2001:end),'-black')
ylabel ('Querablage')
daspect([1 1 100000])
pbaspect([16 9 9])
xlabel ('x-Koordinate [m]')

legend ('simulierte Kurve mit Querablage','simulierte Sollkurve','reale Kurve','Querablage')
hold off


figure  ('Name','Vergleich der Querbeschleunigungen');
title ('Vergleich der Querbeschleunigungen')
subtitle(' Kurvenradius: 284m (Kurve 19, Rechtskurve)')
hold on
plot(ypp_sim_qab(2001:Ergebnis_Kr(10,n)-Ergebnis_Kr(5,n)+2000-2,1))
plot(ypp_sim_soll(2001:Ergebnis_Kr(10,n)-Ergebnis_Kr(5,n)+2000,1))
plot(fzg_ypp_t00_average(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n)))
xlabel ('Zeit [cs]')
ylabel ('Querbeschleunigung [m/s²]')
legend ('simulierte Kurve mit Querablage','simulierte Sollkurve','reale Kurve')
hold off