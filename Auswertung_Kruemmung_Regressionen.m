clc
disp 'Waehle zu untersuchende Radien'
disp '1 = 20-50'
disp '2 = 50-100'
disp '3 = 100-150'
disp '4 = 150-200'
disp '5 = 200-250'
disp '6 = 250-300'
disp '7 = 300-350'
disp '8 = 350-400'
disp '9 = 400-450'
disp '10 = 450-500'
disp '11 = 500-550'
disp '12 = 550-600'
disp '13 = 600-650'
disp '14 = 650-700'
disp '15 = 700-750'
disp '16 = 750-800'
disp '17 = 800-850'
disp '18 = 850-900'
disp '19 = 900-950'
disp '21 = 950-1000'
disp '22 = 1000-1050'
disp '23 = 1050-1100'
disp '24 = 1100-1150'
disp '25 = 1150-1200'
disp '26 = 1200-1250'
disp '27 = 1250-1300'
disp '28 = 1300-1400'
disp '29 = 1400-1500'
disp '30 = 1500-1600'
disp '31 = 1600-1700'
disp '32 = 1700-1800'
disp '33 = 1800-1900'
disp '34 = 1900-2000'
disp '35 = 2000-2200'
disp '36 = 2200-2400'
disp '37 = 2400-2600'
disp '38 = 2600-2800'
disp '39 = 2800-3000'
disp '40 = 3000-3500'
disp '41 = 3500-4000'
disp '42 = 4000-4500'
disp '43 = 4500-5000'
prompt='Wähle den Startpunkt der zu betrachtenen Radien: a = ';
a=input(prompt); 
prompt='Wähle das Ende der zu betrachtenen Radien: z = ';
z=input(prompt); 
prompt='Wähle die Schrittweite der zu plottenden Radien: s = ';
s=input(prompt); 


% a=1; %von welcher Radiengruppe
% z=size(Reg,2); %10;%bis zu welcher Radiengruppe


%Regressionsgeraden der normierten Querablage über Kruemmung
fig_13=figure ('Name','Qab/Krümmung');
title ('normierter Querablage über Krümmung')
subtitle('Regressionsgeraden')
grid on
hold on
for n=a:s:z%size(Reg,2)%gibt an welche Radiengruppen mit einander vergleichen 
          %werden sollen ((1:2) bedeutet dass die Radien 0020-050 und 0050-100 verglichen werden(1:size(Reg,2)) verlgeicht alle)
plot(Reg(n).Kr_Qab_X_L,Reg(n).Kr_Qab_Y_L)%,'blue','LineWidth',1)%Linkskurve
plot(Reg(n).Kr_Qab_X_R,Reg(n).Kr_Qab_Y_R)%,'red','LineWidth',1)%Rechtskurve
end
xlabel ('Krümmung')
ylabel ('Querablage')
legend ('Linkskurve','Rechtskurve')
hold off

%Regressionsgeraden der Querbeschleunigung über Kruemmung
fig_14=figure ('Name','ypp/Krümmung');
title ('Querbeschleunigung über Krümmung')
subtitle('Regressionsgeraden')
grid on
hold on
for n=a:s:z%size(Reg,2)
plot(Reg(n).Kr_ypp_X_L,Reg(n).Kr_ypp_Y_L)%)%,'blue','LineWidth',1)%Linkskurve
plot(Reg(n).Kr_ypp_X_R,Reg(n).Kr_ypp_Y_R)%)%,'red','LineWidth',1)%Rechtskurve
end
xlabel ('Krümmung')
ylabel ('Querablage')
legend ('Linkskurve','Rechtskurve')
hold off

% Regressionsgerade normierter Kurvenschneiderfaktor über normierten Offset
fig_1=figure ('Name','Kurvenschneiderfaktor/Offset_norm');
title ('Kurvenschneiderfaktor über normierten Offset zu Kurvenbeginn')
subtitle('Regressionsgeraden')
grid on
hold on
for n=a:s:z%size(Reg,2)
plot(Reg(n).yOff_Ksf_X_L,Reg(n).yOff_Ksf_Y_L)%,'blue','LineWidth',1)%Linkskurve
plot(Reg(n).yOff_Ksf_X_R,Reg(n).yOff_Ksf_Y_R)%,'red','LineWidth',1)%Rechtskurve
end
xlabel ('normiertet Offset zur Kurvenbeginn')
ylabel ('Kurvenschneidefaktor')
legend ('Linkskurve','Rechtskurve')
hold off


% normierte maximale Querablage über Querbeschleunigung an der Stelle
fig_2=figure ('Name','Qab_max_norm/ypp');
title ('Normierte maximale Querablage über Querbeschleunigung an der Stelle')
subtitle('Regressionsgeraden')
grid on
hold on 
for n=a:s:z%size(Reg,2)
plot(Reg(n).ypp_Qablmax_X_L,Reg(n).ypp_Qablmax_Y_L)%,'blue','LineWidth',1)%Linkskurve
plot(Reg(n).ypp_Qablmax_X_R,Reg(n).ypp_Qablmax_Y_R)%,'red','LineWidth',1)%Rechtskurve
end
xlabel ('Querbeschleunigung')
ylabel ('normierte maximale Querablage')
legend ('Linkskurve','Rechtskurve')
hold off


% normierte maximale Querablage über normiertem Offset
fig_3=figure ('Name','Qab_max_norm/Offset_norm');
title ('Normierte maximale Querablage über normiertem Offset')
subtitle('Regressionsgeraden')
grid on
hold on 
for n=a:s:z%size(Reg,2)
plot(Reg(n).yOff_Qablmax_X_L,Reg(n).yOff_Qablmax_Y_L)%,'blue','LineWidth',1)%Linkskurve
plot(Reg(n).yOff_Qablmax_X_R,Reg(n).yOff_Qablmax_Y_R)%,'red','LineWidth',1)%Rechtskurve
end
xlabel ('normiertet Offset zur Kurvenbeginn')
ylabel ('normierte maximale Querablage')
legend ('Linkskurve','Rechtskurve')
hold off


% normierte maximale Querablage über Durchschnittsgeschwindigkeit
fig_4=figure ('Name','Qab_max_norm/v_durchschnitt');
title ('Normierte maximale Querablage über Durchschnittsgeschwindigkeit')
subtitle('Regressionsgeraden')
grid on
hold on 
for n=a:s:z%size(Reg,2)
plot(Reg(n).vd_Qablmax_X_L,Reg(n).vd_Qablmax_Y_L)%,'blue','LineWidth',1)%Linkskurve
plot(Reg(n).vd_Qablmax_X_R,Reg(n).vd_Qablmax_Y_R)%,'red','LineWidth',1)%Rechtskurve
end
xlabel ('durchschnittliche Geschwindigkeit')
ylabel ('normierte maximale Querablage')
legend ('Linkskurve','Rechtskurve')
hold off


% normierte maximale Querablage über Krümmung
fig_11=figure ('Name','Qab_max_norm/Krümmung');
title ('normierter maximale Querablage über Krümmung')
subtitle('Regressionsgeraden')
grid on
hold on 
for n=a:s:z%size(Reg,2)
plot(Reg(n).Kr_Qablmax_X_L,Reg(n).Kr_Qablmax_Y_L)%,'blue','LineWidth',1)%Linkskurve
plot(Reg(n).Kr_Qablmax_X_R,Reg(n).Kr_Qablmax_Y_R)%,'red','LineWidth',1)%Rechtskurve
end
xlabel ('Krümmung')
ylabel ('normierte maximale Querablage')
legend ('Linkskurve','Rechtskurve')
hold off