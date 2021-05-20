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




% Dieses Skript rechnet anhand der durch die Kamera erkannten
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


%% Berechnungen Teil 1
% Punkte für alle Variabeln bei 10%, 30%, 50% und 70% der Kurvendistanz 

%Spurbreite der Fahrspur
Sb=Data.fas_kamera_bv1_LIN_01_AbstandY_t00+abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00);



for n=1:size(Ergebnis_Kr,2)
  
% 03.   Abschnittslaenge
    
    Ergebnis_Kr(3,n)=(Data.fzg_x_t00(1,Ergebnis_Kr(10,n))-Data.fzg_x_t00(1,Ergebnis_Kr(5,n)));

    
    
    %%% Querablage
% 14.   Querablage bei Kurvenbeginn
% 15.   Querablage bei 0.1 der Kurve
% 16.   Querablage bei 0.3 der Kurve
% 17.   Querablage bei 0.5 der Kurve
% 18.   Querablage bei 0.7 der Kurve
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
% 26.   Spurbreite bei 0.1 der Kurve
% 27.   Spurbreite bei 0.3 der Kurve
% 28.   Spurbreite bei 0.5 der Kurve
% 29.   Spurbreite bei 0.7 der Kurve
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
% 35.   normierte Querablage bei 0.1 der Kurve
% 36.   normierte Querablage bei 0.3 der Kurve
% 37.   normierte Querablage bei 0.5 der Kurve
% 38.   normierte Querablage bei 0.7 der Kurve
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
% 46.   Kruemmung bei 0.1 der Kurve
% 47.   Kruemmung bei 0.3 der Kurve
% 48.   Kruemmung bei 0.5 der Kurve
% 49.   Kruemmung bei 0.7 der Kurve
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
% 57.   Querbeschleunigung bei 0.1 der Kurve
% 58.   Querbeschleunigung bei 0.3 der Kurve
% 59.   Querbeschleunigung bei 0.5 der Kurve
% 60.   Querbeschleunigung bei 0.7 der Kurve
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
% 68.   Geschwindigkeit bei 0.1 der Kurve
% 69.   Geschwindigkeit bei 0.3 der Kurve
% 70.   Geschwindigkeit bei 0.5 der Kurve
% 71.   Geschwindigkeit bei 0.7 der Kurve
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

  
        
%% Berechnungen Teil 2          
% Punkte für alle Variabeln bei 20%, 40%, 60% und 80% der Kurvendistanz         

% 79.   realtive Kurvendistanz bei Kurvenbeginn (immer 0)
% 80.   realtive Kurvendistanz bei 0.2 der Kurve
% 81.   realtive Kurvendistanz bei 0.4 der Kurve
% 82.   realtive Kurvendistanz bei 0.6 der Kurve
% 83.   realtive Kurvendistanz bei 0.8 der Kurve
% 84.   realtive Kurvendistanz bei Kurvenende (entspricht Kurvenlaenge)
% 85.   realtive Kurvendistanz bei maximaler Querablage
        
        Kl=Data.fzg_x_t00(Ergebnis_Kr(10,n))-Data.fzg_x_t00(Ergebnis_Kr(5,n)); %Kl= Kurvenlaenge
        Ergebnis_Kr(79,n)=0;
        Ergebnis_Kr(80,n)=Kl*0.2;
        Ergebnis_Kr(81,n)=Kl*0.4;
        Ergebnis_Kr(82,n)=Kl*0.6;
        Ergebnis_Kr(83,n)=Kl*0.8;
        Ergebnis_Kr(84,n)=Kl;
    if isnan(Ergebnis_Kr(11,n))
        Ergebnis_Kr(85,n)=NaN;
    else        
        Ergebnis_Kr(85,n)=Data.fzg_x_t00(Ergebnis_Kr(11,n))-Data.fzg_x_t00(Ergebnis_Kr(5,n));
    end



