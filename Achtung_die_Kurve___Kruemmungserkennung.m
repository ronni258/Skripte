%%Achtung_die_Kurve___Kruemmungserkennung
%Kurvenidentifikation, Berechnung der durchfahrenden Radien,
%Geschwindigkeiten, Querbeschleunigungen, Querablagen etc. und Darstellung
%in Graphen

failedFiles={};
FileList = dir(fullfile('D:\Messdaten\040_Volkswagen_Passat_WOB_OQ_616\Landstraße', '*.mat'));  % List of all MAT files
allData  = struct();
for iFile = 1:numel(FileList)               % Loop over found files
try
    Data   = load(fullfile('D:\Messdaten\040_Volkswagen_Passat_WOB_OQ_616\Landstraße', FileList(iFile).name));
    currentFile=FileList(iFile);%%%%%%%%%%%%%%TEST ob der Name bei den FailedFiles auftaucht
    %% Definition von variablen Randbedingungen
FileList(iFile)
% Schrittweite zwischen zwei zu betrachtenden Punkten

int=1;



% definiert die Anzahl der zu betrachteten Werte
%wird auf das 10fache der Schrittweite abgerundet
%loest das Problem, dass durch nur jeden 10ten Punkt (durch Schrittweite
%festgelegt), der wieder anschließenden Multiplikation und dass der Startpunkt
%einer Schleife bei "1" und nicht bei "0" ist, ein Punkt entsteht der nicht
%existiert: Es gibt 90002 Messpunkte / 10 --> Es werden 9000 Punkte abgelaufen, 
%beginnend bei 1 mit einer Schrittweite von 10 Punkten --> der letzte Punkt
%waere also bei 9001 das * 10 = 90010 obwohl nur 90002 Punkte vorhanden
%sind

anzahl=fix(size(Data.fas_kamera_bv1_LIN_01_AbstandY_t00,2)/(int*10))*(int*10);




% Dieses Skript errechnet anhand der durch die Kamera erkannten
% Kruemmungen der linken und rechten Fahrspurmarkierungen den Bereich der
% Kurven und deren Radien aus

Kruemmungsbearbeitung



 % dient zur Benennung und Abspeicherung
Name1 = Data.allg_datum_t00;
Name2 = Data.allg_zeit_t00;
% Bennenung der Figure
inp = 'KA_Durchfahrt_';
[~,fnm,ext] = fileparts(inp);
out = sprintf('%s',fnm,Name1,'_' ,Name2,ext);



% Querbeschleunigung geglättet, da der original Wert eine sehr schlechte
% Auflösung hat

fzg_ypp_t00_average=smoothdata(Data.fzg_ypp_t00);



% Dient der Projektion von GPS Koordiaten in ein Karthesisches Koordinatensystem

origin=[Data.gps_Breitengrad_t00(1,1) Data.gps_Laengengrad_t00(1,1) Data.gps_Hoehe_t00(1,1)];
[xEast,yNorth,zUp] = latlon2local(Data.gps_Breitengrad_t00,Data.gps_Laengengrad_t00,Data.gps_Hoehe_t00,origin);


y = yNorth(1,1:int:anzahl); 
x = xEast(1,1:int:anzahl);



%% Einfärbung der Strecke in gruene und rote Abschnitte
% hold on 
% fig=figure;
% set(fig,'Name',out)
% color = 'k';
% plot(x(1,1:1:anzahl),y(1,1:1:anzahl),color,'LineWidth',2)
% for n=1:size(Ergebnis_Kr,2)
%     if Ergebnis_Kr(2,n)<0
%         color='r'; %Rechtskurve
%     else
%         color='g'; %Linkskurve
%     end
%     hold on
%   plot(x(1,Ergebnis_Kr(5,n):1:Ergebnis_Kr(10,n)),y(1,Ergebnis_Kr(5,n):1:Ergebnis_Kr(10,n)),color,'LineWidth',3)
% end

