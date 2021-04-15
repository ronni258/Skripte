
failedFiles={};
FileList = dir(fullfile('D:\Messdaten\040_Volkswagen_Passat_WOB_OQ_616\Landstraße', '*.mat'));  % List of all MAT files
allData  = struct();
for iFile = 1:numel(FileList)               % Loop over found files
 try % falls ein Fehler aufgrund eines unvollständigen Datensatzes entsteht, soll dieser Datensatz übersprungen werden
    Data   = load(fullfile('D:\Messdaten\040_Volkswagen_Passat_WOB_OQ_616\Landstraße', FileList(iFile).name));
    currentFile=FileList(iFile);%%%%%%%%%%%%%%TEST ob der Name bei den FailedFiles auftaucht

 % dient zur Benennung und Abspeicherung
Name1 = Data.allg_datum_t00;
Name2 = Data.allg_zeit_t00;
% Bennenung der Figure
inp = 'Durchfahrt_';
[~,fnm,ext] = fileparts(inp);
out = sprintf('%s',fnm,Name1,'_' ,Name2,ext);

int=10; % Schrittweite zwischen zwei Messpunkten

%loest das Problem, dass durch nur jeden 10ten Punkt (durch Schrittweite
%festgelegt), der wieder anschließenden Multiplikation und dem Startpunkt
%einer Schleife bei "1" und nicht bei "0" ein Punkt entsteht der nicht
%existiert: Es gibt 90002 Punkte / 10 --> Es werden 9000 beginnend Punkte abgelaufen, geginnend bei 1 und dann alle 10
%Punkte --> der letzte Punkt waere also bei 9001 das * 10 = 90010 obwohl
%nur 90002 Punkte vorhanden
anzahl=fix(size(Data.gps_Laengengrad_t00,2)/100)*100;
% anzahl=90000;


% Querbeschleunigung geglättet, da der original Wert eine sehr schlechte
% Auflösung hat
Data.fzg_ypp_t00_average=smoothdata(Data.fzg_ypp_t00);



% Dient der Projektion von GPS Koordiaten in ein Karthesisches Koordinatensystem
origin=[Data.gps_Breitengrad_t00(1,1) Data.gps_Laengengrad_t00(1,1) Data.gps_Hoehe_t00(1,1)];
[xEast,yNorth,zUp] = latlon2local(Data.gps_Breitengrad_t00,Data.gps_Laengengrad_t00,Data.gps_Hoehe_t00,origin);


y = yNorth(1,1:int:anzahl); %gps_Breitengrad_t00(1,1:int:anzahl);
x = xEast(1,1:int:anzahl);%gps_Laengengrad_t00(1,1:int:anzahl);

% Passt die Entfernung des Fahrzeugs zur Linie an. Wird normalerweise keine
% Linie erkannt, wo wird die Entfernung auf 0 gesetzt --> das führt zu
% Fehlern bei der Berechnung der Spurbreite, Querablage... . Um das zu
% verhindern soll die Entfernung auf "NaN" gesetzt werden, wenn die
% Wahrscheinlichkeit für einer Markierung
% (Data.fas_kamera_bv1_LIN_01_ExistMass_t00) < 0,6 ist UND der Abstand innerhalb
% von 5 Messpunkten auch 0 erreicht. So werden gewollte Spurüberquerungen
% bei denen der Abstand = 0 ist nicht gelöscht und außerdem auch Passagen
% bei denen die Wahrscheinlichkeit 0 ist, aber trotzdem eine Linie erkannt
% wird und der Abstand ~= 0 ist toleriert

for c=1:anzahl
    if c < anzahl-10 && c > 10 %sorgt dafür, dass bei "n+5" nicht über den maximalen Rand nach Werten gesucht wird
        if Data.fas_kamera_bv1_LIN_01_ExistMass_t00(1,c) < 0.6 && Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,c+5)==0 || Data.fas_kamera_bv1_LIN_01_ExistMass_t00(1,c) < 0.6 && Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,c-5)==0 %
   Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,c)=NaN;
        end
        
    elseif c < 10
        if Data.fas_kamera_bv1_LIN_01_ExistMass_t00(1,c) < 0.6 && Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,c+5)==0 || Data.fas_kamera_bv1_LIN_01_ExistMass_t00(1,c) < 0.6 && Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,c)==0 %
   Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,c)=NaN;
        end
 
    else
        if Data.fas_kamera_bv1_LIN_01_ExistMass_t00(1,c) < 0.6 && Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,c)==0 || Data.fas_kamera_bv1_LIN_01_ExistMass_t00(1,c) < 0.6 && Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,c-5)==0
   Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,c)=NaN;
        end 
    end
