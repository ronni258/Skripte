


%alle Einzelpunkte der Kurven eines Radiusbereiches werden zusammengeführt,
%um daraus Punktewolken erstellen zu können
%m= Laufvariabel für für verschiedene Radien
for m=1:size(Lk,2)% an dieser Stelle egal ob Lk oder Rk, da die Anzahl der Radienkategorien bei beiden gleich ist
ZsmKr_ypp_Rk=[];%Zwischenmatrix für Querbeschl. über Krümmung der Rechtskurven
ZsmKr_Qab_Rk=[];%Zwischenmatrix für Querabl. über Krümmung der Rechtskurven
ZsmKr_ypp_Lk=[];%Zwischenmatrix für Querbeschl. über Krümmung der Linkskurven
ZsmKr_Qab_Lk=[];%Zwischenmatrix für Querabl. über Krümmung der Linkskurven

%n= Laufvariabel für verschiedene Kurven innerhalb einer Radiengruppe
for n=1:size(Rk(m).a,1) %Rk(m).a steht für alle Rechtskurven
%Querbeschleunigung über Krümmung
ZsmKr_ypp_Rk(1,n/n+n*11-11:n/n+n*11-1)=[Rk(m).a(n,46:49) Rk(m).a(n,128:134)];%Krümmung
ZsmKr_ypp_Rk(2,n/n+n*11-11:n/n+n*11-1)=[Rk(m).a(n,57:60) Rk(m).a(n,139:145)];%Querbeschleunigung

%normierte Querablage über Krümmung
ZsmKr_Qab_Rk(1,n/n+n*11-11:n/n+n*11-1)=[Rk(m).a(n,46:49) Rk(m).a(n,128:134)];%Krümmung
ZsmKr_Qab_Rk(2,n/n+n*11-11:n/n+n*11-1)=[Rk(m).a(n,35:38) Rk(m).a(n,117:123)];%Querablage

end
for n=1:size(Lk(m).a,1)%Lk(m).a steht für alle Linkskurven
%normierte Querablage über Krümmung
ZsmKr_Qab_Lk(1,n/n+n*11-11:n/n+n*11-1)=[Lk(m).a(n,46:49) Lk(m).a(n,128:134)];
ZsmKr_Qab_Lk(2,n/n+n*11-11:n/n+n*11-1)=[Lk(m).a(n,35:38) Lk(m).a(n,117:123)];

%Querbeschleunigung über Krümmung
ZsmKr_ypp_Lk(1,n/n+n*11-11:n/n+n*11-1)=[Lk(m).a(n,46:49) Lk(m).a(n,128:134)];
ZsmKr_ypp_Lk(2,n/n+n*11-11:n/n+n*11-1)=[Lk(m).a(n,57:60) Lk(m).a(n,139:145)];

end
% Aufbereitung damit die Daten als Punktewolke geplottet werden können
ZsmKr_ypp_Rk=ZsmKr_ypp_Rk';
ZsmKr_ypp_Lk=ZsmKr_ypp_Lk';
ZsmKr_Qab_Rk=ZsmKr_Qab_Rk';
ZsmKr_Qab_Lk=ZsmKr_Qab_Lk';

% ersetzt alle Reihen in denen die Krümmung NaN ist mit 0 als Vorbereitung
% um diese im nächsten Schritt zu löschen. Die NaN Werte verhindern, dass
% eine Regressionsgerade gebildet werden kann
for n=1:size(ZsmKr_ypp_Rk,1)
    if isnan(ZsmKr_ypp_Rk(n,1))
       ZsmKr_ypp_Rk(n,:)=0;
    end
      
     if isnan(ZsmKr_Qab_Rk(n,1))
       ZsmKr_Qab_Rk(n,:)=0;
     end 
  
     if isnan(ZsmKr_Qab_Rk(n,2))
       ZsmKr_Qab_Rk(n,:)=0;
     end     
      
end
for n=1:size(ZsmKr_ypp_Lk,1)  
    if isnan(ZsmKr_ypp_Lk(n,1))
       ZsmKr_ypp_Lk(n,:)=0;
    end   
    
     if isnan(ZsmKr_Qab_Lk(n,1))
       ZsmKr_Qab_Lk(n,:)=0;
     end 
     
     if isnan(ZsmKr_Qab_Lk(n,2))
       ZsmKr_Qab_Lk(n,:)=0;
     end     
end

% löscht alle Reihen die nur aus 0en bestehen
ZsmKr_ypp_Rk=ZsmKr_ypp_Rk(any(ZsmKr_ypp_Rk,2),:);
ZsmKr_ypp_Lk=ZsmKr_ypp_Lk(any(ZsmKr_ypp_Lk,2),:);
ZsmKr_Qab_Rk=ZsmKr_Qab_Rk(any(ZsmKr_Qab_Rk,2),:);
ZsmKr_Qab_Lk=ZsmKr_Qab_Lk(any(ZsmKr_Qab_Lk,2),:);


Xr=[];
Xl=[];
regr=[];
regl=[];

%% Querbeschleunigung über Kruemmung
%Regressionsgerade
Xl=[ones(length(ZsmKr_ypp_Lk(:,1)),1) ZsmKr_ypp_Lk(:,1)];
regl=Xl\ZsmKr_ypp_Lk(:,2);
Xr=[ones(length(ZsmKr_ypp_Rk(:,1)),1) ZsmKr_ypp_Rk(:,1)];
regr=Xr\ZsmKr_ypp_Rk(:,2);