% 88.   Messpunkt der realtiven Kurvendistanz bei Kurvenbeginn
% 89.   Messpunkt der realtiven Kurvendistanz bei 0.2 der Kurve
% 90.   Messpunkt der realtiven Kurvendistanz bei 0.4 der Kurve
% 91.   Messpunkt der realtiven Kurvendistanz bei 0.6 der Kurve
% 92.   Messpunkt der realtiven Kurvendistanz bei 0.8 der Kurve
% 93.   Messpunkt der realtiven Kurvendistanz bei Kurvenende
% 94.   Messpunkt der realtiven Kurvendistanz bei maximaler Querablage
        
        Ergebnis_Kr(88,n)=Ergebnis_Kr(5,n);
        Ergebnis_Kr(89,n)=find(Data.fzg_x_t00>Data.fzg_x_t00(Ergebnis_Kr(5,n))+(Kl*0.2),1,'first');
        Ergebnis_Kr(90,n)=find(Data.fzg_x_t00>Data.fzg_x_t00(Ergebnis_Kr(5,n))+(Kl*0.4),1,'first');
        Ergebnis_Kr(91,n)=find(Data.fzg_x_t00>Data.fzg_x_t00(Ergebnis_Kr(5,n))+(Kl*0.6),1,'first');
        Ergebnis_Kr(92,n)=find(Data.fzg_x_t00>Data.fzg_x_t00(Ergebnis_Kr(5,n))+(Kl*0.8),1,'first');
        Ergebnis_Kr(93,n)=Ergebnis_Kr(10,n);
    if isnan(Ergebnis_Kr(11,n))
        Ergebnis_Kr(94,n)=NaN;
    else        
        Ergebnis_Kr(94,n)=find(Data.fzg_x_t00>Data.fzg_x_t00(Ergebnis_Kr(5,n))+(Data.fzg_x_t00(Ergebnis_Kr(11,n))-Data.fzg_x_t00(Ergebnis_Kr(5,n))),1,'first');
    end
     
        

% 97.   Querablage bei Kurvenbeginn
% 98.   Querablage bei 0.2 der Kurve
% 99.   Querablage bei 0.4 der Kurve
% 100.  Querablage bei 0.6 der Kurve
% 101.  Querablage bei 0.8 der Kurve
% 102.  Querablage bei Kurvenende
% 103.  maxmimale Querablage
% 104.  durchschnittliche Querablage

        Ergebnis_Kr(97,n)=(abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,(Ergebnis_Kr(88,n))))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,(Ergebnis_Kr(88,n))))/2;
        Ergebnis_Kr(98,n)=(abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,(Ergebnis_Kr(89,n))))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,(Ergebnis_Kr(89,n))))/2;
        Ergebnis_Kr(99,n)=(abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,(Ergebnis_Kr(90,n))))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,(Ergebnis_Kr(90,n))))/2;
        Ergebnis_Kr(100,n)=(abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,(Ergebnis_Kr(91,n))))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,(Ergebnis_Kr(91,n))))/2;
        Ergebnis_Kr(101,n)=(abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,(Ergebnis_Kr(92,n))))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,(Ergebnis_Kr(92,n))))/2;
        Ergebnis_Kr(102,n)=(abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,(Ergebnis_Kr(93,n))))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,(Ergebnis_Kr(93,n))))/2;
    if  Ergebnis_Kr(2,n)>0
        Ergebnis_Kr(103,n)=max((abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,Ergebnis_Kr(88,n):Ergebnis_Kr(93,n)))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,Ergebnis_Kr(88,n):Ergebnis_Kr(93,n)))/2);
    else
        Ergebnis_Kr(103,n)=min((abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,Ergebnis_Kr(88,n):Ergebnis_Kr(93,n)))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,Ergebnis_Kr(88,n):Ergebnis_Kr(93,n)))/2);  
    end
        Ergebnis_Kr(104,n)=mean((abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,Ergebnis_Kr(88,n):Ergebnis_Kr(93,n)))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,Ergebnis_Kr(88,n):Ergebnis_Kr(93,n)))/2);  

        
        
% 94.   Messpunkt bei der maximalen Querablage

    if isnan(Ergebnis_Kr(103,n))
        Ergebnis_Kr(94,n)=NaN;
    else
        Ergebnis_Kr(94,n)=(find(((abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,Ergebnis_Kr(88,n):Ergebnis_Kr(93,n)))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(Ergebnis_Kr(88,n):Ergebnis_Kr(93,n)))/2)==Ergebnis_Kr(103,n),1,'first')-1+Ergebnis_Kr(88,n));
    end

    
 