%funktioniert noch nicht
% %% Kreiseinzeichnung
% 
% for i=1:size(Ergebnis01,2)
%     if Ergebnis01(3,i)~= 0
% hold on 
% phi=linspace(0,2*pi,10000);
% xm=Ergebnis01(1,i); % X-Wert Mittelpunkt
% ym=Ergebnis01(2,i); % Y_Wert Mittelpunkt
% rw=Ergebnis01(3,i);  % Radius
% x_KO=xm+rw*sin(phi); % KO = Kreis Original
% y_KO=ym+rw*cos(phi);
% plot(x_KO,y_KO)
%     end
% end





%% stellt auf der Z-Achse die Krümmung dar
% plot3(xEast(1,1:int:anzahl),yNorth(1,1:int:anzahl),1:int:anzahl,'MarkerSize',2,'MarkerFaceColor',[1 0 0],'Color','black');
% % plot3(xEast(1,1:int:anzahl),yNorth(1,1:int:anzahl),Lenkradwinkel(1:int:anzahl),'MarkerSize',2,'MarkerFaceColor',[1 0 0],'Color','black');
% 
% daspect([1 1 1000000])
% pbaspect([16 9 9])
% hold off


%Abspeicherung der Figure
% saveas(fig,out,'fig')
% saveas(h,name,'jpg')


%% Berechnungen

%Spurbreite der Fahrspur
Sb=Data.fas_kamera_bv1_LIN_01_AbstandY_t00+abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00);



for n=1:size(Ergebnis_Kr,2)
  
% 03.   Abschnittslaenge
    
    Ergebnis_Kr(3,n)=(Data.fzg_x_t00(1,Ergebnis_Kr(10,n))-Data.fzg_x_t00(1,Ergebnis_Kr(5,n)));

    
    
    %%% Querablage
% 14.   Querablage bei Kurvenbeginn
% 15.   Querablage bei 0.2 der Kurve
% 16.   Querablage bei 0.4 der Kurve
% 17.   Querablage bei 0.6 der Kurve
% 18.   Querablage bei 0.8 der Kurve
% 19.   Querablage bei Kurvenende
% 20.   maxmimale Querablage
% 21.   durchschnittliche Querablage

        Ergebnis_Kr(14,n)=(abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,(Ergebnis_Kr(5,n))))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,(Ergebnis_Kr(5,n))))/2;
        Ergebnis_Kr(15,n)=(abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,(Ergebnis_Kr(6,n))))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,(Ergebnis_Kr(6,n))))/2;
        Ergebnis_Kr(16,n)=(abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,(Ergebnis_Kr(7,n))))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,(Ergebnis_Kr(7,n))))/2;
        Ergebnis_Kr(17,n)=(abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,(Ergebnis_Kr(8,n))))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,(Ergebnis_Kr(8,n))))/2;
        Ergebnis_Kr(18,n)=(abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,(Ergebnis_Kr(9,n))))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,(Ergebnis_Kr(9,n))))/2;
        Ergebnis_Kr(19,n)=(abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,(Ergebnis_Kr(10,n))))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,(Ergebnis_Kr(10,n))))/2;
    if  Ergebnis_Kr(2,n)>0
        Ergebnis_Kr(20,n)=max((abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,Ergebnis_Kr(5,n):Ergebnis_Kr(10,n)))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,Ergebnis_Kr(5,n):Ergebnis_Kr(10,n)))/2);
    else
        Ergebnis_Kr(20,n)=min((abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,Ergebnis_Kr(5,n):Ergebnis_Kr(10,n)))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,Ergebnis_Kr(5,n):Ergebnis_Kr(10,n)))/2);  
    end
        Ergebnis_Kr(21,n)=mean((abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,Ergebnis_Kr(5,n):Ergebnis_Kr(10,n)))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,Ergebnis_Kr(5,n):Ergebnis_Kr(10,n)))/2);  

        
        
% 11.   Messpunkt bei der maximalen Querablage

    if isnan(Ergebnis_Kr(20,n))
        Ergebnis_Kr(11,n)=NaN;
    else
        Ergebnis_Kr(11,n)=(find(((abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,Ergebnis_Kr(5,n):Ergebnis_Kr(10,n)))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n)))/2)==Ergebnis_Kr(20,n),1,'first')-1+Ergebnis_Kr(5,n));
    end

       
 