%X und Y Werte der Regressionsgeraden werden in struct gespeichert, damit
%diese für den Vergleich ziwschen verschiedenen Radien verwendet werden
%können
Reg(m).Kr_ypp_X_L=ZsmKr_ypp_Lk(:,1);
Reg(m).Kr_ypp_Y_L=Xl*regl;
Reg(m).Kr_ypp_X_R=ZsmKr_ypp_Rk(:,1);
Reg(m).Kr_ypp_Y_R=Xr*regr;


Xr=[];
Xl=[];
regr=[];
regl=[];


%% normierte Querablage über Kruemmung
% %Regressionsgerade
Xl=[ones(length(ZsmKr_Qab_Lk(:,1)),1) ZsmKr_Qab_Lk(:,1)];
regl=Xl\ZsmKr_Qab_Lk(:,2);
Xr=[ones(length(ZsmKr_Qab_Rk(:,1)),1) ZsmKr_Qab_Rk(:,1)];
regr=Xr\ZsmKr_Qab_Rk(:,2);

%X und Y Werte der Regressionsgeraden werden in struct gespeichert, damit
%diese für den Vergleich ziwschen verschiedenen Radien verwendet werden
%können
Reg(m).Kr_Qab_X_L=ZsmKr_Qab_Lk(:,1);
Reg(m).Kr_Qab_Y_L=Xl*regl;
Reg(m).Kr_Qab_X_R=ZsmKr_Qab_Rk(:,1);
Reg(m).Kr_Qab_Y_R=Xr*regr;

Xr=[];
Xl=[];
regr=[];
regl=[];
%% Kurvenschneiderfaktor über normierten Offset zu Kurvenbeginn
%Regressionsgerade
Xl=[ones(length(Lk(m).a(:,34)),1) Lk(m).a(:,34)];
regl=Xl\Lk(m).a(:,42);
Xr=[ones(length(Rk(m).a(:,34)),1) Rk(m).a(:,34)];
regr=Xr\Rk(m).a(:,42);
plot(Rk(m).a(:,34),Xr*regr,'red')

Reg(m).yOff_Ksf_X_L=Lk(m).a(:,34);
Reg(m).yOff_Ksf_Y_L=Xl*regl;
Reg(m).yOff_Ksf_X_R=Rk(m).a(:,34);
Reg(m).yOff_Ksf_Y_R=Xr*regr;

Xr=[];
Xl=[];
regr=[];
regl=[];
%% normierte maximale Querablage über Querbeschleunigung
%Regressionsgerade
Xl=[ones(length(Lk(m).a(:,62)),1) Lk(m).a(:,62)];
regl=Xl\Lk(m).a(:,40);
Xr=[ones(length(Rk(m).a(:,62)),1) Rk(m).a(:,62)];
regr=Xr\Rk(m).a(:,40);

Reg(m).ypp_Qablmax_X_L=Lk(m).a(:,62);
Reg(m).ypp_Qablmax_Y_L=Xl*regl;
Reg(m).ypp_Qablmax_X_R=Rk(m).a(:,62);
Reg(m).ypp_Qablmax_Y_R=Xr*regr;

Xr=[];
Xl=[];
regr=[];
regl=[];
%% normierte maximale Querablage über normierten Offset Kurvenbeginn
%Regressionsgerade
Xl=[ones(length(Lk(m).a(:,34)),1) Lk(m).a(:,34)];
regl=Xl\Lk(m).a(:,40);
Xr=[ones(length(Rk(m).a(:,34)),1) Rk(m).a(:,34)];
regr=Xr\Rk(m).a(:,40);

Reg(m).yOff_Qablmax_X_L=Lk(m).a(:,34);
Reg(m).yOff_Qablmax_Y_L=Xl*regl;
Reg(m).yOff_Qablmax_X_R=Rk(m).a(:,34);
Reg(m).yOff_Qablmax_Y_R=Xr*regr;

Xr=[];
Xl=[];
regr=[];
regl=[];
%% Normierte maximale Querablage über durchschnittliche Geschwindigkeit
%Regressionsgerade
Xl=[ones(length(Lk(m).a(:,76)),1) Lk(m).a(:,76)];
regl=Xl\Lk(m).a(:,40);
Xr=[ones(length(Rk(m).a(:,76)),1) Rk(m).a(:,76)];
regr=Xr\Rk(m).a(:,40);

Reg(m).vd_Qablmax_X_L=Lk(m).a(:,76);
Reg(m).vd_Qablmax_Y_L=Xl*regl;
Reg(m).vd_Qablmax_X_R=Rk(m).a(:,76);
Reg(m).vd_Qablmax_Y_R=Xr*regr;

Xr=[];
Xl=[];
regr=[];
regl=[];


%% Normierte maximale Querablage über Krümmung
%Regressionsgerade
Xl=[ones(length(Lk(m).a(:,51)),1) Lk(m).a(:,51)];
regl=Xl\Lk(m).a(:,40);
Xr=[ones(length(Rk(m).a(:,51)),1) Rk(m).a(:,51)];
regr=Xr\Rk(m).a(:,40);

xlabel ('Krümmung')
ylabel ('normierte maximale Querablage')
legend ('Linkskurve','Rechtskurve')
Reg(m).Kr_Qablmax_X_L=Lk(m).a(:,51);
Reg(m).Kr_Qablmax_Y_L=Xl*regl;
Reg(m).Kr_Qablmax_X_R=Rk(m).a(:,51);
Reg(m).Kr_Qablmax_Y_R=Xr*regr;

Xr=[];
Xl=[];
regr=[];
regl=[];
end