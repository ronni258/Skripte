% fzg_x_t00                                   %gefahrene Strecke
% fzg_psi_p_t00                               %Gierrate
% fas_kamera_bv1_LIN_01_HorKruemm_t00         %Krümmung
% fas_kamera_bv1_LIN_02_HorKruemm_t00         %Krümmung
% fas_kamera_bv1_LIN_03_HorKruemm_t00         %Krümmung

% fzg_ypp_t00                                 %Querbschleunigung
% fzg_xp_t00                                  %Laengsgeschwindigkeit
% fas_kamera_bv1_LIN_01_AbstandY_t00          %seitlicher Abstand zwischen Fahrzeug und linker Fahrbahnmarkierung
% fas_kamera_bv1_LIN_02_AbstandY_t00          %seitlicher Abstand zwischen Fahrzeug und rechter Fahrbahnmarkierung



figure
hold on
yyaxis left
set(gca,'ycolor','red')
% plot (fzg_x_t00,fas_kamera_bv1_LIN_01_ExistMass_t00,'-b')
% plot (fzg_x_t00,fas_kamera_bv1_LIN_02_ExistMass_t00,'-r')
% plot (fzg_x_t00,smooth(fas_kamera_bv1_LIN_01_HorKruemm_t00,1000),'-b')
% plot (fzg_x_t00,smooth(fas_kamera_bv1_LIN_02_HorKruemm_t00,1000),'-r')
% plot (smooth(fas_kamera_bv1_LIN_01_HorKruemm_t00,1000),'-b')
% plot (smooth(fas_kamera_bv1_LIN_02_HorKruemm_t00,1000),'-r')
plot ((smooth(fas_kamera_bv1_LIN_02_HorKruemm_t00,1000)+smooth(fas_kamera_bv1_LIN_01_HorKruemm_t00,1000))/2,'-g')

yline (0,'Color','black')
for c=1:size(Ergebnis01_kM,2)
xline(Ergebnis01_kM(4,c)*int)
end

ylim ([-0.01 0.01])

figure
hold
plot (fzg_psi_p_vz_t00)
plot (smooth(fzg_psi_p_t00,500))
% plot (fas_kamera_bv1_LIN_01_AbstandY_t00)
% plot (fas_kamera_bv1_LIN_02_AbstandY_t00)


yyaxis right
set(gca,'ycolor','b')
% plot (fas_kamera_bv1_LIN_01_AbstandY_t00,'-y') %Spurwechsel sind dem 
% plot (fas_kamera_bv1_LIN_02_AbstandY_t00,'-g')
plot (fzg_ypp_t00(1,1:int:90000),'-b')
yline (0,'Color','black')
for f=1:size(Ergebnis01_kM,2)
xline ((Ergebnis01_kM(4,f)*10),'LineWidth',1,'Color','black')
end

% plot (fas_kamera_bv1_LIN_08_HorKruemm_t00)

% plot (fzg_psi_p_t00)
% 
% k=1;
% if k>1
%     if max(fzg_psi_p_t00(1,(Ergebnis01(4,k-1)*int):1:(Ergebnis01(4,k)*int)))>0.1 &&  fzg_x_t00(1,Ergebnis01(4,k)-Ergebnis01(4,k-1))>150 && max(fas_kamera_bv1_LIN_01_HorKruemm_t00(1,(Ergebnis01(4,k-1)*int):1:(Ergebnis01(4,k)*int)))>0.0001
%     
%    disp 'noice'
%     end
% end
% if k<=1
%     if max(fzg_psi_p_t00(1,1:1:(Ergebnis01(4,k)*int)))>0.1 &&  fzg_x_t00(1,Ergebnis01(4,k))>150 && max(fas_kamera_bv1_LIN_01_HorKruemm_t00(1,1:1:(Ergebnis01(4,k)*int)))>0.0001
%         
%     disp 'roice'
%     end
% end


%%%%%% Durchschnittliche Querbeschleunigungen, Geschwindigkeit 

%Durchschnittswerte für die jeweiligen Kurvenabschnitte, aber nicht sehr
%genau, da durch die Kreise die Abschnitte teilweise schon in die nächste
%Kurve reinragen
Ergebnis01_kM(5,1)=mean(fzg_ypp_t00(1,1:(Ergebnis01_kM(4,1)*int)));
% 
% for c=2:size(Ergebnis01_kM,2)
% Ergebnis01_kM(5,c)=mean(fzg_ypp_t00(1,(Ergebnis01_kM(4,c-1)*int):(Ergebnis01_kM(4,c)*int)));
% end

%if Ergebnis01_kM(4,1)>0 %%%%%%%% Behebt das Problem, wenn der erste Kreis nicht erkannt wird und im Ergebnisvektor für den ersten Abschnitt i=0 ist
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Problem eigentlich im
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Hauptskript behoben

%Laenge der jeweiligen Abschnitte in Km
Ergebnis01_kM(9,1)=fzg_x_t00(1,(Ergebnis01_kM(4,1)*int));
for c=2:size(Ergebnis01_kM,2)
Ergebnis01_kM(9,c)=(fzg_x_t00(1,Ergebnis01(4,c)*int)-fzg_x_t00(1,Ergebnis01(4,c-1)*int));
end


