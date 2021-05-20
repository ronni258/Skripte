%%% Dieses Skript errechnet anhand der durch die Kamera erkannten
%%% Kruemmungen der linken und rechten Fahrspurmarkierungen den Bereich der
%%% Kurven und deren Radien aus

anzahl=fix(size(Data.fas_kamera_bv1_LIN_01_AbstandY_t00,2)/100)*100;

% Passt die Entfernung des Fahrzeugs zur Linie an. Wird normalerweise keine
% Linie erkannt, wo wird die Entfernung auf 0 gesetzt --> das führt zu
% Fehlern bei der Berechnung der Spurbreite, Querablage... . Um das zu
% verhindern soll die Entfernung auf "NaN" gesetzt werden, wenn die
% Wahrscheinlichkeit für einer Markierung
% (Data.fas_kamera_bv1_LIN_01_ExistMass_t00) < 0,6 (60%) ist UND der Abstand innerhalb
% von 5 Messpunkten auch 0 erreicht. So werden gewollte Spurüberquerungen
% bei denen der Abstand = 0 ist nicht gelöscht und außerdem auch Passagen
% bei denen die Wahrscheinlichkeit 0 ist, aber trotzdem eine Linie erkannt
% wird und der Abstand ~= 0 ist, toleriert

for n=1:anzahl
    if n < anzahl-5 && n>5 %sorgt dafür, dass bei "n+5" nicht über den maximalen Rand nach Werten gesucht wird
        if Data.fas_kamera_bv1_LIN_01_ExistMass_t00(1,n) < 0.6 && Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,n+5)==0 || Data.fas_kamera_bv1_LIN_01_ExistMass_t00(1,n) < 0.6 && Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,n-5)==0 %
            Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,n)=NaN;
        end
    elseif n>=anzahl-5
        if Data.fas_kamera_bv1_LIN_01_ExistMass_t00(1,n) < 0.6 && Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,n)==0 || Data.fas_kamera_bv1_LIN_01_ExistMass_t00(1,n) < 0.6 && Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,n-5)==0
            Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,n)=NaN;
        end
    elseif n<=5
        if Data.fas_kamera_bv1_LIN_01_ExistMass_t00(1,n) < 0.6 && Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,n+5)==0 || Data.fas_kamera_bv1_LIN_01_ExistMass_t00(1,n) < 0.6 && Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,n)==0 %
            Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,n)=NaN;
        end        
    end
end

for n=1:anzahl
    if n < anzahl-5 && n>5 %sorgt dafür, dass bei "n+5" nicht über den maximalen Rand nach Werten gesucht wird
        if Data.fas_kamera_bv1_LIN_02_ExistMass_t00(1,n) < 0.6 && Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,n+5)==0 || Data.fas_kamera_bv1_LIN_02_ExistMass_t00(1,n) < 0.6 && Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,n-5)==0 %
            Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,n)=NaN;
        end
    elseif n>=anzahl-5
        if Data.fas_kamera_bv1_LIN_02_ExistMass_t00(1,n) < 0.6 && Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,n)==0 || Data.fas_kamera_bv1_LIN_02_ExistMass_t00(1,n) < 0.6 && Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,n-5)==0
            Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,n)=NaN;
        end
    elseif n<=5
        if Data.fas_kamera_bv1_LIN_02_ExistMass_t00(1,n) < 0.6 && Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,n+5)==0 || Data.fas_kamera_bv1_LIN_02_ExistMass_t00(1,n) < 0.6 && Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,n)==0 %
            Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,n)=NaN;
        end        
    end
end




%setzt an den Stellen an den keine Markierung erkannt wurde auch die
%Kruemmung auf "NaN"

for n=1:size(Data.fas_kamera_bv1_LIN_01_AbstandY_t00,2)
if isnan(Data.fas_kamera_bv1_LIN_01_AbstandY_t00(1,n))
    Data.fas_kamera_bv1_LIN_01_HorKruemm_t00(1,n)=NaN;
end

if isnan(Data.fas_kamera_bv1_LIN_02_AbstandY_t00(1,n))
    Data.fas_kamera_bv1_LIN_02_HorKruemm_t00(1,n)=NaN;
end
end