% 108.   Spurbreite bei Kurvenbeginn
% 109.   Spurbreite bei 0.2 der Kurve
% 110.   Spurbreite bei 0.4 der Kurve
% 111.   Spurbreite bei 0.6 der Kurve
% 112.   Spurbreite bei 0.8 der Kurve
% 113.   Spurbreite bei Kurvenende
% 114.   Spurbreite bei maximaler Querablage
% 115.   durchschnittliche Spurbreite  
       
        Ergebnis_Kr(108,n)=round(Sb(1,Ergebnis_Kr(88,n)),1);
        Ergebnis_Kr(109,n)=round(Sb(1,Ergebnis_Kr(89,n)),1);
        Ergebnis_Kr(110,n)=round(Sb(1,Ergebnis_Kr(90,n)),1);
        Ergebnis_Kr(111,n)=round(Sb(1,Ergebnis_Kr(91,n)),1);
        Ergebnis_Kr(112,n)=round(Sb(1,Ergebnis_Kr(92,n)),1);
        Ergebnis_Kr(113,n)=round(Sb(1,Ergebnis_Kr(93,n)),1);
    if isnan(Ergebnis_Kr(94,n))
        Ergebnis_Kr(114,n)=NaN;
    else
        Ergebnis_Kr(114,n)=round(Sb(1,Ergebnis_Kr(94,n)),1);
    end
        Ergebnis_Kr(115,n)=round(mean(Sb(1,Ergebnis_Kr(88,n):Ergebnis_Kr(93,n))),1);



% 117.   normierte Querablage bei Kurvenbeginn
% 118.   normierte Querablage bei 0.2 der Kurve
% 119.   normierte Querablage bei 0.4 der Kurve
% 120.   normierte Querablage bei 0.6 der Kurve
% 121.   normierte Querablage bei 0.8 der Kurve
% 122.   normierte Querablage bei Kurvenende
% 123.   normierte maxmimale Querablage
% 124.   normierte durchschnittliche Querablage
% 125.   normierter Kurvenschneiderfaktor 

        Ergebnis_Kr(117,n)=Ergebnis_Kr(97,n)/Ergebnis_Kr(108,n);
        Ergebnis_Kr(118,n)=Ergebnis_Kr(98,n)/Ergebnis_Kr(109,n);
        Ergebnis_Kr(119,n)=Ergebnis_Kr(99,n)/Ergebnis_Kr(110,n);
        Ergebnis_Kr(120,n)=Ergebnis_Kr(100,n)/Ergebnis_Kr(111,n);
        Ergebnis_Kr(121,n)=Ergebnis_Kr(101,n)/Ergebnis_Kr(112,n);
        Ergebnis_Kr(122,n)=Ergebnis_Kr(102,n)/Ergebnis_Kr(113,n);
        Ergebnis_Kr(123,n)=Ergebnis_Kr(103,n)/Ergebnis_Kr(114,n);
        Ergebnis_Kr(124,n)=Ergebnis_Kr(104,n)/Ergebnis_Kr(115,n);
        Ergebnis_Kr(125,n)=Ergebnis_Kr(123,n)-Ergebnis_Kr(117,n);

        
        
% 128.   Kruemmung bei Kurvenbeginn
% 129.   Kruemmung bei 0.2 der Kurve
% 130.   Kruemmung bei 0.4 der Kurve
% 131.   Kruemmung bei 0.6 der Kurve
% 132.   Kruemmung bei 0.8 der Kurve
% 133.   Kruemmung bei Kurvenende
% 134.   Kruemmung bei maximaler Querablage
% 135.   maxmimale Kruemmung
% 136.   durchschnittliche Kruemmung

        Ergebnis_Kr(128,n)=fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,Ergebnis_Kr(88,n));
        Ergebnis_Kr(129,n)=fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,Ergebnis_Kr(89,n));
        Ergebnis_Kr(130,n)=fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,Ergebnis_Kr(90,n));
        Ergebnis_Kr(131,n)=fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,Ergebnis_Kr(91,n));
        Ergebnis_Kr(132,n)=fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,Ergebnis_Kr(92,n));
        Ergebnis_Kr(133,n)=fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,Ergebnis_Kr(93,n));
    if isnan(Ergebnis_Kr(94,n))
        Ergebnis_Kr(134,n)=NaN;
    else
        Ergebnis_Kr(134,n)=fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,Ergebnis_Kr(94,n));
    end
        Ergebnis_Kr(135,n)=1/Ergebnis_Kr(2,n);
        Ergebnis_Kr(136,n)=mean(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,Ergebnis_Kr(88,n):Ergebnis_Kr(93,n)));
                          

        