% 25.   Spurbreite bei Kurvenbeginn
% 26.   Spurbreite bei 0.2 der Kurve
% 27.   Spurbreite bei 0.4 der Kurve
% 28.   Spurbreite bei 0.6 der Kurve
% 29.   Spurbreite bei 0.8 der Kurve
% 30.   Spurbreite bei Kurvenende
% 31.   Spurbreite bei maximaler Querablage
% 32.   durchschnittliche Spurbreite  
    
        Ergebnis_Kr(25,n)=round(Sb(1,Ergebnis_Kr(5,n)),1);
        Ergebnis_Kr(26,n)=round(Sb(1,Ergebnis_Kr(6,n)),1);
        Ergebnis_Kr(27,n)=round(Sb(1,Ergebnis_Kr(7,n)),1);
        Ergebnis_Kr(28,n)=round(Sb(1,Ergebnis_Kr(8,n)),1);
        Ergebnis_Kr(29,n)=round(Sb(1,Ergebnis_Kr(9,n)),1);
        Ergebnis_Kr(30,n)=round(Sb(1,Ergebnis_Kr(10,n)),1);
    if isnan(Ergebnis_Kr(11,n))
        Ergebnis_Kr(31,n)=NaN;
    else
        Ergebnis_Kr(31,n)=round(Sb(1,Ergebnis_Kr(11,n)),1);
    end
        Ergebnis_Kr(32,n)=round(mean(Sb(1,Ergebnis_Kr(5,n):Ergebnis_Kr(10,n))),1);


             
% 34.   normierte Querablage bei Kurvenbeginn
% 35.   normierte Querablage bei 0.2 der Kurve
% 36.   normierte Querablage bei 0.4 der Kurve
% 37.   normierte Querablage bei 0.6 der Kurve
% 38.   normierte Querablage bei 0.8 der Kurve
% 39.   normierte Querablage bei Kurvenende
% 40.   normierte maxmimale Querablage
% 41.   normierte durchschnittliche Querablage
% 42.   normierter Kurvenschneiderfaktor 
        
        Ergebnis_Kr(34,n)=Ergebnis_Kr(14,n)/Ergebnis_Kr(25,n);
        Ergebnis_Kr(35,n)=Ergebnis_Kr(15,n)/Ergebnis_Kr(26,n);
        Ergebnis_Kr(36,n)=Ergebnis_Kr(16,n)/Ergebnis_Kr(27,n);
        Ergebnis_Kr(37,n)=Ergebnis_Kr(17,n)/Ergebnis_Kr(28,n);
        Ergebnis_Kr(38,n)=Ergebnis_Kr(18,n)/Ergebnis_Kr(29,n);
        Ergebnis_Kr(39,n)=Ergebnis_Kr(19,n)/Ergebnis_Kr(30,n);
        Ergebnis_Kr(40,n)=Ergebnis_Kr(20,n)/Ergebnis_Kr(31,n);
        Ergebnis_Kr(41,n)=Ergebnis_Kr(21,n)/Ergebnis_Kr(32,n);
        Ergebnis_Kr(42,n)=Ergebnis_Kr(40,n)-Ergebnis_Kr(34,n);
        
        
        
