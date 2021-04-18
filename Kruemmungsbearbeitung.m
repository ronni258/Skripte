
% Passt die Entfernung des Fahrzeugs zur Linie an. Wird normalerweise keine
% Linie erkannt, wo wird die Entfernung auf 0 gesetzt --> das führt zu
% Fehlern bei der Berechnung der Spurbreite, Querablage... . Um das zu
% verhindern soll die Entfernung auf "NaN" gesetzt werden, wenn die
% Wahrscheinlichkeit für einer Markierung
% (fas_kamera_bv1_LIN_01_ExistMass_t00) < 0,6 (60%) ist UND der Abstand innerhalb
% von 5 Messpunkten auch 0 erreicht. So werden gewollte Spurüberquerungen
% bei denen der Abstand = 0 ist nicht gelöscht und außerdem auch Passagen
% bei denen die Wahrscheinlichkeit 0 ist, aber trotzdem eine Linie erkannt
% wird und der Abstand ~= 0 ist, toleriert



for n=1:anzahl
    if n < anzahl-5 && n>5 %sorgt dafür, dass bei "n+5" nicht über den maximalen Rand nach Werten gesucht wird
        if fas_kamera_bv1_LIN_01_ExistMass_t00(1,n) < 0.6 && fas_kamera_bv1_LIN_01_AbstandY_t00(1,n+5)==0 || fas_kamera_bv1_LIN_01_ExistMass_t00(1,n) < 0.6 && fas_kamera_bv1_LIN_01_AbstandY_t00(1,n-5)==0 %
            fas_kamera_bv1_LIN_01_AbstandY_t00(1,n)=NaN;
        end
    elseif n>=anzahl-5
        if fas_kamera_bv1_LIN_01_ExistMass_t00(1,n) < 0.6 && fas_kamera_bv1_LIN_01_AbstandY_t00(1,n)==0 || fas_kamera_bv1_LIN_01_ExistMass_t00(1,n) < 0.6 && fas_kamera_bv1_LIN_01_AbstandY_t00(1,n-5)==0
            fas_kamera_bv1_LIN_01_AbstandY_t00(1,n)=NaN;
        end
    elseif n<=5
        if fas_kamera_bv1_LIN_01_ExistMass_t00(1,n) < 0.6 && fas_kamera_bv1_LIN_01_AbstandY_t00(1,n+5)==0 || fas_kamera_bv1_LIN_01_ExistMass_t00(1,n) < 0.6 && fas_kamera_bv1_LIN_01_AbstandY_t00(1,n)==0 %
            fas_kamera_bv1_LIN_01_AbstandY_t00(1,n)=NaN;
        end        
    end
end

for n=1:anzahl
    if n < anzahl-5 && n>5 %sorgt dafür, dass bei "n+5" nicht über den maximalen Rand nach Werten gesucht wird
        if fas_kamera_bv1_LIN_02_ExistMass_t00(1,n) < 0.6 && fas_kamera_bv1_LIN_02_AbstandY_t00(1,n+5)==0 || fas_kamera_bv1_LIN_02_ExistMass_t00(1,n) < 0.6 && fas_kamera_bv1_LIN_02_AbstandY_t00(1,n-5)==0 %
            fas_kamera_bv1_LIN_02_AbstandY_t00(1,n)=NaN;
        end
    elseif n>=anzahl-5
        if fas_kamera_bv1_LIN_02_ExistMass_t00(1,n) < 0.6 && fas_kamera_bv1_LIN_02_AbstandY_t00(1,n)==0 || fas_kamera_bv1_LIN_02_ExistMass_t00(1,n) < 0.6 && fas_kamera_bv1_LIN_02_AbstandY_t00(1,n-5)==0
            fas_kamera_bv1_LIN_02_AbstandY_t00(1,n)=NaN;
        end
    elseif n<=5
        if fas_kamera_bv1_LIN_02_ExistMass_t00(1,n) < 0.6 && fas_kamera_bv1_LIN_02_AbstandY_t00(1,n+5)==0 || fas_kamera_bv1_LIN_02_ExistMass_t00(1,n) < 0.6 && fas_kamera_bv1_LIN_02_AbstandY_t00(1,n)==0 %
            fas_kamera_bv1_LIN_02_AbstandY_t00(1,n)=NaN;
        end        
    end