% 139.   Querbeschleunigung bei Kurvenbeginn
% 140.   Querbeschleunigung bei 0.2 der Kurve
% 141.   Querbeschleunigung bei 0.4 der Kurve
% 142.   Querbeschleunigung bei 0.6 der Kurve
% 143.   Querbeschleunigung bei 0.8 der Kurve
% 144.   Querbeschleunigung bei Kurvenende
% 145.   Querbeschleunigung bei maximaler Querablage
% 146.   maxmimale Querbeschleunigung
% 147.   minimale Querbeschleunigung
% 148.   durchschnittliche Querbeschleunigung

        Ergebnis_Kr(139,n)=(fzg_ypp_t00_average(1,Ergebnis_Kr(88,n)));
        Ergebnis_Kr(140,n)=(fzg_ypp_t00_average(1,Ergebnis_Kr(89,n)));
        Ergebnis_Kr(141,n)=(fzg_ypp_t00_average(1,Ergebnis_Kr(90,n)));
        Ergebnis_Kr(142,n)=(fzg_ypp_t00_average(1,Ergebnis_Kr(91,n)));
        Ergebnis_Kr(143,n)=(fzg_ypp_t00_average(1,Ergebnis_Kr(92,n)));
        Ergebnis_Kr(144,n)=(fzg_ypp_t00_average(1,Ergebnis_Kr(93,n)));
    if isnan(Ergebnis_Kr(94,n))
        Ergebnis_Kr(145,n)=NaN;
    else
        Ergebnis_Kr(145,n)=(fzg_ypp_t00_average(1,Ergebnis_Kr(94,n)));
    end
        Ergebnis_Kr(146,n)=max(fzg_ypp_t00_average(1,Ergebnis_Kr(88,n):Ergebnis_Kr(93,n)));
        Ergebnis_Kr(147,n)=min(fzg_ypp_t00_average(1,Ergebnis_Kr(88,n):Ergebnis_Kr(93,n)));
        Ergebnis_Kr(148,n)=mean(fzg_ypp_t00_average(1,Ergebnis_Kr(88,n):Ergebnis_Kr(93,n)));
      

        
% 150.   Geschwindigkeit bei Kurvenbeginn
% 151.   Geschwindigkeit bei 0.2 der Kurve
% 152.   Geschwindigkeit bei 0.4 der Kurve
% 153.   Geschwindigkeit bei 0.6 der Kurve
% 154.   Geschwindigkeit bei 0.8 der Kurve
% 155.   Geschwindigkeit bei Kurvenende
% 156.   Geschwindigkeit bei maximaler Querablage
% 157.   maxmimale Geschwindigkeit
% 158.   minimale Geschwindigkeit
% 159.   durchschnittliche Geschwindigkeit

        Ergebnis_Kr(150,n)=(Data.fzg_xp_t00(1,Ergebnis_Kr(88,n)));
        Ergebnis_Kr(151,n)=(Data.fzg_xp_t00(1,Ergebnis_Kr(89,n)));
        Ergebnis_Kr(152,n)=(Data.fzg_xp_t00(1,Ergebnis_Kr(90,n)));
        Ergebnis_Kr(153,n)=(Data.fzg_xp_t00(1,Ergebnis_Kr(91,n)));
        Ergebnis_Kr(154,n)=(Data.fzg_xp_t00(1,Ergebnis_Kr(92,n)));
        Ergebnis_Kr(155,n)=(Data.fzg_xp_t00(1,Ergebnis_Kr(93,n)));
    if isnan(Ergebnis_Kr(94,n))
        Ergebnis_Kr(156,n)=NaN;
    else
        Ergebnis_Kr(156,n)=(Data.fzg_xp_t00(1,Ergebnis_Kr(94,n)));
    end
        Ergebnis_Kr(157,n)=max(Data.fzg_xp_t00(1,(Ergebnis_Kr(88,n)):(Ergebnis_Kr(93,n))));
        Ergebnis_Kr(158,n)=min(Data.fzg_xp_t00(1,(Ergebnis_Kr(88,n)):(Ergebnis_Kr(93,n))));
        Ergebnis_Kr(159,n)=mean(Data.fzg_xp_t00(1,(Ergebnis_Kr(88,n)):(Ergebnis_Kr(93,n)))); 
        
        
        