%Maximale Querberschleunigung
Ergebnis01_kM(6,1)=min(fzg_ypp_t00(1,1:(Ergebnis01_kM(4,1)*int)));
Ergebnis01_kM(7,1)=max(fzg_ypp_t00(1,1:(Ergebnis01_kM(4,1)*int)));
for c=2:size(Ergebnis01_kM,2)
Ergebnis01_kM(6,c)=min(fzg_ypp_t00(1,(Ergebnis01_kM(4,c-1)*int):(Ergebnis01_kM(4,c)*int)));
Ergebnis01_kM(7,c)=max(fzg_ypp_t00(1,(Ergebnis01_kM(4,c-1)*int):(Ergebnis01_kM(4,c)*int)));
end



%Bestimmung ob Rechts- oder Linkskurve %%%% sollte Addition positiv sein,
%handelt es sich wahrscheinlich um eine Linkskurve, bei negativen Werten
%ist eine Rechtskurve wahrscheinlich geraden haben eher ausgeglichene
%Werte, muss aber auch in Verbindung mit dem Radius betrachtet werden -->
%große Radien deuten auf gerade Passagen hin
for c=1:size(Ergebnis01_kM,2)
Ergebnis01_kM(8,c)=Ergebnis01_kM(6,c)+Ergebnis01_kM(7,c);
end


%Maximal- / Minimal- und Durchschnittsgeschwindigkeit
Ergebnis01_kM(11,1)=min(fzg_xp_t00(1,1:(Ergebnis01_kM(4,1)*int)));
Ergebnis01_kM(12,1)=max(fzg_xp_t00(1,1:(Ergebnis01_kM(4,1)*int)));
Ergebnis01_kM(13,1)=mean(fzg_xp_t00(1,1:(Ergebnis01_kM(4,1)*int)));
for c=2:size(Ergebnis01_kM,2)
Ergebnis01_kM(11,c)=min(fzg_xp_t00(1,(Ergebnis01_kM(4,c-1)*int):(Ergebnis01_kM(4,c)*int)));
Ergebnis01_kM(12,c)=max(fzg_xp_t00(1,(Ergebnis01_kM(4,c-1)*int):(Ergebnis01_kM(4,c)*int)));
Ergebnis01_kM(13,c)=mean(fzg_xp_t00(1,(Ergebnis01_kM(4,c-1)*int):(Ergebnis01_kM(4,c)*int)));
end

%Verhältnis Querbeschleunigung zur Durchschnittsgeschwindigkeit
for  c=1:size(Ergebnis01_kM,2)
Ergebnis01_kM(15,c)=Ergebnis01_kM(6,c)/Ergebnis01_kM(13,c);
end


%Kruemmung
figure
plot((smooth(fas_kamera_bv1_LIN_01_HorKruemm_t00)))
daspect([1 1 1])
pbaspect([16 9 9])

Ergebnis01_kM(17,1)=1/(((fas_kamera_bv1_LIN_01_HorKruemm_t00(1,(Ergebnis01_kM(4,1))*int*0.1))+(fas_kamera_bv1_LIN_01_HorKruemm_t00(1,((Ergebnis01_kM(4,1)*int*0.5)))+(fas_kamera_bv1_LIN_01_HorKruemm_t00(1,(Ergebnis01_kM(4,1))*int*0.9))))/3);
for c=2:size(Ergebnis01_kM,2)
    i_diff=(Ergebnis01_kM(4,c)-Ergebnis01_kM(4,c-1));
Ergebnis01_kM(17,c)=1/((fas_kamera_bv1_LIN_01_HorKruemm_t00(1,((Ergebnis01_kM(4,c-1)+(i_diff*0.1))*int))+fas_kamera_bv1_LIN_01_HorKruemm_t00(1,((Ergebnis01_kM(4,c-1)+(i_diff*0.5))*int))+fas_kamera_bv1_LIN_01_HorKruemm_t00(1,((Ergebnis01_kM(4,c-1)+(i_diff*0.9))*int)))/3)
end





Name1 = allg_datum_t00;
Name2 = allg_zeit_t00;


inp = 'Ergebnis01_Km_.mat';
[~,fnm,ext] = fileparts(inp);
out = sprintf('%s',fnm,Name1,'_' ,Name2,ext)