end




%setzt an den Stellen an den keine Markierung erkannt wurde auch die
%Kruemmung auf "NaN"

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

    fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00=[];
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




% Peaks der Kruemmung suchen --> daraus spaeter den Radius bilden

[pks_max,locs_max,w_max,p_max]=findpeaks(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00,'MinPeakProminence',0.0002,'Annotate','extents','MinPeakDistance',200,'MinPeakHeight',0.0002,'WidthReference','halfheight','MinPeakWidth',20);
[pks_min,locs_min,w_min,p_min]=findpeaks((-1)*fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00,'MinPeakProminence',0.0002,'Annotate','extents','MinPeakDistance',200,'MinPeakHeight',0.0002,'WidthReference','halfheight','MinPeakWidth',20);

%sortiert die Peaks in eine Matrix
% 01.   Kruemmung am Extrema
% 02.   Messpunkt beim Extrema
Extrema=[pks_max -pks_min; locs_max locs_min]';
Extrema=sortrows(Extrema,2);

%markiert alle Kruemmungsextrema die aufgrund fehlender Spurmarkierungen erkannt
%worden sind als nicht relevant
% 03.   Indikator ob es sich um verwendbares Extrema handelt, ohne Fehler durch nicht erkannte Fahrbahnmarkierungen (0= fehlerhaft, 1= verwendbar)
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
                Extrema(n,3)=0; %setzt Indokator auf "0" wenn nicht verwendbar
            else
                Extrema(n,3)=1;
            end            
    

    end
end

%Loescht nicht verwendbare Extrema
n=1;
while n<=size(Extrema,1)
    if Extrema(n,3)==0
        Extrema(n,:)=[];
    end
    n=n+1;
end

% 04.   Kurvenradius aus dem Kehrwert der Kruemmung
Extrema(:,4)=(1./Extrema(:,1)).*Extrema(:,3);



% if Extrema(1,1)>0
%     Extrema(1,5)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1:Extrema(1,2))<=Tb,1,'last'); %dran denken, Wert schneidet nicht immer die x-Achse also anstatt der <0, >0 Annahmebereich bspw.(-0,0001:0,0001) angeben
%     Extrema(1,6)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(1,2):Extrema(2,2))<=Tb,1,'first')+Extrema(1,2);
% else
%     Extrema(1,5)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1:Extrema(1,2))>=-Tb,1,'last');
%     Extrema(1,6)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(1,2):Extrema(2,2))>=-Tb,1,'first')+Extrema(1,2);
% end

% sucht den Kurvenbeginn und das Kurvenende jedes Kruemmungsextrema. Sollte
% es sich um eine verschachtelte Kurve handeln und somit die Kruemmung nach
% einem Extrema nicht auf ~ 0 (bzw. innerhalb des Toleranzbereichs) "abfallen" wird das naechste Extrema betrachtet um
% somit das Gesamtkurvenende zu bestimmen

Tb=0.0001;  %Toleranzbereich der Kruemmung, der als "Gerade" angenommen wird, 
            %um Kurven mit gleichem Vorzeichen von einander zu trennen oder als gemeinsame Kurve zu definiern

% 05.   Messpunkt Kurvenbeginn (wenn hier eine "0" steht, bedeutet dass, das die Kurve mit der vorherigen Kurve ein Teil einer Gesamtkurve mit mehreren Radien bildet)
% 06.   Messpunkt Kurvenende (wenn hier eine "0" steht, bedeutet dass, das die Kurve mit der nachfolgenden Kurve ein Teil einer Gesamtkurve mit mehreren Radien bildet)