% 45.   Kruemmung bei Kurvenbeginn
% 46.   Kruemmung bei 0.2 der Kurve
% 47.   Kruemmung bei 0.4 der Kurve
% 48.   Kruemmung bei 0.6 der Kurve
% 49.   Kruemmung bei 0.8 der Kurve
% 50.   Kruemmung bei Kurvenende
% 51.   Kruemmung bei maximaler Querablage
% 52.   maxmimale Kruemmung
% 53.   durchschnittliche Kruemmung

        Ergebnis_Kr(45,n)=fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,Ergebnis_Kr(5,n));
        Ergebnis_Kr(46,n)=fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,Ergebnis_Kr(6,n));
        Ergebnis_Kr(47,n)=fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,Ergebnis_Kr(7,n));
        Ergebnis_Kr(48,n)=fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,Ergebnis_Kr(8,n));
        Ergebnis_Kr(49,n)=fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,Ergebnis_Kr(9,n));
        Ergebnis_Kr(50,n)=fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,Ergebnis_Kr(10,n));
    if isnan(Ergebnis_Kr(11,n))
        Ergebnis_Kr(51,n)=NaN;
    else
        Ergebnis_Kr(51,n)=fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,Ergebnis_Kr(11,n));
    end
        Ergebnis_Kr(52,n)=1/Ergebnis_Kr(2,n);
        Ergebnis_Kr(53,n)=mean(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,Ergebnis_Kr(5,n):Ergebnis_Kr(10,n)));
                          

        
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

        Ergebnis_Kr(56,n)=(fzg_ypp_t00_average(1,Ergebnis_Kr(5,n)));
        Ergebnis_Kr(57,n)=(fzg_ypp_t00_average(1,Ergebnis_Kr(6,n)));
        Ergebnis_Kr(58,n)=(fzg_ypp_t00_average(1,Ergebnis_Kr(7,n)));
        Ergebnis_Kr(59,n)=(fzg_ypp_t00_average(1,Ergebnis_Kr(8,n)));
        Ergebnis_Kr(60,n)=(fzg_ypp_t00_average(1,Ergebnis_Kr(9,n)));
        Ergebnis_Kr(61,n)=(fzg_ypp_t00_average(1,Ergebnis_Kr(10,n)));
    if isnan(Ergebnis_Kr(11,n))
        Ergebnis_Kr(62,n)=NaN;
    else
        Ergebnis_Kr(62,n)=(fzg_ypp_t00_average(1,Ergebnis_Kr(11,n)));
    end
        Ergebnis_Kr(63,n)=max(fzg_ypp_t00_average(1,Ergebnis_Kr(5,n):Ergebnis_Kr(10,n)));
        Ergebnis_Kr(64,n)=min(fzg_ypp_t00_average(1,Ergebnis_Kr(5,n):Ergebnis_Kr(10,n)));
        Ergebnis_Kr(65,n)=mean(fzg_ypp_t00_average(1,Ergebnis_Kr(5,n):Ergebnis_Kr(10,n)));
        
     
        
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

        Ergebnis_Kr(67,n)=(Data.fzg_xp_t00(1,Ergebnis_Kr(5,n)));
        Ergebnis_Kr(68,n)=(Data.fzg_xp_t00(1,Ergebnis_Kr(6,n)));
        Ergebnis_Kr(69,n)=(Data.fzg_xp_t00(1,Ergebnis_Kr(7,n)));
        Ergebnis_Kr(70,n)=(Data.fzg_xp_t00(1,Ergebnis_Kr(8,n)));
        Ergebnis_Kr(71,n)=(Data.fzg_xp_t00(1,Ergebnis_Kr(9,n)));
        Ergebnis_Kr(72,n)=(Data.fzg_xp_t00(1,Ergebnis_Kr(10,n)));
    if isnan(Ergebnis_Kr(11,n))
        Ergebnis_Kr(73,n)=NaN;
    else
        Ergebnis_Kr(73,n)=(Data.fzg_xp_t00(1,Ergebnis_Kr(11,n)));
    end
        Ergebnis_Kr(74,n)=max(Data.fzg_xp_t00(1,(Ergebnis_Kr(5,n)):(Ergebnis_Kr(10,n))));
        Ergebnis_Kr(75,n)=min(Data.fzg_xp_t00(1,(Ergebnis_Kr(5,n)):(Ergebnis_Kr(10,n))));
        Ergebnis_Kr(76,n)=mean(Data.fzg_xp_t00(1,(Ergebnis_Kr(5,n)):(Ergebnis_Kr(10,n))));
end

catch exeption  % aufgetretender Fehler wird abgespeichert,
    failedFiles=[failedFiles;{'FileList(iFile).name'}];
continue        % anschließend übersprungen und es wird mit dem nächsten Datensatz weitergemacht
end


%Abspeicherung des Ergebnisvektors
inp = 'Ergebnis_Kr_.mat';
[~,fnm,ext] = fileparts(inp);
out = sprintf('%s',fnm,Name1,'_' ,Name2,ext);
% save(['F:\Eigene Dateien\01_Tu Braunschweig\IfF\Masterarbeit\05_Datenauswertung\aufbereitete_Daten\Ergebnisvektor\' out],Ergebnis01_kM )
save(out,'Ergebnis_Kr')
end

Datenzusammenfuehrung_Kruemmung
Nachbereitung_Kruemmung
Auswertung_Kruemmung

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