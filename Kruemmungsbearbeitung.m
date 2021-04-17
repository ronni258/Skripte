
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

[pks_max,locs_max,w_max,p_max]=findpeaks(fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00,'MinPeakProminence',0.0002,'Annotate','extents','MinPeakDistance',500,'MinPeakHeight',0.0002,'WidthReference','halfheight','MinPeakWidth',20);
[pks_min,locs_min,w_min,p_min]=findpeaks((-1)*fas_kamera_bv1_LIN_01_02_HorKruemm_average_t00,'MinPeakProminence',0.0002,'Annotate','extents','MinPeakDistance',500,'MinPeakHeight',0.0002,'WidthReference','halfheight','MinPeakWidth',20);

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
                Extrema(n,3)=0;
            else
                Extrema(n,3)=1;
            end            
    
    end
end

% 04.   Kurvenradius aus dem Kehrwert der Kruemmung
Extrema(:,4)=(1./Extrema(:,1)).*Extrema(:,3);


for n=1:size(Extrema,1)
    
end






%%% Legende Extrema
% 01.   Kruemmung am Extrema
% 02.   Messpunkt beim Extrema
% 03.   Indikator ob es sich um verwendbares Extrema handelt, ohne Fehler durch nicht erkannte Fahrbahnmarkierungen (0= fehlerhaft, 1= verwendbar)
% 04.   Kurvenradius aus dem Kehrwert der Kruemmung