save(fullfile('F:\Eigene Dateien\01_Tu Braunschweig\IfF\Masterarbeit\05_Datenauswertung\aufbereitete Daten\Ergebnisvektor',out,'Ergebnis01_kM')



% fas_kamera_bv1_LIN_01_AbstandY_t00          %seitlicher Abstand zwischen Fahrzeug und linker Fahrbahnmarkierung
% fas_kamera_bv1_LIN_02_AbstandY_t00          %seitlicher Abstand zwischen Fahrzeug und rechter Fahrbahnmarkierung
figure
hold
plot (fzg_ypp_t00_average)
plot (smooth(fzg_ypp_t00,500))


plot (smooth(fas_kamera_bv1_LIN_02_AbstandY_t00))
yline (0,'Color','black')
for f=1:size(Ergebnis01_kM,2)
xline ((Ergebnis01_kM(4,f)*10),'LineWidth',1,'Color','black')
end

r_01=0;
r_02=0;
r_03=0;
r_04=0;
r_05=0;


%%%% Häufigste Radien
for c=1:size(Ergebnis01_kM,2)
    if Ergebnis01_kM(3,c)<=0.5
% r_01(1,c)=Ergebnis01_kM(3,c);        
r_01(1,size(r_01,2)+1)=Ergebnis01_kM(3,c);
    end
    
    if Ergebnis01_kM(3,c)<=1.0 && Ergebnis01_kM(3,c)>0.5
% r_02(1,c)=Ergebnis01_kM(3,c);        
r_02(1,size(r_01,2)+1)=Ergebnis01_kM(3,c);
    end
    
    if Ergebnis01_kM(3,c)<=1.5 && Ergebnis01_kM(3,c)>1.0
% r_03(1,c)=Ergebnis01_kM(3,c);        
r_03(1,size(r_01,2)+1)=Ergebnis01_kM(3,c);
    end
    
  if Ergebnis01_kM(3,c)<=2.0 && Ergebnis01_kM(3,c)>1.5
% r_04(1,c)=Ergebnis01_kM(3,c);        
r_03(1,size(r_01,2)+1)=Ergebnis01_kM(3,c);
  end  
    
  if Ergebnis01_kM(3,c)<=3.0 && Ergebnis01_kM(3,c)>2.0
% r_05(1,c)=Ergebnis01_kM(3,c);        
r_04(1,size(r_01,2)+1)=Ergebnis01_kM(3,c);
  end  
    
    
  
  
end

Ergebnis01_kM(28,1)=find(((abs(fas_kamera_bv1_LIN_02_AbstandY_t00(1:Ergebnis01_kM(4,1)*int))-fas_kamera_bv1_LIN_01_AbstandY_t00(1:Ergebnis01_kM(4,1)*int))/2)==Ergebnis01_kM(22,1),1,'first');
for c=2:size(Ergebnis01_kM,2)
Ergebnis01_kM(28,c)=(find(((abs(fas_kamera_bv1_LIN_02_AbstandY_t00(Ergebnis01_kM(4,c-1)*int:Ergebnis01_kM(4,c)*int))-fas_kamera_bv1_LIN_01_AbstandY_t00(Ergebnis01_kM(4,c-1)*int:Ergebnis01_kM(4,c)*int))/2)==Ergebnis01_kM(22,c),1,'first')+Ergebnis01_kM(4,c-1)*int);

end

Ergebnis01_kM(28,c)=find(((abs(fas_kamera_bv1_LIN_02_AbstandY_t00(Ergebnis01_kM(4,c-1):Ergebnis01_kM(4,c))-fas_kamera_bv1_LIN_01_AbstandY_t00(4,c-1):Ergebnis01_kM(4,c))/2)==Ergebnis01_kM(22,c),1,'first'))

c=2

% % Querablage

A = [1 2  3 9 9 9 9 2 3 2 1 9 7 0];
% maximum = max(A)
% [xio,yio]=find(A==maximum)




Distdeg=sqrt((gps_Laengengrad_t00(1,1)-gps_Laengengrad_t00(1,11000))^2+(gps_Breitengrad_t00(1,1)-gps_Breitengrad_t00(1,11000))^2);
deg2km(Distdeg)




[X,Y,Z] = geodetic2ecef(wgs84,gps_Breitengrad_t00,gps_Laengengrad_t00,gps_Hoehe_t00)
figure
plot3(Y,X,Z)
daspect([1 1 1])
pbaspect([16 9 9])

origin=[gps_Breitengrad_t00(1,1) gps_Laengengrad_t00(1,1) gps_Hoehe_t00(1,1)];
[aaxEast,aayNorth,aazUp] = latlon2local(gps_Breitengrad_t00,gps_Laengengrad_t00,gps_Hoehe_t00,origin);
figure
plot(aaxEast,aayNorth)
daspect([1 1 0.001])
pbaspect([16 9 9])

tempInt=0;
for d=1:Ergebnis01_kM(4,1)*int
    tempInt=tempInt+fas_kamera_bv1_LIN_1_2_HorKruemm_t00_average(1,d);
    
    Ergebnis01_kM(31,1)=tempInt;
end
for c=2:size(Ergebnis01_kM,2)
    tempInt=0;
    for d=Ergebnis01_kM(4,c-1)*int:Ergebnis01_kM(4,c)*int
        tempInt=tempInt+fas_kamera_bv1_LIN_1_2_HorKruemm_t00_average(1,d);
    end
    Ergebnis01_kM(31,c)=tempInt;
end


%Betrachtung der Spurbreite
c=17;
int=10;
figure
hold
yline(0)
% plot(((abs(fas_kamera_bv1_LIN_02_AbstandY_t00(1,Ergebnis01_kM(4,c-1)*int:Ergebnis01_kM(4,c)*int))-fas_kamera_bv1_LIN_01_AbstandY_t00(1,Ergebnis01_kM(4,c-1)*int:Ergebnis01_kM(4,c)*int))/2))
% plot(fas_kamera_bv1_LIN_02_AbstandY_t00(1,Ergebnis01_kM(4,c-1)*int:Ergebnis01_kM(4,c)*int))
% plot(fas_kamera_bv1_LIN_01_AbstandY_t00(1,Ergebnis01_kM(4,c-1)*int:Ergebnis01_kM(4,c)*int))
plot(fas_kamera_bv1_LIN_02_AbstandY_t00)
plot(fas_kamera_bv1_LIN_01_AbstandY_t00)

round(mean(Sb(1,(Ergebnis01_kM(4,c-1)*int):(Ergebnis01_kM(4,c)*int))),1);
Sb(1,65597)




%Lenkwinkel und Lenkgeschwindigkeit

for n=1:size(lenk_delta_H_vz_t00,2)
    if lenk_delta_H_vz_t00(1,n)>0
      Lenkradwinkel(1,n)= (-1)*lenk_delta_H_t00(1,n);
    else
      Lenkradwinkel(1,n)= lenk_delta_H_t00(1,n); 
    end
end

for n=1:size(lenk_delta_H_vz_t00,2)
    if lenk_delta_H_p_vz_t00(1,n)>0
      Lenkradwinkelgeschw(1,n)= (-1)*lenk_delta_H_p_t00(1,n);
    else
      Lenkradwinkelgeschw(1,n)= lenk_delta_H_p_t00(1,n); 
    end
end
% plot(Lenkradwinkelgeschw);
figure
hold
yyaxis left
plot(Lenkradwinkel(3661:5080));
% plot(Lenkradwinkelgeschw,'color','green');

yyaxis right
plot(fas_kamera_bv1_LIN_1_2_HorKruemm_t00_average);


%Existenzwahrscheinlichkeit der Fahrbahnmarkierungen
figure
ax(1)=subplot(2,1,1);
hold on
plot(fas_kamera_bv1_LIN_01_ExistMass_t00)
plot(fas_kamera_bv1_LIN_02_ExistMass_t00)
ylabel ('Existenzwahrscheinlichkeit')
hold off
ax(2)=subplot(2,1,2);
hold on
plot(fas_kamera_bv1_LIN_01_AbstandY_t00)
plot(fas_kamera_bv1_LIN_02_AbstandY_t00)
ylabel ('Abstand')
hold off


% figure
fig_1=figure ('Name','Abstand_Markierung+Existenzwahrscheinlichkeit_unbearbeitet');
title ('Abstand zwischen Fahrzeug und Markierung + Existenzwahrscheinlichkeit')
subtitle('unbearbeitet')
hold on
yyaxis left
plot(fas_kamera_bv1_LIN_01_AbstandY_t00)
ylabel ('Abstand')
yyaxis right
plot(fas_kamera_bv1_LIN_01_ExistMass_t00)
xlabel ('Messpunkte')
ylabel ('Wahrscheinlichkeit')
legend ('Abstand','Wahrscheinlichkeit')


% Passt die Entfernung des Fahrzeugs zur Linie an. Wird normalerweise keine
% Linie erkannt, wo wird die Entfernung auf 0 gesetzt --> das führt zu
% Fehlern bei der Berechnung der Spurbreite, Querablage... . Um das zu
% verhindern soll die Entfernung auf "NaN" gesetzt werden, wenn die
% Wahrscheinlichkeit für einer Markierung
% (fas_kamera_bv1_LIN_01_ExistMass_t00) < 0,6 ist UND der Abstand innerhalb
% von 5 Messpunkten auch 0 erreicht. So werden gewollte Spurüberquerungen
% bei denen der Abstand = 0 ist nicht gelöscht und außerdem auch Passagen
% bei denen die Wahrscheinlichkeit 0 ist, aber trotzdem eine Linie erkannt
% wird und der Abstand ~= 0 ist toleriert

for n=1:anzahl
    if n < anzahl-10 %sorgt dafür, dass bei "n+5" nicht über den maximalen Rand nach Werten gesucht wird
        if fas_kamera_bv1_LIN_01_ExistMass_t00(1,n) < 0.6 && fas_kamera_bv1_LIN_01_AbstandY_t00(1,n+5)==0 || fas_kamera_bv1_LIN_01_ExistMass_t00(1,n) < 0.6 && fas_kamera_bv1_LIN_01_AbstandY_t00(1,n-5)==0 %
   fas_kamera_bv1_LIN_01_AbstandY_t00(1,n)=NaN;
        end
    else
        if fas_kamera_bv1_LIN_01_ExistMass_t00(1,n) < 0.6 && fas_kamera_bv1_LIN_01_AbstandY_t00(1,n)==0 || fas_kamera_bv1_LIN_01_ExistMass_t00(1,n) < 0.6 && fas_kamera_bv1_LIN_01_AbstandY_t00(1,n-5)==0
   fas_kamera_bv1_LIN_01_AbstandY_t00(1,n)=NaN;
        end 
    end
end

for n=1:anzahl
    if n < anzahl-10 %sorgt dafür, dass bei "n+5" nicht über den maximalen Rand nach Werten gesucht wird
        if fas_kamera_bv1_LIN_02_ExistMass_t00(1,n) < 0.6 && fas_kamera_bv1_LIN_02_AbstandY_t00(1,n+5)==0 || fas_kamera_bv1_LIN_02_ExistMass_t00(1,n) < 0.6 && fas_kamera_bv1_LIN_02_AbstandY_t00(1,n-5)==0 %
   fas_kamera_bv1_LIN_02_AbstandY_t00(1,n)=NaN;
        end
    else
        if fas_kamera_bv1_LIN_02_ExistMass_t00(1,n) < 0.6 && fas_kamera_bv1_LIN_02_AbstandY_t00(1,n)==0 || fas_kamera_bv1_LIN_02_ExistMass_t00(1,n) < 0.6 && fas_kamera_bv1_LIN_02_AbstandY_t00(1,n-5)==0
   fas_kamera_bv1_LIN_02_AbstandY_t00(1,n)=NaN;
        end 
    end
end




%%%%%%% Pro Kurve sechs Punkte für Geschwindigkeit, Querbeschleunigung und
%%%%%%% Querablage Spurbreite

%Spurbreite
for c=1:size(Ergebnis01_kM,2)
if c > 1
  Pkt_b=(Ergebnis01_kM(4,c)-Ergebnis01_kM(4,c-1));
    if Ergebnis01_kM(4,c)*10+5<anzahl
    Ergebnis01_kM(37,c)=round(mean(Sb((Ergebnis01_kM(4,c-1)+0.2*Pkt_b)*10-5:(Ergebnis01_kM(4,c-1)+0.2*Pkt_b)*10+5)),1);
    Ergebnis01_kM(38,c)=round(mean(Sb((Ergebnis01_kM(4,c-1)+0.4*Pkt_b)*10-5:(Ergebnis01_kM(4,c-1)+0.4*Pkt_b)*10+5)),1);
    Ergebnis01_kM(39,c)=round(mean(Sb((Ergebnis01_kM(4,c-1)+0.6*Pkt_b)*10-5:(Ergebnis01_kM(4,c-1)+0.6*Pkt_b)*10+5)),1);
    Ergebnis01_kM(40,c)=round(mean(Sb((Ergebnis01_kM(4,c-1)+0.8*Pkt_b)*10-5:(Ergebnis01_kM(4,c-1)+0.8*Pkt_b)*10+5)),1);
    Ergebnis01_kM(41,c)=round(mean(Sb((Ergebnis01_kM(4,c-1)+1.0*Pkt_b)*10-5:(Ergebnis01_kM(4,c-1)+1.0*Pkt_b)*10+5)),1);
    else
    Ergebnis01_kM(37,c)=round(mean(Sb((Ergebnis01_kM(4,c-1)+0.2*Pkt_b)*10-5:(Ergebnis01_kM(4,c-1)+0.2*Pkt_b)*10)),1);
    Ergebnis01_kM(38,c)=round(mean(Sb((Ergebnis01_kM(4,c-1)+0.4*Pkt_b)*10-5:(Ergebnis01_kM(4,c-1)+0.4*Pkt_b)*10)),1);
    Ergebnis01_kM(39,c)=round(mean(Sb((Ergebnis01_kM(4,c-1)+0.6*Pkt_b)*10-5:(Ergebnis01_kM(4,c-1)+0.6*Pkt_b)*10)),1);
    Ergebnis01_kM(40,c)=round(mean(Sb((Ergebnis01_kM(4,c-1)+0.8*Pkt_b)*10-5:(Ergebnis01_kM(4,c-1)+0.8*Pkt_b)*10)),1);
    Ergebnis01_kM(41,c)=round(mean(Sb((Ergebnis01_kM(4,c-1)+1.0*Pkt_b)*10-5:(Ergebnis01_kM(4,c-1)+1.0*Pkt_b)*10)),1);
    end 
  
  
else
  Pkt_b=Ergebnis01_kM(4,c);  

    if Ergebnis01_kM(4,c)*10+5<anzahl
    Ergebnis01_kM(37,c)=round(mean(Sb((Ergebnis01_kM(4,c)+0.2*Pkt_b)*10-5:(Ergebnis01_kM(4,c)+0.2*Pkt_b)*10+5)),1);
    Ergebnis01_kM(38,c)=round(mean(Sb((Ergebnis01_kM(4,c)+0.4*Pkt_b)*10-5:(Ergebnis01_kM(4,c)+0.4*Pkt_b)*10+5)),1);
    Ergebnis01_kM(39,c)=round(mean(Sb((Ergebnis01_kM(4,c)+0.6*Pkt_b)*10-5:(Ergebnis01_kM(4,c)+0.6*Pkt_b)*10+5)),1);
    Ergebnis01_kM(40,c)=round(mean(Sb((Ergebnis01_kM(4,c)+0.8*Pkt_b)*10-5:(Ergebnis01_kM(4,c)+0.8*Pkt_b)*10+5)),1);
    Ergebnis01_kM(41,c)=round(mean(Sb((Ergebnis01_kM(4,c)+1.0*Pkt_b)*10-5:(Ergebnis01_kM(4,c)+1.0*Pkt_b)*10+5)),1);
    else
    Ergebnis01_kM(37,c)=round(mean(Sb((Ergebnis01_kM(4,c)+0.2*Pkt_b)*10-5:(Ergebnis01_kM(4,c)+0.2*Pkt_b)*10)),1);
    Ergebnis01_kM(38,c)=round(mean(Sb((Ergebnis01_kM(4,c)+0.4*Pkt_b)*10-5:(Ergebnis01_kM(4,c)+0.4*Pkt_b)*10)),1);
    Ergebnis01_kM(39,c)=round(mean(Sb((Ergebnis01_kM(4,c)+0.6*Pkt_b)*10-5:(Ergebnis01_kM(4,c)+0.6*Pkt_b)*10)),1);
    Ergebnis01_kM(40,c)=round(mean(Sb((Ergebnis01_kM(4,c)+0.8*Pkt_b)*10-5:(Ergebnis01_kM(4,c)+0.8*Pkt_b)*10)),1);
    Ergebnis01_kM(41,c)=round(mean(Sb((Ergebnis01_kM(4,c)+1.0*Pkt_b)*10-5:(Ergebnis01_kM(4,c)+1.0*Pkt_b)*10)),1);
    end
end
end

%loescht die Kruemmung an den Stellen, an den keine Linie erkannt wird
for n=1:size(fas_kamera_bv1_LIN_01_AbstandY_t00,2)
if isnan(fas_kamera_bv1_LIN_01_AbstandY_t00(1,n))
    fas_kamera_bv1_LIN_01_HorKruemm_t00(1,n)=NaN;
end

if isnan(fas_kamera_bv1_LIN_02_AbstandY_t00(1,n))
    fas_kamera_bv1_LIN_02_HorKruemm_t00(1,n)=NaN;
end
end

%bildet Durchschnitt der Kruemmung und fuellt Luecken auf, wenn eine Linie
%erkannt wird Linie 01 hat weniger Luecken, deshalb wird falls diese
%vorhanden ist, diese verwendet

for n=1:anzahl
if isnan(fas_kamera_bv1_LIN_01_HorKruemm_t00(1,n)) && isnan(fas_kamera_bv1_LIN_02_HorKruemm_t00(1,n))
    fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,n)=NaN; %%%%%% Name muss im Hauptskript noch angepasst werden