% 162.   realtive Kurvendistanz bei Kurvenbeginn (immer 0)       [m]
% 163.   realtive Kurvendistanz 0.1 der Kurve (10% der Distanz)  [m]
% 164.   realtive Kurvendistanz 0.3 der Kurve (30% der Distanz)  [m]
% 165.   realtive Kurvendistanz 0.5 der Kurve (50% der Distanz)  [m]
% 166.   realtive Kurvendistanz 0.7 der Kurve (70% der Distanz)  [m]
% 167.   realtive Kurvendistanz bei Kurvenende
        
        Ergebnis_Kr(162,n)=Data.fzg_x_t00(Ergebnis_Kr(5,n))-Data.fzg_x_t00(Ergebnis_Kr(5,n));
        Ergebnis_Kr(163,n)=Kl*0.1;
        Ergebnis_Kr(164,n)=Kl*0.3;
        Ergebnis_Kr(165,n)=Kl*0.5;
        Ergebnis_Kr(166,n)=Kl*0.7;
        Ergebnis_Kr(167,n)=Data.fzg_x_t00(Ergebnis_Kr(10,n))-Data.fzg_x_t00(Ergebnis_Kr(5,n));        
        
    
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
% Bis 76. beziehen sich die Werte fuer die Punkte bei 0.2, 0.4, 0.6, und
% 0.8 einer Kurve auf die Anzahl der Messpunkte (sind also
% geschwindigkeitsabhaengig, da mit 100Hz gemessen wird.
% Ab 79. werden die gleichen Punkte anhand der zurueckgelgten Distanz
% innerhalt einer Kurve gemessen, somit sind die Werte streckenabhaengig

% 01.   Messpunkt des minimalen Radius/maximalen Kruemmung der Gesamtkurve
% 02.   minimaler Radius der Gesamtkurve [m] (kleinster Radius definiert die Kurve)  
% 03.   Laenge des Abschnitts [m]
% 04.   0
% 05.   Messpunkt bei Kurvenbeginn
% 06.   Messpunkt bei 0.1 der Kurve (Distanz)
% 07.   Messpunkt bei 0.3 der Kurve (Distanz)
% 08.   Messpunkt bei 0.5 der Kurve (Distanz)
% 09.   Messpunkt bei 0.7 der Kurve (Distanz)
% 10.   Messpunkt bei Kurvenende
% 11.   Messpunkt bei der maximalen Querablage
% 12.   0
% 13.   0
% 14.   Querablage bei Kurvenbeginn  [m]
% 15.   Querablage bei 0.1 der Kurve (Distanz)
% 16.   Querablage bei 0.3 der Kurve (Distanz)
% 17.   Querablage bei 0.5 der Kurve (Distanz)
% 18.   Querablage bei 0.7 der Kurve (Distanz)
% 19.   Querablage bei Kurvenende
% 20.   maxmimale Querablage
% 21.   durchschnittliche Querablage
% 22.   0
% 23.   0
% 24.   0
% 25.   Spurbreite bei Kurvenbeginn  [m]
% 26.   Spurbreite bei 0.1 der Kurve (Distanz)
% 27.   Spurbreite bei 0.3 der Kurve (Distanz)
% 28.   Spurbreite bei 0.5 der Kurve (Distanz)
% 29.   Spurbreite bei 0.7 der Kurve (Distanz)
% 30.   Spurbreite bei Kurvenende
% 31.   Spurbreite bei maximaler Querablage
% 32.   durchschnittliche Spurbreite
% 33.   0
% 34.   normierte Querablage bei Kurvenbeginn
% 35.   normierte Querablage bei 0.1 der Kurve (Distanz)
% 36.   normierte Querablage bei 0.3 der Kurve (Distanz)
% 37.   normierte Querablage bei 0.5 der Kurve (Distanz)
% 38.   normierte Querablage bei 0.7 der Kurve (Distanz)
% 39.   normierte Querablage bei Kurvenende
% 40.   maxmimale normierte Querablage
% 41.   durchschnittliche normierte Querablage
% 42.   normierter Kurvenschneiderfaktor
% 43.   0
% 44.   0
% 45.   Kruemmung bei Kurvenbeginn  [1/m]
% 46.   Kruemmung bei 0.1 der Kurve (Distanz)
% 47.   Kruemmung bei 0.3 der Kurve (Distanz)
% 48.   Kruemmung bei 0.5 der Kurve (Distanz)
% 49.   Kruemmung bei 0.7 der Kurve (Distanz)
% 50.   Kruemmung bei Kurvenende
% 51.   Kruemmung bei maximaler Querablage
% 52.   maxmimale Kruemmung
% 53.   durchschnittliche Kruemmung
% 54.   0
% 55.   0
% 56.   Querbeschleunigung bei Kurvenbeginn  [m/s^2]
% 57.   Querbeschleunigung bei 0.1 der Kurve (Distanz)
% 58.   Querbeschleunigung bei 0.3 der Kurve (Distanz)
% 59.   Querbeschleunigung bei 0.5 der Kurve (Distanz)
% 60.   Querbeschleunigung bei 0.7 der Kurve (Distanz)
% 61.   Querbeschleunigung bei Kurvenende
% 62.   Querbeschleunigung bei maximaler Querablage
% 63.   maxmimale Querbeschleunigung
% 64.   minimale Querbeschleunigung
% 65.   durchschnittliche Querbeschleunigung
% 66.   0
% 67.   Geschwindigkeit bei Kurvenbeginn  [km/h]
% 68.   Geschwindigkeit bei 0.1 der Kurve (Distanz)
% 69.   Geschwindigkeit bei 0.3 der Kurve (Distanz)
% 70.   Geschwindigkeit bei 0.5 der Kurve (Distanz)
% 71.   Geschwindigkeit bei 0.7 der Kurve (Distanz)
% 72.   Geschwindigkeit bei Kurvenende
% 73.   Geschwindigkeit bei maximaler Querablage
% 74.   maxmimale Geschwindigkeit
% 75.   minimale Geschwindigkeit
% 76.   durchschnittliche Geschwindigkeit
% 77.   0
% 78.   0
% 79.   realtive Kurvendistanz bei Kurvenbeginn (immer 0)  [m]
% 80.   realtive Kurvendistanz bei 0.2 der Kurve (Distanz)
% 81.   realtive Kurvendistanz bei 0.4 der Kurve (Distanz)
% 82.   realtive Kurvendistanz bei 0.6 der Kurve (Distanz)
% 83.   realtive Kurvendistanz bei 0.8 der Kurve (Distanz)
% 84.   realtive Kurvendistanz bei Kurvenende (entspricht Kurvenlaenge)
% 85.   realtive Kurvendistanz bei maximaler Querablage
% 86.   0
% 87.   0
% 88.   Messpunkt der realtiven Kurvendistanz bei Kurvenbeginn
% 89.   Messpunkt der realtiven Kurvendistanz bei 0.2 der Kurve (Distanz)
% 90.   Messpunkt der realtiven Kurvendistanz bei 0.4 der Kurve (Distanz)
% 91.   Messpunkt der realtiven Kurvendistanz bei 0.6 der Kurve (Distanz)
% 92.   Messpunkt der realtiven Kurvendistanz bei 0.8 der Kurve (Distanz)
% 93.   Messpunkt der realtiven Kurvendistanz bei Kurvenende
% 94.   Messpunkt der realtiven Kurvendistanz bei maximaler Querablage
% 95.   0
% 96.   0
% 97.   Querablage bei Kurvenbeginn  [m]
% 98.   Querablage bei 0.2 der Kurve (Distanz)
% 99.   Querablage bei 0.4 der Kurve (Distanz)
% 100.  Querablage bei 0.6 der Kurve (Distanz)
% 101.  Querablage bei 0.8 der Kurve (Distanz)
% 102.  Querablage bei Kurvenende
% 103.  maxmimale Querablage
% 104.  durchschnittliche Querablage
% 105.   0
% 106.   0
% 107.   0
% 108.   Spurbreite bei Kurvenbeginn  [m]
% 109.   Spurbreite bei 0.2 der Kurve (Distanz)
% 110.   Spurbreite bei 0.4 der Kurve (Distanz)
% 111.   Spurbreite bei 0.6 der Kurve (Distanz)
% 112.   Spurbreite bei 0.8 der Kurve (Distanz)
% 113.   Spurbreite bei Kurvenende
% 114.   Spurbreite bei maximaler Querablage
% 115.   durchschnittliche Spurbreite  
% 116.   0
% 117.   normierte Querablage bei Kurvenbeginn
% 118.   normierte Querablage bei 0.2 der Kurve (Distanz)
% 119.   normierte Querablage bei 0.4 der Kurve (Distanz)
% 120.   normierte Querablage bei 0.6 der Kurve (Distanz)
% 121.   normierte Querablage bei 0.8 der Kurve (Distanz)
% 122.   normierte Querablage bei Kurvenende
% 123.   normierte maxmimale Querablage
% 124.   normierte durchschnittliche Querablage
% 125.   normierter Kurvenschneiderfaktor 
% 126.   0
% 127.   0
% 128.   Kruemmung bei Kurvenbeginn  [1/m]
% 129.   Kruemmung bei 0.2 der Kurve (Distanz)
% 130.   Kruemmung bei 0.4 der Kurve (Distanz)
% 131.   Kruemmung bei 0.6 der Kurve (Distanz)
% 132.   Kruemmung bei 0.8 der Kurve (Distanz)
% 133.   Kruemmung bei Kurvenende
% 134.   Kruemmung bei maximaler Querablage
% 135.   maxmimale Kruemmung
% 136.   durchschnittliche Kruemmung
% 137.   0
% 138.   0
% 139.   Querbeschleunigung bei Kurvenbeginn  [m/s^2]
% 140.   Querbeschleunigung bei 0.2 der Kurve (Distanz)
% 141.   Querbeschleunigung bei 0.4 der Kurve (Distanz)
% 142.   Querbeschleunigung bei 0.6 der Kurve (Distanz)
% 143.   Querbeschleunigung bei 0.8 der Kurve (Distanz)
% 144.   Querbeschleunigung bei Kurvenende
% 145.   Querbeschleunigung bei maximaler Querablage
% 146.   maxmimale Querbeschleunigung
% 147.   minimale Querbeschleunigung
% 148.   durchschnittliche Querbeschleunigung
% 149.   0
% 150.   Geschwindigkeit bei Kurvenbeginn  [km/h]
% 151.   Geschwindigkeit bei 0.2 der Kurve (Distanz)
% 152.   Geschwindigkeit bei 0.4 der Kurve (Distanz)
% 153.   Geschwindigkeit bei 0.6 der Kurve (Distanz)
% 154.   Geschwindigkeit bei 0.8 der Kurve (Distanz)
% 155.   Geschwindigkeit bei Kurvenende
% 156.   Geschwindigkeit bei maximaler Querablage
% 157.   maxmimale Geschwindigkeit
% 158.   minimale Geschwindigkeit
% 159.   durchschnittliche Geschwindigkeit
% 160.   0
% 161.   0
% 162.   realtive Kurvendistanz bei Kurvenbeginn (immer 0)       [m]
% 163.   realtive Kurvendistanz 0.2 der Kurve (20% der Distanz)  [m]
% 164.   realtive Kurvendistanz 0.4 der Kurve (40% der Distanz)  [m]
% 165.   realtive Kurvendistanz 0.6 der Kurve (60% der Distanz)  [m]
% 166.   realtive Kurvendistanz 0.8 der Kurve (80% der Distanz)  [m]
% 167.   realtive Kurvendistanz bei Kurvenende