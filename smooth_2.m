x=fas_navi_ehr_GPS_Latitude_t00(1,1:1:90002);
y=fas_navi_ehr_GPS_Longitude_t00(1,1:1:90002);

% x = gps_Breitengrad_t00;
% y = gps_Laengengrad_t00;

N=size(x,2);

groesse = 8000;        %verwendetete Punktanzahl, muss an Schrittweite empirisch angepasst werden!

distance = 0.001;       %Anpeil Radius 
stepL = 0.0001;           %Schrittweite !!Muss mindestens 5x kleiner sein als der anpeil Radius

x_new=NaN(1,groesse);
y_new=NaN(1,groesse);

x_new(1,1) = x(1,1);
y_new(1,1) = y(1,1); 

i=1;
diY=0;
diX=0;

for j=2:groesse
    while ((x_new(1,j-1) - x(1,i))^2 + (y_new(1,j-1) - y(1,i))^2) < distance^2 && i<N %sucht naechsten Punkt mit richtigem Abstand
        i=i+1;
    end
    if(j>2)
        diY = (y_new(1,j-1) - y_new(1,j-2))*400;
        diX = (x_new(1,j-1) - x_new(1,j-2))*400;
    end
    xx1 = (x(1,i)-x_new(1,j-1)) + diX;
    yy2 = (y(1,i)-y_new(1,j-1)) + diY;
    
    le = sqrt(xx1.^2 + yy2.^2);
    
    x_new(1,j) = x_new(1,j-1) + stepL*(xx1/le);
    y_new(1,j) = y_new(1,j-1) + stepL*(yy2/le);
    x_new(1,j)
    if (abs(x(1,N) - x_new(1,j)) < distance)
        groesse = j-1;
        fprintf('Groesse von %d ausreichend!\n',groesse)
        break
    end
end

temVarY= y_new(1,1:1:groesse);
temVarX= x_new(1,1:1:groesse);
x_new=[];
y_new=[];
x_new=temVarX;
y_new=temVarY;
temVarX=[];
temVarY=[];

hold on
%plot(gps_Breitengrad_t00,gps_Laengengrad_t00)
plot(x,y);
plot(x_new,y_new);

daspect([1 1 1])
pbaspect([16 9 1])
hold off