elseif isnan(fas_kamera_bv1_LIN_01_HorKruemm_t00(1,n)) && ~isnan(fas_kamera_bv1_LIN_02_HorKruemm_t00(1,n))
    fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,n)=fas_kamera_bv1_LIN_02_HorKruemm_t00(1,n);

elseif isnan(fas_kamera_bv1_LIN_02_HorKruemm_t00(1,n)) && ~isnan(fas_kamera_bv1_LIN_01_HorKruemm_t00(1,n))
    fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,n)=fas_kamera_bv1_LIN_01_HorKruemm_t00(1,n);

elseif ~isnan(fas_kamera_bv1_LIN_01_HorKruemm_t00(1,n)) && ~isnan(fas_kamera_bv1_LIN_02_HorKruemm_t00(1,n))
    fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,n)=(fas_kamera_bv1_LIN_01_HorKruemm_t00(1,n));%+fas_kamera_bv1_LIN_02_HorKruemm_t00(1,n))/2;
end

end

%smoothen kann nicht verwendet werden, da bei Bereichen mit NaN sich der
%Plot dann aufschwingt
%fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00_smoothed=smooth(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00,10);

% Peaks der Kruemmung suchen --> daraus spaeter den Radius bilden
[pks_max,locs_max,w_max,p_max]=findpeaks(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00,'MinPeakProminence',0.0005,'Annotate','extents','MinPeakDistance',500,'MinPeakHeight',0.0002,'WidthReference','halfheight','MinPeakWidth',20);
[pks_min,locs_min,w_min,p_min]=findpeaks((-1)*fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00,'MinPeakProminence',0.0005,'Annotate','extents','MinPeakDistance',500,'MinPeakHeight',0.0002,'WidthReference','halfheight','MinPeakWidth',20);