%bildet Durchschnitt der Kruemmung und fuellt Luecken auf, wenn eine Linie
%erkannt wird. Linie 01 (linke Fahrspurmarkierung) hat weniger Luecken, deshalb wird falls diese
%vorhanden ist, diese verwendet

    fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00=[];
for n=1:anzahl
if isnan(Data.fas_kamera_bv1_LIN_01_HorKruemm_t00(1,n)) && isnan(Data.fas_kamera_bv1_LIN_02_HorKruemm_t00(1,n))
    fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,n)=NaN; %%%%%% Name muss im Hauptskript noch angepasst werden

elseif isnan(Data.fas_kamera_bv1_LIN_01_HorKruemm_t00(1,n)) && ~isnan(Data.fas_kamera_bv1_LIN_02_HorKruemm_t00(1,n))
    fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,n)=Data.fas_kamera_bv1_LIN_02_HorKruemm_t00(1,n);

elseif isnan(Data.fas_kamera_bv1_LIN_02_HorKruemm_t00(1,n)) && ~isnan(Data.fas_kamera_bv1_LIN_01_HorKruemm_t00(1,n))
    fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,n)=Data.fas_kamera_bv1_LIN_01_HorKruemm_t00(1,n);

elseif ~isnan(Data.fas_kamera_bv1_LIN_01_HorKruemm_t00(1,n)) && ~isnan(Data.fas_kamera_bv1_LIN_02_HorKruemm_t00(1,n))
    fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1,n)=(Data.fas_kamera_bv1_LIN_01_HorKruemm_t00(1,n));%+Data.fas_kamera_bv1_LIN_02_HorKruemm_t00(1,n))/2;
end

end




% Peaks der Kruemmung suchen --> daraus spaeter den Radius bilden, da diese
% Kruemmungspeaks die Kurve definieren

[pks_max,locs_max,w_max,p_max]=findpeaks(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00,'MinPeakProminence',0.0002,'Annotate','extents','MinPeakDistance',200,'MinPeakHeight',0.0002,'WidthReference','halfheight','MinPeakWidth',20);
[pks_min,locs_min,w_min,p_min]=findpeaks((-1)*fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00,'MinPeakProminence',0.0002,'Annotate','extents','MinPeakDistance',200,'MinPeakHeight',0.0002,'WidthReference','halfheight','MinPeakWidth',20);

%sortiert die Peaks in eine Matrix
Extrema=[pks_max -pks_min; locs_max locs_min]';
Extrema=sortrows(Extrema,2);

%markiert alle Kruemmungsextrema in "Extrema" die aufgrund fehlender Spurmarkierungen erkannt
%worden sind als nicht relevant
%Indikator ob es sich um verwendbares Extrema handelt, ohne Fehler durch nicht erkannte Fahrbahnmarkierungen (0= fehlerhaft, 1= verwendbar)
Bereich=50; %Bereich in dem um ein Extrema herum fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00 nicht "NaN" werden darf, da sonst nicht verwendbar
for n=1:size(Extrema,1)
   
    if Extrema(n,2)>Bereich && Extrema(n,2)<anzahl-Bereich
            if isnan(mean(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(n,2)-Bereich:Extrema(n,2)+Bereich)))
                Extrema(n,3)=0; %setzt Indokator auf "0" wenn nicht verwendbar
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


%Loescht nicht verwendbare Extrema aus "Extrema"
Extrema(Extrema(:,3)==0,:)=[];


% 04.   Kurvenradius aus dem Kehrwert der Kruemmung
Extrema(:,4)=(1./Extrema(:,1));


% sucht den Kurvenbeginn und das Kurvenende jedes Kruemmungsextrema. Sollte
% es sich um eine verschachtelte Kurve handeln und somit die Kruemmung nach
% einem Extrema nicht auf ~ 0 (bzw. innerhalb des Toleranzbereichs) "abfallen" wird das naechste Extrema betrachtet, um
% somit das Gesamtkurvenende zu bestimmen

Tb=0.0001;  %Toleranzbereich der Kruemmung, lauft die Kruemmung in diesen Bereich wird sie als "Gerade" angenommen, 
            %um Kurven mit gleichem Vorzeichen von einander zu trennen oder als gemeinsame Kurve zu definiern

