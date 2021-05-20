%Dieses Skript berechnet die Koordinaten der Trajaktorie inklusive der Querablage. Dafuer
%wird eine Gerade zwischen dem vorherigen und dem
%nachfolgenden Punkt des betrachteten Punkts erstellt. Anschließend wird der senkrechte
%Abstand zwischen der Linie und dem betrachteten Punkt berechnet und dieser
%von der aufgezeichneten Querablage abgezogen. Der verbleibenede Abstand
%wird in die andere Richtung aufgetragen und die Koordinaten des Punktes
%berechnet




j=1;
x_qab=[];
y_qab=[];
for i=2000+1:size(x_SP.signals.values,1)-1
% i=3000; %Durchlaufvariable fuer Punkt an dem Querablage betrachtet wird
A=[x_SP.signals.values(i-1) y_SP.signals.values(i-1)]; %vorheriger Punkt
B=[x_SP.signals.values(i+1) y_SP.signals.values(i+1)]; %nachfolgender Punkt
C=[x_SP.signals.values(i) y_SP.signals.values(i)]; %betrachteter Punkt
Qabl=(abs(fas_kamera_bv1_LIN_02_AbstandY_t00(1,(Ergebnis_Kr(5,n)-1+j)))-fas_kamera_bv1_LIN_01_AbstandY_t00(1,(Ergebnis_Kr(5,n)-1+j)))/2;
AB = B - A; %Vektor von A zu B
AB = AB/norm(AB); %normierter Vektor mit einheitslaenge
ABperp = AB*[0 -1;1 0]; %senkrechter normierter Vektor der auf AB ist mit Einheitslaenge
ABmid = (A + B)/2; %Mitte von A zu B auf Linie ACHTUNG das ist ~= C da A, B und C nicht auf einer Geraden liegen
dist_ABmid_C= sqrt((ABmid(1,2)-C(1,2))^2+(ABmid(1,1)-C(1,1))^2);
Qabl_eff=Qabl-dist_ABmid_C; %Abstand zwischen der Geraden und dem Punkt der Querablage 


%%% es muss betrachtet werden, wie der Verlauf der Geraden ist, um zu
%%% definieren, ob sich der Punkt der Querablage links oder rechts von der
%%% Geraden befindet: D = Punkt der Querablage
%%% dafuer gibt es vier Faelle:
%%% 1. A -> B steigt x : höherer y-Wert = linke Seite des Graphen
%%% 2. A -> B faellt x : niedriger y-Wert = linke Seite des Graphen
%%% 3. A -> B x konst, y steigt : niedriger x-Wert = linke Seite des Graphen
%%% 4. A -> B x konst, y faellt : höherer x-Wert = linke Seite des Graphen
if Qabl>0 %Querablage ist links von Spurmitte
    if A(1,1)-B(1,1)<0 %x-Koordinate steigt
        if (ABmid(1,2) + Qabl_eff*ABperp(1,2))> (ABmid(1,2) - Qabl_eff*ABperp(1,2)) %Betrachtung der y-Werte der Punkte, der Punkt mit dem GROESSEREN Y-Wert ist der auf der linken Seite
            D = ABmid + Qabl_eff*ABperp;
        else
            D = ABmid - Qabl_eff*ABperp;
        end
    elseif A(1,1)-B(1,1)>0 %x-Koordinate faellt
        if (ABmid(1,2) + Qabl_eff*ABperp(1,2))< (ABmid(1,2) - Qabl_eff*ABperp(1,2)) %Betrachtung der y-Werte der Punkte, der Punkt mit dem KLEINERN Y-Wert ist der auf der linken Seite
            D = ABmid + Qabl_eff*ABperp;
        else
            D = ABmid - Qabl_eff*ABperp;
        end
        
    elseif A(1,1)-B(1,1)==0 && A(1,2)-B(1,2)<0 %konstante x-Koordinate aber steigender y-Wert
        if (ABmid(1,1) + Qabl_eff*ABperp(1,1))< (ABmid(1,1) - Qabl_eff*ABperp(1,1)) %Betrachtung der x-Werte der Punkte, der Punkt mit dem KLEINERN X-Wert ist der auf der linken Seite
            D = ABmid + Qabl_eff*ABperp;
        else
            D = ABmid - Qabl_eff*ABperp;
        end
    elseif A(1,1)-B(1,1)==0 && A(1,2)-B(1,2)>0 %konstante x-Koordinate aber fallender y-Wert
       if (ABmid(1,1) + Qabl_eff*ABperp(1,1))> (ABmid(1,1) - Qabl_eff*ABperp(1,1)) %Betrachtung der x-Werte der Punkte, der Punkt mit dem KLEINERN X-Wert ist der auf der linken Seite
            D = ABmid + Qabl_eff*ABperp;
        else
            D = ABmid - Qabl_eff*ABperp;
        end 
    end
    
elseif Qabl<0
    if A(1,1)-B(1,1)<0 %x-Koordinate steigt
        if (ABmid(1,2) + Qabl_eff*ABperp(1,2))< (ABmid(1,2) - Qabl_eff*ABperp(1,2)) %Betrachtung der y-Werte der Punkte, der Punkt mit dem GROESSEREN Y-Wert ist der auf der linken Seite
            D = ABmid + Qabl_eff*ABperp;
        else
            D = ABmid - Qabl_eff*ABperp;
        end
    elseif A(1,1)-B(1,1)>0 %x-Koordinate faellt
        if (ABmid(1,2) + Qabl_eff*ABperp(1,2))> (ABmid(1,2) - Qabl_eff*ABperp(1,2)) %Betrachtung der y-Werte der Punkte, der Punkt mit dem KLEINERN Y-Wert ist der auf der linken Seite
            D = ABmid + Qabl_eff*ABperp;
        else
            D = ABmid - Qabl_eff*ABperp;
        end
        
    elseif A(1,1)-B(1,1)==0 && A(1,2)-B(1,2)<0 %konstante x-Koordinate aber steigender y-Wert
        if (ABmid(1,1) + Qabl_eff*ABperp(1,1))> (ABmid(1,1) - Qabl_eff*ABperp(1,1)) %Betrachtung der x-Werte der Punkte, der Punkt mit dem KLEINERN X-Wert ist der auf der linken Seite
            D = ABmid + Qabl_eff*ABperp;
        else
            D = ABmid - Qabl_eff*ABperp;
        end
    elseif A(1,1)-B(1,1)==0 && A(1,2)-B(1,2)>0 %konstante x-Koordinate aber fallender y-Wert
       if (ABmid(1,1) + Qabl_eff*ABperp(1,1))< (ABmid(1,1) - Qabl_eff*ABperp(1,1)) %Betrachtung der x-Werte der Punkte, der Punkt mit dem KLEINERN X-Wert ist der auf der linken Seite
            D = ABmid + Qabl_eff*ABperp;
        else
            D = ABmid - Qabl_eff*ABperp;
        end 
    end
    

    
end
    x_qab(j,1)=D(1,1);
    y_qab(j,1)=D(1,2);
    j=j+1;
end
XY_qab=[];
XY_qab=[x_qab y_qab];


% figure
% hold on
% plot(x_qab(:,1)-x_qab(1,1),(y_qab(:,1)-y_qab(1,1)))



% figure
% hold on
% plot([A(1);B(1)],[A(2);B(2)],'-bo',[C(1);D(1)],[C(2);D(2)],'-rs')
% % axis equal is important because it ensures the lines appear
% % mutually perpendicular. If the axes had different units
% % along the axes, then the lines would look skewed.
% axis equal