end

for c=1:anzahl
    if c < anzahl-10 && c > 10 %sorgt dafür, dass bei "n+5" nicht über den maximalen Rand nach Werten gesucht wird
        if Data.fas_kamera_bv1_LIN_02_ExistMass_t00(1,c) < 0.6 && Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,c+5)==0 || Data.fas_kamera_bv1_LIN_02_ExistMass_t00(1,c) < 0.6 && Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,c-5)==0 %
   Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,c)=NaN;
        end
        
    elseif c < 10
        if Data.fas_kamera_bv1_LIN_02_ExistMass_t00(1,c) < 0.6 && Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,c+5)==0 || Data.fas_kamera_bv1_LIN_02_ExistMass_t00(1,c) < 0.6 && Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,c)==0 %
   Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,c)=NaN;
        end
 
    else
        if Data.fas_kamera_bv1_LIN_02_ExistMass_t00(1,c) < 0.6 && Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,c)==0 || Data.fas_kamera_bv1_LIN_02_ExistMass_t00(1,c) < 0.6 && Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,c-5)==0
   Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,c)=NaN;
        end 
    end
end



Start = 1;       %Startwert der Punkte
Ende=size(x,2);  %Endwert der Punkte
% Ende = 902;

minAbst = 2;  %minimale Anzahl der zu betrachtenden Punkte fuer eine Kurve, verhindert zu viele Kreise
maxPoints = 2000; %maximale Anzahl der zu betrachtenden Punkte fuer eine Kurve, kann zur beschleunigung genutzt werden

deltaR = 15; %Maximaler Abstand eines Punktes, auf einem Kreis, zu dem angenaehrten Kreis

Ergebnis01=[];
Ergebnis01_kM=[];

N=Ende;
i = Start;
while i+minAbst+20<N
    
    E=NaN(1,N);
    a=NaN(1,N);    
    b=NaN(1,N);
    r=NaN(1,N);
    maxMinR=NaN(2,N);
    
    for j=i+minAbst:N                                             
        %CircleFitByKasa  CircleFitByPratt
        [A,B,R]=CircleFitByKasa(x,y,i,j);     
        a(1,j)=A;
        b(1,j)=B;
        r(1,j)=R;
 
        maxMinR(1,j) = R;
        maxMinR(2,j) = R;
        for w=i:j
            if((A-x(1,w)).^2+(B-y(1,w)).^2)>maxMinR(1,j).^2
                maxMinR(1,j) = sqrt((A-x(1,w)).^2+(B-y(1,w)).^2);
            end
            if((A-x(1,w)).^2+(B-y(1,w)).^2)<maxMinR(2,j).^2
                maxMinR(2,j) = sqrt((A-x(1,w)).^2+(B-y(1,w)).^2);
            end
        end  
        if j>i+maxPoints
            break
        end
    end
    diff = maxMinR(1,i:N)-maxMinR(2,i:N);
    posMin = find(islocalmin(diff)==1); %gibt Positionen der lokalen Minima aus
    
    
    k=1;
    if size(posMin,2) >= 1
        while k<=size(posMin,2) && diff(1,posMin(1,k)) <= deltaR  
            k=k+1; 
        end
        if k>1 &&(posMin(1,k-1))>minAbst
            i=i+1+ posMin(1,k-1)
        else 
            [minValue, closestIndex] = min(abs(diff(1,:) - deltaR))
            i=i+closestIndex
        end
    end

    k=size(Ergebnis01,2)+1;
    
    if k>2 && Ergebnis01(4,k-1) == i
        break;
    end
            
