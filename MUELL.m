Achtung_die_Kurve___Kruemmungserkennung_einzeln
n=5
% for n=1:size(Ergebnis_Kr,2)
hold on
XY=[x(Ergebnis_Kr(1,n)-200:Ergebnis_Kr(1,n)+200);y(Ergebnis_Kr(1,n)-200:Ergebnis_Kr(1,n)+200)];
% XY=[x(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n));y(Ergebnis_Kr(5,n):Ergebnis_Kr(10,n))];
Kp=100; % Kp= Kreispunkte
phi=linspace(0,2*pi,Kp);
xm=x(Ergebnis_Kr(1,n)); % X-Wert Mittelpunkt
ym=y(Ergebnis_Kr(1,n)); % Y_Wert Mittelpunkt
rw=abs(Ergebnis_Kr(2,n));  % Radius
x_KO=xm+rw*sin(phi); % KO = Kreis Original
y_KO=ym+rw*cos(phi);
plot(x_KO,y_KO)
XY_KO=[x_KO;y_KO];

Mp_Diff=[];
for i=1:Kp
    Mp_Diff(1,i) = 0;
     for j=1:size(XY,2)
          Mp_Diff(1,i) = Mp_Diff(1,i) + ((XY_KO(1,i)-XY(1,j))^2+(XY_KO(2,i)-XY(2,j))^2);
     end
    
    phi=linspace(0,2*pi,100);
    xm=XY_KO(1,i); % X-Wert Mittelpunkt
    ym=XY_KO(2,i); % Y_Wert Mittelpunkt
     % Radius
    x_KO=xm+rw*sin(phi); % KO = Kreis Original
    y_KO=ym+rw*cos(phi);
    plot(x_KO,y_KO)
 
     
     
end

Mp=find(Mp_Diff==min(Mp_Diff),1,'first');

% if Ergebnis_Kr(2,n)>0
% Mp=find(Mp_Diff==min(Mp_Diff(0.5*Kp:Kp)),1,'first');
% else
% Mp=find(Mp_Diff==min(Mp_Diff(1:0.5*Kp)),1,'first');
% end

phi=linspace(0,2*pi,100);
xm=XY_KO(1,Mp); % X-Wert Mittelpunkt
ym=XY_KO(2,Mp); % Y_Wert Mittelpunkt
rw=abs(Ergebnis_Kr(2,n));  % Radius
x_KO=xm+rw*sin(phi); % KO = Kreis Original
y_KO=ym+rw*cos(phi);
plot(x_KO,y_KO)

% end

figure
plot(Mp_Diff)