for n=1:size(Extrema,1)
 try
    if n==1
     if Extrema(n,1)>0
        Extrema(n,5)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1:Extrema(n,2))<=Tb,1,'last'); %dran denken, Wert schneidet nicht immer die x-Achse also anstatt der <0, >0 Annahmebereich bspw.(-0,0001:0,0001) angeben
     else
        Extrema(n,5)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(1:Extrema(n,2))>=-Tb,1,'last');
     end
        
    end
    if n<size(Extrema,1)&& n>1
        if Extrema(n,1)>0
            Extrema(n,5)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(n-1,2):Extrema(n,2))<=Tb,1,'last')+Extrema(n-1,2); 
        else
            Extrema(n,5)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(n-1,2):Extrema(n,2))>=-Tb,1,'last')+Extrema(n-1,2);
        end
    elseif n>1
        if Extrema(n,1)>0
            Extrema(n,5)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(n-1,2):Extrema(n,2))<=Tb,1,'last')+Extrema(n-1,2); 
        else
            Extrema(n,5)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(n-1,2):Extrema(n,2))>=-Tb,1,'last')+Extrema(n-1,2);
        end
    end
 catch 
    continue
 end
end


for n=1:size(Extrema,1)
 try
     if n==1
        if  Extrema(n,1)>0
            Extrema(n,7)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(n,2):Extrema(n+1,2))<=Tb,1,'first')+Extrema(1,2);
        else
            Extrema(n,7)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(n,2):Extrema(n+1,2))>=-Tb,1,'first')+Extrema(1,2);
        end   
     end
         
    if n<size(Extrema,1)
        if Extrema(n,1)>0
            Extrema(n,7)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(n,2):Extrema(n+1,2))<=Tb,1,'first')+Extrema(n,2);
        else
            Extrema(n,7)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(n,2):Extrema(n+1,2))>=-Tb,1,'first')+Extrema(n,2);
        end
    else
        if Extrema(n,1)>0
            Extrema(n,7)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(n,2):anzahl)<=Tb,1,'first')+Extrema(n,2);
        else
            Extrema(n,7)=find(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00(Extrema(n,2):anzahl)>=-Tb,1,'first')+Extrema(n,2);
        end
    end
 catch 
    continue
 end
end



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

Extrema_bearbeitet=[];
Extrema_bearbeitet(:,1)=Extrema(:,5);
Extrema_bearbeitet(:,2)=Extrema(:,6);
Extrema_bearbeitet(:,3)=Extrema(:,7);

%dient dazu die "0" aus der Matrix zu entfernen
Extrema_bearbeitet_2=nonzeros(Extrema_bearbeitet);
Extrema_01 = reshape(Extrema_bearbeitet_2,size(Extrema_bearbeitet_2,1)/3,3);

Extrema_final=[];              
Extrema_final(:,2)=Extrema_01(:,2);   % minimaler Radius der Gesamtkurve
Extrema_final(:,4)=Extrema_01(:,1);   % Messpunkt des Kurvenbeginns
% Extrema_final(:,5)=0;               % Messpunkt bei 0.2 der Kurve
% Extrema_final(:,6)=0;               % Messpunkt bei 0.4 der Kurve
% Extrema_final(:,7)=0;               % Messpunkt bei 0.6 der Kurve
% Extrema_final(:,8)=0;               % Messpunkt bei 0.8 der Kurve
Extrema_final(:,9)=Extrema_01(:,3); % Messpunkt des Kurvenendes

for n=1:size(Extrema_final,1)
    Kb=Extrema_final(n,9)-Extrema_final(n,4);
    Extrema_final(n,5)=round(Kb*0.2+Extrema_final(n,4));
    Extrema_final(n,6)=round(Kb*0.4+Extrema_final(n,4));
    Extrema_final(n,7)=round(Kb*0.6+Extrema_final(n,4));
    Extrema_final(n,8)=round(Kb*0.8+Extrema_final(n,4));
end

% Messpunkt des minimalen Radius/maximalen Kruemmung der Gesamtkurve
for n=1:size(Extrema_final,1)
   Extrema_final(n,1)=Extrema(find(Extrema(:,4)==Extrema_final(n,2)),2);
end




%%% Legende Extrema_final
% 01.   Messpunkt des minimalen Radius/maximalen Kruemmung der Gesamtkurve
% 02.   minimaler Radius der Gesamtkurve
% 03.   0
% 04.   Messpunkt des Kurvenbeginns
% 05.   Messpunkt bei 0.2 der Kurve
% 06.   Messpunkt bei 0.4 der Kurve
% 07.   Messpunkt bei 0.6 der Kurve
% 08.   Messpunkt bei 0.8 der Kurve
% 09.   Messpunkt des Kurvenendes