figure
hold on
% yyaxis left
% plot(fas_kamera_bv1_LIN_01_ExistMass_t00,'-b')
% plot(fas_kamera_bv1_LIN_02_ExistMass_t00,'-k')
% yline(0)
% yyaxis right
% plot(fas_kamera_bv1_LIN_01_AbstandY_t00,'-r')
% plot(fas_kamera_bv1_LIN_02_AbstandY_t00,'-m')
% yline(0)
% plot((fas_kamera_bv1_LIN_02_HorKruemm_t00+fas_kamera_bv1_LIN_01_HorKruemm_t00)/2,'-y')
yline (0.0002,'Color','black')
yline (-0.0002,'Color','black')
yline (0,'Color','black')
plot(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00)
findpeaks(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00,'MinPeakProminence',0.0002,'MinPeakDistance',500,'MinPeakHeight',0.0002,'WidthReference','halfheight','MinPeakWidth',20)
findpeaks((-1)*fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00,'MinPeakProminence',0.0002,'MinPeakDistance',500,'MinPeakHeight',0.0002,'WidthReference','halfheight','MinPeakWidth',20)

hold off
%markiert Extrema auf Durchfahrt
scatter(xEast(Extrema(:,2)),yNorth(Extrema(:,2)),20,'blue','filled')
%markiert gueltige Extrema auf Kruemmungsverlauf
scatter(Extrema_final(:,1),1./(Extrema_final(:,2)),100,'blue','filled')

