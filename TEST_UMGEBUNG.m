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
daspect([1 100 1])
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
plot(Lenkradwinkel);
% plot(Lenkradwinkelgeschw,'color','green');

yyaxis right
plot(fas_kamera_bv1_LIN_1_2_HorKruemm_t00_average);


%Existenzwahrscheinlichkeit der Fahrbahnmarkierungen
figure
ax(1)=subplot(2,1,1);
hold on
plot(fas_kamera_bv1_LIN_01_ExistMass_t00)
plot(fas_kamera_bv1_LIN_02_ExistMass_t00)
hold off
ax(2)=subplot(2,1,2);
hold on
plot(fas_kamera_bv1_LIN_01_AbstandY_t00)
plot(fas_kamera_bv1_LIN_02_AbstandY_t00)
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
yline (0,'Color','black')
plot(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00)
findpeaks(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00,'MinPeakProminence',0.0002,'MinPeakDistance',500,'MinPeakHeight',0.0002,'WidthReference','halfheight','MinPeakWidth',20)
findpeaks((-1)*fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00,'MinPeakProminence',0.0002,'MinPeakDistance',500,'MinPeakHeight',0.0002,'WidthReference','halfheight','MinPeakWidth',20)

hold off
%markiert Extrema auf Durchfahrt
scatter(xEast(Extrema(:,2)),yNorth(Extrema(:,2)),20,'blue','filled')
%markiert gueltige Extrema auf Kruemmungsverlauf
scatter(Extrema_final(:,1),1./(Extrema_final(:,2)),20,'blue','filled')

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
