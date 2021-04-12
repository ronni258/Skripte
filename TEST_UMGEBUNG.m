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