%sortiert die Peaks in eine Matrix
Extrema=[pks_max -pks_min; locs_max locs_min]';
Extrema=sortrows(Extrema,2);

%markiert alle Kruemmungsextrema die aufgrund fehlender Spurmarkierungen erkannt
%worden sind als nicht relevant
Bereich=50;
for n=1:size(Extrema,1)
    if Extrema(n,2)>Bereich && Extrema(n,2)<anzahl-Bereich
            if isnan(mean(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(n,2)-Bereich:Extrema(n,2)+Bereich)))
                Extrema(n,3)=0;
            else
                Extrema(n,3)=1;
            end
    elseif Extrema(n,2)<Bereich
            if isnan(mean(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(n,2):Extrema(n,2)+Bereich)))
                Extrema(n,3)=0;
            else
                Extrema(n,3)=1;
            end

    elseif Extrema(n,2)>anzahl-Bereich
            if isnan(mean(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(n,2)-Bereich:anzahl)))
                Extrema(n,3)=0;
            else
                Extrema(n,3)=1;
            end            
    
    end
end

sum(Extrema(:,3))

% Wert der bei einer Durchfahrt als Extrema der Kruemmung angenommen wurde. 
% Gucken ob sich dieser noch in anderen Faellen wiederholt, falls das der Fall ist dann diesen Wert ausschließen
% 0.031250000000000