% Betrachtung ob die jeweiligen Kurven auch die Randbedingungen der Gierrate, Kruemmung und Wegstrecke einhalten
% Kruemmung  > 0,1 [1/m]
% Gierrate   > 0,1 [°/s]
% Wegstrecke > 150 [m]   

   if k==1 %Ergebnisse sollen nur aufgeschrieben werden, wenn Randbedingungen wie Kruemmung, Gierrate und Wegstecke erfüllt wurden
    %if max(fzg_psi_p_t00(1,1:1:(i*int)))>0.1 &&  fzg_x_t00(1,i*int)>1 && max(abs(fas_kamera_bv1_LIN_01_HorKruemm_t00(1,1:1:(i*int))))>0.0001
         
    Ergebnis01(1,k) = a(1,i-1); %Breitengrad Kreismittelpunkt
    Ergebnis01(2,k) = b(1,i-1); %Laengengrad Kreismitelpunkt
    Ergebnis01(3,k) = r(1,i-1); %Radius in °
        if i<=size(x,2)  % behebt das Problem, dass i im Ergebnisvektor den Endwert überschreitet und dadurch ein Fehler beim Plotten geworfen wird
        Ergebnis01(4,k) = i;
        else
        Ergebnis01(4,k) = i-1;    
        end
    Ergebnis01_kM(1,k)=Ergebnis01(1,k); %Breitengrad Kreismittelpunkt
    Ergebnis01_kM(2,k)=Ergebnis01(2,k); %Laengengrad Kreismitelpunkt
    Ergebnis01_kM(3,k)=Ergebnis01(3,k); %Radius in km
    Ergebnis01_kM(4,k)=Ergebnis01(4,k); % gibt an bis zu welchem Punkt die Werte fuer die Radiusermittlung des Kreises verwendet wurden (beginnend von dem vorherigen "i")
    
    else
        if i<=size(x,2)  % behebt das Problem, dass i im Ergebnisvektor den Endwert überschreitet und dadurch ein Fehler beim Plotten geworfen wird
        Ergebnis01(4,k) = i;
        else
        Ergebnis01(4,k) = i-1;    
        end
        Ergebnis01_kM(1,k)=Ergebnis01(1,k); %Breitengrad Kreismittelpunkt
    Ergebnis01_kM(2,k)=Ergebnis01(2,k); %Laengengrad Kreismitelpunkt
    Ergebnis01_kM(3,k)=Ergebnis01(3,k); %Radius in km
    Ergebnis01_kM(4,k)=Ergebnis01(4,k); % gibt an bis zu welchem Punkt die Werte fuer die Radiusermittlung des Kreises verwendet wurden (beginnend von dem vorherigen "i")
    %end 
   end
   
   if  k>1

    %if max(fzg_psi_p_t00(1,(Ergebnis01(4,k-1)*int):1:(i*int)))>0.1 &&  (fzg_x_t00(1,(i*int))-fzg_x_t00(1,Ergebnis01(4,k-1)*int))>1 && max(abs(fas_kamera_bv1_LIN_01_HorKruemm_t00(1,(Ergebnis01(4,k-1)*int):1:(i*int))))>0.0001    
    Ergebnis01(1,k) = a(1,i-1);
    Ergebnis01(2,k) = b(1,i-1);
    Ergebnis01(3,k) = r(1,i-1);
        if i<=size(x,2)  % behebt das Problem, dass i im Ergebnisvektor den Endwert überschreitet und dadurch ein Fehler beim Plotten geworfen wird
        Ergebnis01(4,k) = i;
        else
        Ergebnis01(4,k) = i-1;    
        end
    Ergebnis01_kM(1,k)=Ergebnis01(1,k);
    Ergebnis01_kM(2,k)=Ergebnis01(2,k);
    Ergebnis01_kM(3,k)=Ergebnis01(3,k);
    Ergebnis01_kM(4,k)=Ergebnis01(4,k);
    
    else
        if i<=size(x,2)  % behebt das Problem, dass i im Ergebnisvektor den Endwert überschreitet und dadurch ein Fehler beim Plotten geworfen wird
        Ergebnis01(4,k) = i;
        else
        Ergebnis01(4,k) = i-1;    
        end
    Ergebnis01_kM(1,k)=Ergebnis01(1,k);
    Ergebnis01_kM(2,k)=Ergebnis01(2,k);
    Ergebnis01_kM(3,k)=Ergebnis01(3,k);
    Ergebnis01_kM(4,k)=Ergebnis01(4,k);
    
   % end 
   end
   