% 05.   Messpunkt Kurvenbeginn (wenn hier eine "0" steht, bedeutet dass, das die Kurve mit der vorherigen Kurve ein Teil einer Gesamtkurve mit mehreren Radien bildet)
for n=1:size(Extrema,1)
 try
    if n==1
     if Extrema(n,1)>0
        Extrema(n,5)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1:Extrema(n,2))<=Tb,1,'last'); %dran denken, Wert schneidet nicht immer die x-Achse also anstatt der <0, >0 Annahmebereich bspw.(-0,0001:0,0001) angeben
     else
        Extrema(n,5)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1:Extrema(n,2))>=-Tb,1,'last');
     end
        
    
    elseif n<size(Extrema,1)&& n>1
        if Extrema(n,1)>0
            Extrema(n,5)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(n-1,2):Extrema(n,2))<=Tb,1,'last')+Extrema(n-1,2)-1; 
        else
            Extrema(n,5)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(n-1,2):Extrema(n,2))>=-Tb,1,'last')+Extrema(n-1,2)-1;
        end
    elseif n>1
        if Extrema(n,1)>0
            Extrema(n,5)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(n-1,2):Extrema(n,2))<=Tb,1,'last')+Extrema(n-1,2)-1; 
        else
            Extrema(n,5)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(n-1,2):Extrema(n,2))>=-Tb,1,'last')+Extrema(n-1,2)-1;
        end
    end
 catch 
    continue
 end
end

%loescht die erste Kurve aus der Auflistung, wenn die Aufzeichnung in einer Kurve beginnt,
%ohne vorher den Toleramnzbereich durchlaufen zu haben
while Extrema(1,5) ==0
    Extrema(1,:)=[];
end



% 07.   Messpunkt Kurvenende (wenn hier eine "0" steht, bedeutet dass, das die Kurve mit der nachfolgenden Kurve ein Teil einer Gesamtkurve mit mehreren Radien bildet)
for n=1:size(Extrema,1)
 try
     if n==1
        if  Extrema(n,1)>0
            Extrema(n,7)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(n,2):Extrema(n+1,2))<=Tb,1,'first')+Extrema(1,2)-1;
        else
            Extrema(n,7)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(n,2):Extrema(n+1,2))>=-Tb,1,'first')+Extrema(1,2)-1;
        end   
     
         
    elseif n<size(Extrema,1)
        if Extrema(n,1)>0
            Extrema(n,7)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(n,2):Extrema(n+1,2))<=Tb,1,'first')+Extrema(n,2)-1;
        else
            Extrema(n,7)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(n,2):Extrema(n+1,2))>=-Tb,1,'first')+Extrema(n,2)-1;
        end
    else
        if Extrema(n,1)>0
            Extrema(n,7)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(n,2):anzahl)<=Tb,1,'first')+Extrema(n,2)-1;
        else
            Extrema(n,7)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(n,2):anzahl)>=-Tb,1,'first')+Extrema(n,2)-1;
        end
    end
 catch 
    continue
 end
end

%loescht die letzte Kurve aus der Auflistung, wenn die Aufzeichnung endet,
%ohne dass die Kurve abgeschlossen wurde, also die Kruemmung nach dem letzten Extrema nicht
%innerhalb des Toleranzbereichs endet
if Extrema(size(Extrema,1),7) ==0
    Extrema(find(Extrema(:,5),1,'last'):size(Extrema,1),:)=[];
end

%sucht den, die verschachtelte Kurve definierenden, kleinsten Radius aus dem
%Bereich und schreibt diesen in die erste Reihe des Bereichs in Spalte 6
n=1;
while n<=size(Extrema,1)
    if Extrema(n,7)==0
        Ki=find(Extrema(n:size(Extrema,1),7),1,'first'); %Ki= Kurvenintervall
        if Extrema(n,1)<0
        Extrema(n,6)=min(abs(Extrema(n:n+Ki-1,4))).*(-1);
        else
        Extrema(n,6)=min(abs(Extrema(n:n+Ki-1,4)));
        end
        n=n+Ki;
    else
        Extrema(n,6)=Extrema(n,4);
        n=n+1;
    end
   
end
clear n

%erster Schritt um aus "Extrema" "Extrema_final" zu machen, in der nur die
%relevanten Daten in einer sinnvollen Reihenfolge dargestellt werden
Extrema_bearbeitet=[];
Extrema_bearbeitet(:,1)=Extrema(:,5);
Extrema_bearbeitet(:,2)=Extrema(:,6);
Extrema_bearbeitet(:,3)=Extrema(:,7);