Extrema(:,4)=(1./Extrema(:,1)).*Extrema(:,3);




% Linienabstände zur Verdeutlichung von Spurwechseln
fig_1=figure ('Name','Abstaende der Fahrbahnmarkierungen / Spurwechsel');
title ('Abstaende der Fahrbahnmarkierungen')
subtitle('und Spurwechsel')
grid on
hold on
plot(fas_kamera_bv1_LIN_01_AbstandY_t00)%fas_kamera_bv1_LIN_01_AbstandY_t00)
plot(fas_kamera_bv1_LIN_02_AbstandY_t00)%fas_kamera_bv1_LIN_02_AbstandY_t00)
yline(0)
% plot(Ergebnis_Linkskurve_0100_0150,yfit)
xlabel ('Messpunkte')
ylabel ('Abstaende quer zur Fahrtrichtung')
legend ('linke Spurmarkierung','rechte Spurmarkierung')
hold off

n=8
for n=1:size(Ergebnis_Kr,2)
hold on
XY=[x(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n));y(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n))];

Kp=1000; % Kp= Kreispunkte
phi=linspace(0,2*pi,Kp);
xm=x(Ergebnis_Kr(1,n)); % X-Wert Mittelpunkt
ym=y(Ergebnis_Kr(1,n)); % Y_Wert Mittelpunkt
rw=Ergebnis_Kr(2,n);  % Radius
x_KO=xm+rw*sin(phi); % KO = Kreis Original
y_KO=ym+rw*cos(phi);
% plot(x_KO,y_KO)
XY_KO=[x_KO;y_KO];

for i=1:Kp
    for j=1:size(XY,2)
     Mp_Diff(1,i)=sum(abs(sqrt((XY_KO(1,i)-XY(1,j))^2+(XY_KO(2,i)-XY(2,j))^2)-Ergebnis_Kr(2,n)));
    end
end

if Ergebnis_Kr(2,n)>0
Mp=find(Mp_Diff==min(Mp_Diff(0.5*Kp:Kp)));
else
Mp=find(Mp_Diff==min(Mp_Diff(0:0.5*Kp)));
end

phi=linspace(0,2*pi,100);
xm=x_KO(1,Mp); % X-Wert Mittelpunkt
ym=y_KO(1,Mp); % Y_Wert Mittelpunkt
rw=Ergebnis_Kr(2,n);  % Radius
x_KO=xm+rw*sin(phi); % KO = Kreis Original
y_KO=ym+rw*cos(phi);
plot(x_KO,y_KO)

end



figure
hold on
plot((abs(fas_kamera_bv1_LIN_02_AbstandY_t00(1,(Ergebnis_Kr(5,35):Ergebnis_Kr(10,35))))-fas_kamera_bv1_LIN_01_AbstandY_t00(1,(Ergebnis_Kr(5,35):Ergebnis_Kr(10,35))))/2)
plot(fzg_ypp_t00_average(Ergebnis_Kr(5,35):Ergebnis_Kr(10,35)))





%Curve Cutting Gradient: soll die stationären Punkte der Querbeschleunigung
%einer Kurve erkennen (Standardabweichung innerhalb von 3 Sekunden ^= 300 Messpunkte
% geringer als 10%) und an den Stellen die Querablage über die
%Querbeschleunigung auftragen. Durch alle Punkte eine Regressionsgerade
%legen: sollte die Steigung der Geraden negativ sein, deutet das auf einen
%kurvenschneidenen Charakter hin, ist die Steigung positiv driftet das
%Fahrzeug im Verlauf der Kurve nach außen. Soll als Indikator fuer die
%Qualitaet einer automatisierten Querfuehrung dienen. Fuer meine Zwecke
%aber wahrschienlich nicht so wichtig, da dadurch eher ein Fahrstil
%beschrieben wird und bei den Messdaten aber mehrere Personen gefahren sind


CCG=[]
n=151;
while n <= 89000 %42201:43846
    if std(fzg_ypp_t00_average(n-150:n+150))<=fzg_ypp_t00_average(n)*0.1 && ~isnan((abs(fas_kamera_bv1_LIN_02_AbstandY_t00(1,(n)))-fas_kamera_bv1_LIN_01_AbstandY_t00(1,(n)))/2)
        CCG(:,n)=[fzg_ypp_t00_average(n);(abs(fas_kamera_bv1_LIN_02_AbstandY_t00(1,(n)))-fas_kamera_bv1_LIN_01_AbstandY_t00(1,(n)))/2];
    n=n+99;
    end
    n=n+1;