end
catch exeption  % aufgetretender Fehler wird abgespeichert,
    failedFiles=[failedFiles;{'currentFile.mat'}];
continue        % anschließend übersprungen und es wird mit dem nächsten Datensatz weitergemacht
end
%% Einfärbung der Strecke in gruene und rote Abschnitte
% hold on 
% fig=figure;
% set(fig,'Name',out)
% color = 'r';
% plot(x(1,Start:1:Ergebnis01(4,1)),y(1,Start:1:Ergebnis01(4,1)),color,'LineWidth',3)
% for i=2:size(Ergebnis01,2)
%     if mod(i,2)
%         color='r';
%     else
%         color='g';
%     end
%     hold on
%   plot(x(1,Ergebnis01(4,i-1):1:Ergebnis01(4,i)),y(1,Ergebnis01(4,i-1):1:Ergebnis01(4,i)),color,'LineWidth',3)
% end
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
% 
% 
% 
% 
% 
% %% stellt auf der Z-Achse die Krümmung dar
% plot3(xEast(1,1:int:anzahl),yNorth(1,1:int:anzahl),1:int:anzahl,'MarkerSize',2,'MarkerFaceColor',[1 0 0],'Color','black');
% % plot3(xEast(1,1:int:anzahl),yNorth(1,1:int:anzahl),fzg_ypp_t00(1:int:anzahl),'MarkerSize',2,'MarkerFaceColor',[1 0 0],'Color','black');
% 
% 
% daspect([1 1 10000000])
% pbaspect([16 9 9])
% hold off
% 
% 
% %Abspeicherung der Figure
% saveas(fig,out,'fig')
% % saveas(h,name,'jpg')
% 
% 
% 
% 


%% Berechnungen



%Laenge der jeweiligen Abschnitte in Km
Ergebnis01_kM(10,1)=Data.fzg_x_t00(1,(Ergebnis01_kM(4,1)*int));
for c=2:size(Ergebnis01_kM,2)
Ergebnis01_kM(10,c)=(Data.fzg_x_t00(1,Ergebnis01(4,c)*int)-Data.fzg_x_t00(1,Ergebnis01(4,c-1)*int));
end


%Maximale Querberschleunigung
Ergebnis01_kM(6,1)=min(Data.fzg_ypp_t00_average(1,1:(Ergebnis01_kM(4,1)*int)));
Ergebnis01_kM(7,1)=max(Data.fzg_ypp_t00_average(1,1:(Ergebnis01_kM(4,1)*int)));
Ergebnis01_kM(8,1)=mean(Data.fzg_ypp_t00_average(1,1:(Ergebnis01_kM(4,1)*int)));
for c=2:size(Ergebnis01_kM,2)
Ergebnis01_kM(6,c)=min(Data.fzg_ypp_t00_average(1,(Ergebnis01_kM(4,c-1)*int):(Ergebnis01_kM(4,c)*int)));
Ergebnis01_kM(7,c)=max(Data.fzg_ypp_t00_average(1,(Ergebnis01_kM(4,c-1)*int):(Ergebnis01_kM(4,c)*int)));
Ergebnis01_kM(8,c)=mean(Data.fzg_ypp_t00_average(1,(Ergebnis01_kM(4,c-1)*int):(Ergebnis01_kM(4,c)*int)));
end



%Bestimmung ob Rechts- oder Linkskurve %%%% sollte Addition positiv sein,
%handelt es sich wahrscheinlich um eine Linkskurve, bei negativen Werten
%ist eine Rechtskurve wahrscheinlich geraden haben eher ausgeglichene
%Werte, muss aber auch in Verbindung mit dem Radius betrachtet werden -->
%große Radien deuten auf gerade Passagen hin

% for c=1:size(Ergebnis01_kM,2)
% Ergebnis01_kM(9,c)=Ergebnis01_kM(6,c)+Ergebnis01_kM(7,c);
% end