%dient dazu die "0"en aus der Matrix zu entfernen und nur noch den Anfang,
%das Ende und den definierenden Radius von verschachtelten Kurven
%darzustellen (die Reihen unter den "0"en rutschen nach oben)
Extrema_bearbeitet_2=nonzeros(Extrema_bearbeitet);
Extrema_01 = reshape(Extrema_bearbeitet_2,size(Extrema_bearbeitet_2,1)/3,3);

%"Extrema_final" wird gebildet
Extrema_final=[];              
Extrema_final(:,2)=Extrema_01(:,2);     % minimaler Radius der Gesamtkurve
Extrema_final(:,5)=Extrema_01(:,1);     % Messpunkt des Kurvenbeginns
Extrema_final(:,10)=Extrema_01(:,3);     % Messpunkt des Kurvenendes

% 06.   Messpunkt bei 0.2 der Kurve
% 07.   Messpunkt bei 0.4 der Kurve
% 08.   Messpunkt bei 0.6 der Kurve
% 09.   Messpunkt bei 0.8 der Kurve
for n=1:size(Extrema_final,1)
      Kl=Data.fzg_x_t00(Extrema_final(n,10))-Data.fzg_x_t00(Extrema_final(n,5)); %Kl = Kurvenlänge
      Extrema_final(n,6)=find(Data.fzg_x_t00>Data.fzg_x_t00(Extrema_final(n,5))+(Kl*0.1),1,'first');
      Extrema_final(n,7)=find(Data.fzg_x_t00>Data.fzg_x_t00(Extrema_final(n,5))+(Kl*0.3),1,'first');
      Extrema_final(n,8)=find(Data.fzg_x_t00>Data.fzg_x_t00(Extrema_final(n,5))+(Kl*0.5),1,'first');
      Extrema_final(n,9)=find(Data.fzg_x_t00>Data.fzg_x_t00(Extrema_final(n,5))+(Kl*0.7),1,'first');
end

% Messpunkte des minimalen Radius/maximalen Kruemmung der Gesamtkurve
% werdem rausgesucht (im Fall dass es mehrmals den exakt gleichen
% Radius gibt, wird an der Stelle eine "0" hinterlegt)
for n=1:size(Extrema_final,1)
  try
    Extrema_final(n,1)=Extrema(Extrema(:,4)==Extrema_final(n,2),2);

  catch
  continue
  end
end

%fuellt die Luecken in der Spalte der Messpunkte der minimalen
%Radien/maximalen Kruemmung auf, indem die mehrmals exakt gleichen Radien
%und deren Messpunkte betrachtet werden und mit den umliegenden Messpunkten
%der bereits einsortierten Radien verglichen werden.
for n=1:size(Extrema_final,1)
    if Extrema_final(n,1)==0
        Ze=Extrema(Extrema(:,4)==Extrema_final(n,2),2);
        for i=1:size(Ze,1)
            if n>1 && n< size(Extrema_final,1)-1
                if Extrema_final(n-1,1)< Ze(i,1) && Extrema_final(n+1,1)> Ze(i,1)
                    Extrema_final(n,1)=Ze(i,1);
                end
            elseif n==1 && size(Extrema_final,1)> 1
                if Extrema_final(n+1,1)> Ze(i,1)
                    Extrema_final(n,1)=Ze(i,1);
                end
            elseif n==size(Extrema_final,1) && size(Extrema_final,1)> 1
                if Extrema_final(n-1,1)< Ze(i,1)
                    Extrema_final(n,1)=Ze(i,1);
                end
            end
        end
    end
end


Ergebnis_Kr=Extrema_final';


%%% Legende Extrema_final
% 01.   Messpunkt des minimalen Radius/maximalen Kruemmung der Gesamtkurve
% 02.   minimaler Radius der Gesamtkurve
% 03.   0
% 04.   0
% 05.   Messpunkt des Kurvenbeginns
% 06.   Messpunkt bei 0.1 der Kurve (Distanz)
% 07.   Messpunkt bei 0.3 der Kurve (Distanz)
% 08.   Messpunkt bei 0.5 der Kurve (Distanz)
% 09.   Messpunkt bei 0.7 der Kurve (Distanz)
% 10.   Messpunkt des Kurvenendes