end

 CCG2=nonzeros(CCG');
 CCG2=reshape(CCG2,[],2);
reg=CCG2(:,1)\CCG2(:,2);
figure
hold on
scatter(CCG2(:,1),CCG2(:,2))
plot(CCG2(:,1),reg*CCG2(:,1))

CCG=[];
k=1;
sw=10;
for n=1:size(Ergebnis_Kr,2)
    j=Ergebnis_Kr(5,n)+sw;
    while j<Ergebnis_Kr(10,n)-sw
      if std(fzg_ypp_t00_average(j-sw:j+sw))<=fzg_ypp_t00_average(j)*0.1 %&& ~isnan((abs(fas_kamera_bv1_LIN_02_AbstandY_t00(1,(j)))-fas_kamera_bv1_LIN_01_AbstandY_t00(1,(j)))/2)
        CCG(:,k)=[fzg_ypp_t00_average(j);(abs(fas_kamera_bv1_LIN_02_AbstandY_t00(1,(j)))-fas_kamera_bv1_LIN_01_AbstandY_t00(1,(j)))/2;j];
        k=k+1;
        j=j+sw*2;
      else
    j=j+1;
      end
    end
end
        
 CCG3=CCG';
reg=CCG3(:,1)\CCG3(:,2);
figure
hold on
scatter(CCG3(:,1),CCG3(:,2))
plot(CCG3(:,1),reg*CCG3(:,1))        

figure
hold
plot(fzg_ypp_t00_average)
        






% Plot der Koordinaten die aus dem Schwimmwinkel und Gierwinkel des ESM
% abgeleitet werden
figure
hold on
% plot(out.x_SP.Data(2000:end),out.y_SP.Data(2000:end))
% plot(simout.signals.values(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n)-1,1))
% plot(fzg_ypp_t00_average(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n)))
yyaxis left
plot(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n)))
yyaxis right
plot((abs(fas_kamera_bv1_LIN_02_AbstandY_t00(1,(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n))))-fas_kamera_bv1_LIN_01_AbstandY_t00(1,(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n))))/2)
daspect([1 1 100000])
pbaspect([16 9 9])

hold off 

figure
hold on
plot(x(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n))-x(Ergebnis_Kr(5,n)),y(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n))-y(Ergebnis_Kr(5,n)))
daspect([1 1 100000])
pbaspect([16 9 9])

%Rotation der Koordinaten der gefahrenen Kurve, um diese mit dem Ergebnis
%des ESM vergleichen zu können
x_rot=x*cosd(288)-y*sind(288);
y_rot=x*sind(288)+y*cosd(288);

figure
hold on
plot(x_rot(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n))-x_rot(Ergebnis_Kr(5,n)),y_rot(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n))-y_rot(Ergebnis_Kr(5,n)))
daspect([1 1 100000])
pbaspect([16 9 9])







% Versuch Simulink direkt mit dem Kruemmungsvektor zu füttern



simin_radius.time=allg_t00(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n))';
simin_radius.signals.values=(1./fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n)))';

simin_v.time=allg_t00(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n))';
simin_v.signals.values=(fzg_xp_t00(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n)))';

simin_psip.time=allg_t00(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n)-1)';
simin_psip.signals.values=simout.signals.values(:,2);

simin_beta.time=allg_t00(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n)-1)';
simin_beta.signals.values=simout.signals.values(:,3);


simin_radius.time(:,1)=[(0:0.01:36.59)'; trrte];
trrte=simin_radius.time;
simin_radius.time=[];


tgb=simin_radius.signals.values;
simin_radius.signals.values=[];
simin_radius.signals.values(1:Ergebnis_Kr(10,n),1)=1.005651551356665e+04;
simin_radius.signals.values(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n),1)=tgb;

simin_v.time=simin_radius.time;


gdf=simin_v.signals.values;
simin_v.signals.values=[];
simin_v.signals.values(1:Ergebnis_Kr(10,n),1)=47.243720677086350;
simin_v.signals.values(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n),1)=gdf;


simin_radius.time(1,1)



%Vergleich der Kruemmungsverlaeufe der Curvature Funktion
XY_qab=[];
XY_qab=[x_qab y_qab];
R_smoothed=smooth(R,100)

figure
hold on
plot(1./(R_smoothed))
scatter(1:size(R_smoothed,1),(1./R_smoothed))
scatter(1:size(R,1),(1./R))
plot(K_smoothed)

 
plot(smooth(K(:,1),50))
plot(smooth(K(:,2),50))
scatter(1:size(R_smoothed,1),K(:,1))
scatter(1:size(R_smoothed,1),K(:,2))
yline(0)

plot(-K1(2001:end,1))
plot(x_qab,y_qab)

plot(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,83173:87395))
plot(R)
[L,R,K]=curvature(XY_qab)


% Vergleich der verschiedenen GPS-Daten
figure  ('Name','Streckenverlauf');
title ('Streckenverlauf Aufzeichnung: 2019-09-17-20-00-02')
subtitle(' Vergleich der GPS-Aufzeichnungen')
hold on
plot3(fas_navi_ehr_GPS_Latitude_t00,fas_navi_ehr_GPS_Longitude_t00,1:90002,'MarkerSize',2,'MarkerFaceColor',[1 0 0],'Color','black');
plot3(gps_Breitengrad_t00,gps_Laengengrad_t00,1:90002,'MarkerSize',2,'MarkerFaceColor',[1 0 0],'Color','red');
xlabel ('Breitengrad')
ylabel ('Längengrad')
legend ('internes GPS', 'externes GPS')
hold off