%Maximal- / Minimal- und Durchschnittsgeschwindigkeit
Ergebnis01_kM(12,1)=min(Data.fzg_xp_t00(1,1:(Ergebnis01_kM(4,1)*int)));
Ergebnis01_kM(13,1)=max(Data.fzg_xp_t00(1,1:(Ergebnis01_kM(4,1)*int)));
Ergebnis01_kM(14,1)=mean(Data.fzg_xp_t00(1,1:(Ergebnis01_kM(4,1)*int)));
for c=2:size(Ergebnis01_kM,2)
Ergebnis01_kM(12,c)=min(Data.fzg_xp_t00(1,(Ergebnis01_kM(4,c-1)*int):(Ergebnis01_kM(4,c)*int)));
Ergebnis01_kM(13,c)=max(Data.fzg_xp_t00(1,(Ergebnis01_kM(4,c-1)*int):(Ergebnis01_kM(4,c)*int)));
Ergebnis01_kM(14,c)=mean(Data.fzg_xp_t00(1,(Ergebnis01_kM(4,c-1)*int):(Ergebnis01_kM(4,c)*int)));
end

%Verhältnis Querbeschleunigung zur Durchschnittsgeschwindigkeit
for  c=1:size(Ergebnis01_kM,2)
Ergebnis01_kM(16,c)=Ergebnis01_kM(8,c)/Ergebnis01_kM(14,c);
end



% Durchschnittliche Kruemmung aus Linie 01 und 02 (geglaettet)
Data.fas_kamera_bv1_LIN_1_2_HorKruemm_t00_average_t=(smooth(Data.fas_kamera_bv1_LIN_02_HorKruemm_t00,1000)+smooth(Data.fas_kamera_bv1_LIN_01_HorKruemm_t00,1000))/2;
Data.fas_kamera_bv1_LIN_1_2_HorKruemm_t00_average=Data.fas_kamera_bv1_LIN_1_2_HorKruemm_t00_average_t'; %transponiert den Spaltenvektor wieder zum Zeilenvektor


% Aufintegration der Kruemmung in den jeweiligen Bereichen, um zu gucken ob es sich um eine Links-(+)  oder Rechtskurve(-) handelt
tempInt=0;
for d=1:Ergebnis01_kM(4,1)*int
    tempInt=tempInt+Data.fas_kamera_bv1_LIN_1_2_HorKruemm_t00_average(1,d);
    
    Ergebnis01_kM(32,1)=tempInt;
end
for c=2:size(Ergebnis01_kM,2)
    tempInt=0;
    for d=Ergebnis01_kM(4,c-1)*int:Ergebnis01_kM(4,c)*int
        tempInt=tempInt+Data.fas_kamera_bv1_LIN_1_2_HorKruemm_t00_average(1,d);
    end
    Ergebnis01_kM(32,c)=tempInt;
end


% Radius aus den Extrema der Kruemmung aus den jeweiligen Abschnitten
if  Ergebnis01_kM(32,1)>0
    Ergebnis01_kM(18,1)=1/(max(Data.fas_kamera_bv1_LIN_1_2_HorKruemm_t00_average(1,1:(Ergebnis01_kM(4,1)*int))));
else
    Ergebnis01_kM(18,1)=1/(min(Data.fas_kamera_bv1_LIN_1_2_HorKruemm_t00_average(1,1:(Ergebnis01_kM(4,1)*int))));
end
    Ergebnis01_kM(19,1)=1/(mean(Data.fas_kamera_bv1_LIN_1_2_HorKruemm_t00_average(1,1:(Ergebnis01_kM(4,1)*int))));
for c=2:size(Ergebnis01_kM,2)
if Ergebnis01_kM(32,c)>0
    Ergebnis01_kM(18,c)=1/(max(Data.fas_kamera_bv1_LIN_1_2_HorKruemm_t00_average(1,(Ergebnis01_kM(4,c-1)*int):(Ergebnis01_kM(4,c)*int))));    
else
    Ergebnis01_kM(18,c)=1/(min(Data.fas_kamera_bv1_LIN_1_2_HorKruemm_t00_average(1,(Ergebnis01_kM(4,c-1)*int):(Ergebnis01_kM(4,c)*int))));    

end
Ergebnis01_kM(19,c)=1/(mean(Data.fas_kamera_bv1_LIN_1_2_HorKruemm_t00_average(1,(Ergebnis01_kM(4,c-1)*int):(Ergebnis01_kM(4,c)*int))));
end


%Spurbreite der Fahrspur
Sb=Data.fas_kamera_bv1_LIN_01_AbstandY_t00+abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00);


Ergebnis01_kM(21,1)=round(mean(Sb(1,1:(Ergebnis01_kM(4,1)*int))),1);
if  Ergebnis01_kM(19,1)>0 % Wenn > 0 --> Linkskurve
    Ergebnis01_kM(22,1)=max((abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,1:Ergebnis01_kM(4,1)*int))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,1:Ergebnis01_kM(4,1)*int))/2);
else
    Ergebnis01_kM(22,1)=min((abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,1:Ergebnis01_kM(4,1)*int))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,1:Ergebnis01_kM(4,1)*int))/2);
end
Ergebnis01_kM(24,1)=(abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,1))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,1))/2;



for c=2:size(Ergebnis01_kM,2)
Ergebnis01_kM(21,c)=round(mean(Sb(1,(Ergebnis01_kM(4,c-1)*int):(Ergebnis01_kM(4,c)*int))),1);
if  Ergebnis01_kM(19,c)>0
    Ergebnis01_kM(22,c)=max((abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,Ergebnis01_kM(4,c-1)*int:Ergebnis01_kM(4,c)*int))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,Ergebnis01_kM(4,c-1)*int:Ergebnis01_kM(4,c)*int))/2);
else
    Ergebnis01_kM(22,c)=min((abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,Ergebnis01_kM(4,c-1)*int:Ergebnis01_kM(4,c)*int))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,Ergebnis01_kM(4,c-1)*int:Ergebnis01_kM(4,c)*int))/2);  
end

    Ergebnis01_kM(24,c)=(abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,(Ergebnis01_kM(4,c-1)+1)*int))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,(Ergebnis01_kM(4,c-1)+1)*int))/2;

end




% Messpunkt der maximalen Querablage
if isnan(Ergebnis01_kM(22,1))
    Ergebnis01_kM(28,1)=NaN;
else
Ergebnis01_kM(28,1)=find(((abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1:Ergebnis01_kM(4,1)*int))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1:Ergebnis01_kM(4,1)*int))/2)==Ergebnis01_kM(22,1),1,'first');
end
%Spurbreite bei Kurvenbeginn (Durchschnitt aus Umfeld von 5-10 Punkten)
Ergebnis01_kM(35,1)=round(mean(Sb(1:5)),1);
for c=2:size(Ergebnis01_kM,2)
if isnan(Ergebnis01_kM(22,c))
    Ergebnis01_kM(28,c)=NaN;
else
Ergebnis01_kM(28,c)=(find(((abs(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(Ergebnis01_kM(4,c-1)*int:Ergebnis01_kM(4,c)*int))-Data.fas_kamera_bv1_LIN_01_AbstandY_t00(Ergebnis01_kM(4,c-1)*int:Ergebnis01_kM(4,c)*int))/2)==Ergebnis01_kM(22,c),1,'first')+Ergebnis01_kM(4,c-1)*int);
end
Ergebnis01_kM(35,c)=round(mean(Sb((Ergebnis01_kM(4,c-1)+1)*10-5:(Ergebnis01_kM(4,c-1)+1)*10+5)),1);
end

for c=1:size(Ergebnis01_kM,2)
%Verhaeltnis Querbeschleunigung zur Durschnittsgeschwindigkeit
Ergebnis01_kM(16,c)=Ergebnis01_kM(8,c)/Ergebnis01_kM(14,c);

%Spurbreite bei maximaler Querablage
if isnan(Ergebnis01_kM(28,c))
    Ergebnis01_kM(36,c)=NaN;
elseif  Ergebnis01_kM(28,c)+5 <= anzahl
    if Ergebnis01_kM(28,c)<=5
        Ergebnis01_kM(36,c)=round(mean(Sb(Ergebnis01_kM(28,c):Ergebnis01_kM(28,c)+5)),1);
    else
        Ergebnis01_kM(36,c)=round(mean(Sb(Ergebnis01_kM(28,c)-5:Ergebnis01_kM(28,c)+5)),1);
    end
else
    Ergebnis01_kM(36,c)=round(mean(Sb(Ergebnis01_kM(28,c)-5:anzahl)),1);    
end

%Normierte maximale Querablage auf Spurbreite    
Ergebnis01_kM(23,c)=Ergebnis01_kM(22,c)/Ergebnis01_kM(36,c);

%Normierte Querablage zu Kurvengebinn auf Spurbreite
Ergebnis01_kM(25,c)=Ergebnis01_kM(24,c)/Ergebnis01_kM(35,c);

%Kurvenschneidefaktor
Ergebnis01_kM(26,c)=Ergebnis01_kM(23,c)-Ergebnis01_kM(25,c); 

if isnan(Ergebnis01_kM(28,c))
    Ergebnis01_kM(29,c)=NaN;
    Ergebnis01_kM(30,c)=NaN;
    Ergebnis01_kM(33,c)=NaN;
else

%Querbeschleunigung bei der maximalen Querablage
Ergebnis01_kM(29,c)=(Data.fzg_ypp_t00_average(1,Ergebnis01_kM(28,c)));

%Kruemmung bei der maximalen Querablage
Ergebnis01_kM(30,c)=Data.fas_kamera_bv1_LIN_1_2_HorKruemm_t00_average(1,Ergebnis01_kM(28,c));

%Verhaeltnis der Bereichsstrecke zum Umfang des Radius-Kreises (Indikator ob es sich um eine Gerade handeln koennte)
Ergebnis01_kM(33,c)=Ergebnis01_kM(10,c)/(2*pi*Ergebnis01_kM(3,c));
end
end


%Abspeicherung des Ergebnisvektors
inp = 'Ergebnis01_Km_.mat';
[~,fnm,ext] = fileparts(inp);
out = sprintf('%s',fnm,Name1,'_' ,Name2,ext);
% save(['F:\Eigene Dateien\01_Tu Braunschweig\IfF\Masterarbeit\05_Datenauswertung\aufbereitete_Daten\Ergebnisvektor\' out],Ergebnis01_kM )
save(out,'Ergebnis01_kM')




%% Ausfuehrung Skript zur Einfärbung der Querbeschleunigungen
% LOESCHMICH


end



%% Ausfuehrung Skript zur Zusammenfuehrung aller Ergebnismatrizen zu einer Matrix
Datenzusammenfuehrung


%%   Legende fuer Ergebnisvektor
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
%   22. Maximale Querablage (positive Werte = fahrzeug befindet sich auf der linken Seite der Fahrbahnmitt; negative Werte Fahrzeug befindet sich auf der rechten Seite der Fahrbahnmitte)
%   23. Normierte maximale Querablage auf Spurbreite (maximale Querablage / Spurbreite)
%   24. Querablage zu Kurvenbeginn
%   25. Normierte Querablage zu Kurvengebinn auf Spurbreite (Querablage zu Kurvenbeginn / Spurbreite)
%   26. Kurvenschneidefaktor (normierte maximale Querablage - normierte Querablage zu Kurvenbeginn)
%   28. Messpunkt der Maximalen Querablage
%   29. Querbeschleunigung bei der maximalen Querablage
%   30. Kruemmung bei der maximalen Querablage
%   31. 0
%   32. Aufintegration der Kruemmung in den jeweiligen Abschnitten : Vorzeichen deutet auf Art der Kurve hin (+ = Linkskurve; - = Rechtskurve)
%   33. %Verhaeltnis der Bereichsstrecke zum Umfang des Radius-Kreises (Indikator ob es sich um eine Gerade handeln koennte <=~0,018)
%   34. 0
%   35. %Spurbreite beim Kurven-/Abschnittsbeginn (gerundeter Durchschnitt aus dem ersten und den 50 darauf folgenden Werten)
%   36. %Spurbreite bei maximaler Querablage (gerundeter Durchschnitt aus den 50 Werten davor und den 50 darauf folgenden Werten)