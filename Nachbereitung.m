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


 
 
  
% zusammengefuegte Daten transponieren, damit "sortrows" funktioniert

Ergebnis_Matrix=allData.Ergebnis01_kM';
Ergebnis_Matrix_sortiert=sortrows(Ergebnis_Matrix,33);
% Ergebnis_Matrix_sortiert=sortrows(Ergebnis_Matrix_sortiert,3);
 



%% Filtern der Daten (loeschen unvollstaendiger Daten, Unterteilung in Geraden, Links- und Rechtskurven)
i=1;
for n=1:size(Ergebnis_Matrix_sortiert,1)

    if  Ergebnis_Matrix_sortiert(n,21)< 2
        Ergebnis_Matrix_sortiert(n,:)=0;
    end
    if  Ergebnis_Matrix_sortiert(n,10)< 2
        Ergebnis_Matrix_sortiert(n,:)=0;
    end
    
    if  0<Ergebnis_Matrix_sortiert(n,33) && Ergebnis_Matrix_sortiert(n,33)<0.02 && Ergebnis_Matrix_sortiert(n,3)>1000
        Ergebnis_Gerade(i,:)=Ergebnis_Matrix_sortiert(n,:);
        Ergebnis_Matrix_sortiert(n,:)=0;
        i=i+1;
    end 
end

i=1;
j=1;
for n=1:size(Ergebnis_Matrix_sortiert,1)
    if Ergebnis_Matrix_sortiert(n,32)<0
       Ergebnis_Rechtskurve(i,:)=Ergebnis_Matrix_sortiert(n,:);
       Ergebnis_Matrix_sortiert(n,:)=0;
       i=i+1;
    end
    
    if Ergebnis_Matrix_sortiert(n,32)>0
       Ergebnis_Linkskurve(j,:)=Ergebnis_Matrix_sortiert(n,:);
       Ergebnis_Matrix_sortiert(n,:)=0;
       j=j+1; 
    end
    
end
j=[];
i=[];
% loescht alle leeren Zeilen
Ergebnis_Matrix_sortiert=Ergebnis_Matrix_sortiert(~all(Ergebnis_Matrix_sortiert == 0, 2),:);

%% Rechtskurve

a=1; b=1; c=1; d=1; e=1; f=1; g=1; h=1; i=1; j=1; k=1; l=1; m=1; o=1; p=1; q=1;
r=1; s=1; t=1; u=1; v=1; w=1; x=1; y=1; z=1; ii=1; jj=1; kk=1; ll=1; mm=1; oo=1;
pp=1; qq=1; rr=1; ss=1; tt=1; uu=1; vv=1; ww=1; xx=1; yy=1; zz=1; aa=1; bb=1; cc=1;
dd=1; ee=1;


for n=1:size(Ergebnis_Rechtskurve,1)
    if Ergebnis_Rechtskurve(n,3)>50 && Ergebnis_Rechtskurve(n,3)<=100
       Ergebnis_Rechtskurve_0050_0100(i,:)=Ergebnis_Rechtskurve(n,:);
       i=i+1;
    end
    
    if Ergebnis_Rechtskurve(n,3)>100 && Ergebnis_Rechtskurve(n,3)<=150
       Ergebnis_Rechtskurve_0100_0150(j,:)=Ergebnis_Rechtskurve(n,:);
       j=j+1;
    end
    
    if Ergebnis_Rechtskurve(n,3)>150 && Ergebnis_Rechtskurve(n,3)<=200
       Ergebnis_Rechtskurve_0150_0200(k,:)=Ergebnis_Rechtskurve(n,:);
       k=k+1;
    end

    if Ergebnis_Rechtskurve(n,3)>200 && Ergebnis_Rechtskurve(n,3)<=250
       Ergebnis_Rechtskurve_0200_0250(l,:)=Ergebnis_Rechtskurve(n,:);
       l=l+1;
    end    

    if Ergebnis_Rechtskurve(n,3)>250 && Ergebnis_Rechtskurve(n,3)<=300
       Ergebnis_Rechtskurve_0250_0300(m,:)=Ergebnis_Rechtskurve(n,:);
       m=m+1;
    end
    
    if Ergebnis_Rechtskurve(n,3)>300 && Ergebnis_Rechtskurve(n,3)<=350
       Ergebnis_Rechtskurve_0300_0350(o,:)=Ergebnis_Rechtskurve(n,:);
       o=o+1;
    end
    
    if Ergebnis_Rechtskurve(n,3)>350 && Ergebnis_Rechtskurve(n,3)<=400
       Ergebnis_Rechtskurve_0350_0400(p,:)=Ergebnis_Rechtskurve(n,:);
       p=p+1;
    end

    if Ergebnis_Rechtskurve(n,3)>400 && Ergebnis_Rechtskurve(n,3)<=450
       Ergebnis_Rechtskurve_0400_0450(q,:)=Ergebnis_Rechtskurve(n,:);
       q=q+1;
    end    

    if Ergebnis_Rechtskurve(n,3)>450 && Ergebnis_Rechtskurve(n,3)<=500
       Ergebnis_Rechtskurve_0450_0500(r,:)=Ergebnis_Rechtskurve(n,:);
       r=r+1;
    end
    
    if Ergebnis_Rechtskurve(n,3)>500 && Ergebnis_Rechtskurve(n,3)<=550
       Ergebnis_Rechtskurve_0500_0550(t,:)=Ergebnis_Rechtskurve(n,:);
       s=s+1;
    end
    
    if Ergebnis_Rechtskurve(n,3)>550 && Ergebnis_Rechtskurve(n,3)<=600
       Ergebnis_Rechtskurve_0550_0600(u,:)=Ergebnis_Rechtskurve(n,:);
       u=u+1;
    end

    if Ergebnis_Rechtskurve(n,3)>600 && Ergebnis_Rechtskurve(n,3)<=650
       Ergebnis_Rechtskurve_0600_0650(v,:)=Ergebnis_Rechtskurve(n,:);
       v=v+1;
    end    

    if Ergebnis_Rechtskurve(n,3)>650 && Ergebnis_Rechtskurve(n,3)<=700
       Ergebnis_Rechtskurve_0650_0700(w,:)=Ergebnis_Rechtskurve(n,:);
       w=w+1;
    end
    
    if Ergebnis_Rechtskurve(n,3)>700 && Ergebnis_Rechtskurve(n,3)<=750
       Ergebnis_Rechtskurve_0700_0750(x,:)=Ergebnis_Rechtskurve(n,:);
       x=x+1;
    end
    
    if Ergebnis_Rechtskurve(n,3)>750 && Ergebnis_Rechtskurve(n,3)<=800
       Ergebnis_Rechtskurve_0750_0800(y,:)=Ergebnis_Rechtskurve(n,:);
       y=y+1;
    end

    if Ergebnis_Rechtskurve(n,3)>800 && Ergebnis_Rechtskurve(n,3)<=850
       Ergebnis_Rechtskurve_0800_0850(z,:)=Ergebnis_Rechtskurve(n,:);
       z=z+1;
    end     

    if Ergebnis_Rechtskurve(n,3)>850 && Ergebnis_Rechtskurve(n,3)<=900
       Ergebnis_Rechtskurve_0850_0900(a,:)=Ergebnis_Rechtskurve(n,:);
       a=a+1;
    end
    
    if Ergebnis_Rechtskurve(n,3)>900 && Ergebnis_Rechtskurve(n,3)<=950
       Ergebnis_Rechtskurve_0900_0950(j,:)=Ergebnis_Rechtskurve(n,:);
       j=j+1;
    end
    
    if Ergebnis_Rechtskurve(n,3)>950 && Ergebnis_Rechtskurve(n,3)<=1000
       Ergebnis_Rechtskurve_0950_1000(b,:)=Ergebnis_Rechtskurve(n,:);
       b=b+1;
    end

    if Ergebnis_Rechtskurve(n,3)>1000 && Ergebnis_Rechtskurve(n,3)<=1050
       Ergebnis_Rechtskurve_1000_1050(c,:)=Ergebnis_Rechtskurve(n,:);
       c=c+1;
    end    

    if Ergebnis_Rechtskurve(n,3)>1050 && Ergebnis_Rechtskurve(n,3)<=1100
       Ergebnis_Rechtskurve_1050_1100(d,:)=Ergebnis_Rechtskurve(n,:);
       d=d+1;
    end
    
    if Ergebnis_Rechtskurve(n,3)>1100 && Ergebnis_Rechtskurve(n,3)<=1150
       Ergebnis_Rechtskurve_1100_1150(e,:)=Ergebnis_Rechtskurve(n,:);
       e=e+1;
    end
    
    if Ergebnis_Rechtskurve(n,3)>1150 && Ergebnis_Rechtskurve(n,3)<=1200
       Ergebnis_Rechtskurve_1150_1200(f,:)=Ergebnis_Rechtskurve(n,:);
       f=f+1;
    end

    if Ergebnis_Rechtskurve(n,3)>1200 && Ergebnis_Rechtskurve(n,3)<=1250
       Ergebnis_Rechtskurve_1200_1250(g,:)=Ergebnis_Rechtskurve(n,:);
       g=g+1;
    end
    if Ergebnis_Rechtskurve(n,3)>1250 && Ergebnis_Rechtskurve(n,3)<=1300
       Ergebnis_Rechtskurve_1250_1300(h,:)=Ergebnis_Rechtskurve(n,:);
       h=h+1;
    end

    if Ergebnis_Rechtskurve(n,3)>1300 && Ergebnis_Rechtskurve(n,3)<=1400
       Ergebnis_Rechtskurve_1300_1400(ii,:)=Ergebnis_Rechtskurve(n,:);
       ii=ii+1;
    end    

    if Ergebnis_Rechtskurve(n,3)>1400 && Ergebnis_Rechtskurve(n,3)<=1500
       Ergebnis_Rechtskurve_1400_1500(jj,:)=Ergebnis_Rechtskurve(n,:);
       jj=jj+1;
    end
    
    if Ergebnis_Rechtskurve(n,3)>1500 && Ergebnis_Rechtskurve(n,3)<=1600
       Ergebnis_Rechtskurve_1500_1600(kk,:)=Ergebnis_Rechtskurve(n,:);
       kk=kk+1;
    end
    
    if Ergebnis_Rechtskurve(n,3)>1600 && Ergebnis_Rechtskurve(n,3)<=1700
       Ergebnis_Rechtskurve_1600_1700(ll,:)=Ergebnis_Rechtskurve(n,:);
       ll=ll+1;
    end

    if Ergebnis_Rechtskurve(n,3)>1700 && Ergebnis_Rechtskurve(n,3)<=1800
       Ergebnis_Rechtskurve_1700_1800(mm,:)=Ergebnis_Rechtskurve(n,:);
       mm=mm+1;
    end    
    if Ergebnis_Rechtskurve(n,3)>1800 && Ergebnis_Rechtskurve(n,3)<=1900
       Ergebnis_Rechtskurve_1800_1900(oo,:)=Ergebnis_Rechtskurve(n,:);
       oo=oo+1;
    end
    if Ergebnis_Rechtskurve(n,3)>1900 && Ergebnis_Rechtskurve(n,3)<=2000
       Ergebnis_Rechtskurve_1900_2000(pp,:)=Ergebnis_Rechtskurve(n,:);
       pp=pp+1;
    end

    if Ergebnis_Rechtskurve(n,3)>2000 && Ergebnis_Rechtskurve(n,3)<=2200
       Ergebnis_Rechtskurve_2000_2200(qq,:)=Ergebnis_Rechtskurve(n,:);
       qq=qq+1;
    end    

    if Ergebnis_Rechtskurve(n,3)>2200 && Ergebnis_Rechtskurve(n,3)<=2400
       Ergebnis_Rechtskurve_2200_2400(rr,:)=Ergebnis_Rechtskurve(n,:);
       rr=rr+1;
    end
    
    if Ergebnis_Rechtskurve(n,3)>2400 && Ergebnis_Rechtskurve(n,3)<=2600
       Ergebnis_Rechtskurve_2400_2600(ss,:)=Ergebnis_Rechtskurve(n,:);
       ss=ss+1;
    end
    
    if Ergebnis_Rechtskurve(n,3)>2600 && Ergebnis_Rechtskurve(n,3)<=2800
       Ergebnis_Rechtskurve_2600_2800(tt,:)=Ergebnis_Rechtskurve(n,:);
       tt=tt+1;
    end

    if Ergebnis_Rechtskurve(n,3)>2800 && Ergebnis_Rechtskurve(n,3)<=3000
       Ergebnis_Rechtskurve_2800_3000(uu,:)=Ergebnis_Rechtskurve(n,:);
       uu=uu+1;
    end 
    
    if Ergebnis_Rechtskurve(n,3)>3000 && Ergebnis_Rechtskurve(n,3)<=3500
       Ergebnis_Rechtskurve_3000_3500(vv,:)=Ergebnis_Rechtskurve(n,:);
       vv=vv+1;
    end

    if Ergebnis_Rechtskurve(n,3)>3500 && Ergebnis_Rechtskurve(n,3)<=4000
       Ergebnis_Rechtskurve_3500_4000(ww,:)=Ergebnis_Rechtskurve(n,:);
       ww=ww+1;
    end    
    if Ergebnis_Rechtskurve(n,3)>4000 && Ergebnis_Rechtskurve(n,3)<=4500
       Ergebnis_Rechtskurve_4000_4500(xx,:)=Ergebnis_Rechtskurve(n,:);
       xx=xx+1;
    end
    if Ergebnis_Rechtskurve(n,3)>4500 && Ergebnis_Rechtskurve(n,3)<=5000
       Ergebnis_Rechtskurve_4500_5000(zz,:)=Ergebnis_Rechtskurve(n,:);
       zz=zz+1;
    end

    if Ergebnis_Rechtskurve(n,3)>5000 && Ergebnis_Rechtskurve(n,3)<=5500
       Ergebnis_Rechtskurve_5000_5500(aa,:)=Ergebnis_Rechtskurve(n,:);
       aa=aa+1;
    end    

    if Ergebnis_Rechtskurve(n,3)>5500 && Ergebnis_Rechtskurve(n,3)<=6000
       Ergebnis_Rechtskurve_5500_6000(bb,:)=Ergebnis_Rechtskurve(n,:);
       bb=bb+1;
    end
    
    if Ergebnis_Rechtskurve(n,3)>6000 && Ergebnis_Rechtskurve(n,3)<=6500
       Ergebnis_Rechtskurve_6000_6500(cc,:)=Ergebnis_Rechtskurve(n,:);
       cc=cc+1;
    end
    
    if Ergebnis_Rechtskurve(n,3)>6500 && Ergebnis_Rechtskurve(n,3)<=7000
       Ergebnis_Rechtskurve_6500_7000(dd,:)=Ergebnis_Rechtskurve(n,:);
       dd=dd+1;
    end

    if Ergebnis_Rechtskurve(n,3)>7000
       Ergebnis_Rechtskurve_7000_Ende(ee,:)=Ergebnis_Rechtskurve(n,:);
       ee=ee+1;
    end     
end

%% Linkskurve

a=1; b=1; c=1; d=1; e=1; f=1; g=1; h=1; i=1; j=1; k=1; l=1; m=1; o=1; p=1; q=1;
r=1; s=1; t=1; u=1; v=1; w=1; x=1; y=1; z=1; ii=1; jj=1; kk=1; ll=1; mm=1; oo=1;
pp=1; qq=1; rr=1; ss=1; tt=1; uu=1; vv=1; ww=1; xx=1; yy=1; zz=1; aa=1; bb=1; cc=1;
dd=1; ee=1;


for n=1:size(Ergebnis_Linkskurve,1)
    if Ergebnis_Linkskurve(n,3)>50 && Ergebnis_Linkskurve(n,3)<=100
       Ergebnis_Linkskurve_0050_0100(i,:)=Ergebnis_Linkskurve(n,:);
       i=i+1;
    end
    
    if Ergebnis_Linkskurve(n,3)>100 && Ergebnis_Linkskurve(n,3)<=150
       Ergebnis_Linkskurve_0100_0150(j,:)=Ergebnis_Linkskurve(n,:);
       j=j+1;
    end
    
    if Ergebnis_Linkskurve(n,3)>150 && Ergebnis_Linkskurve(n,3)<=200
       Ergebnis_Linkskurve_0150_0200(k,:)=Ergebnis_Linkskurve(n,:);
       k=k+1;
    end

    if Ergebnis_Linkskurve(n,3)>200 && Ergebnis_Linkskurve(n,3)<=250
       Ergebnis_Linkskurve_0200_0250(l,:)=Ergebnis_Linkskurve(n,:);
       l=l+1;
    end    

    if Ergebnis_Linkskurve(n,3)>250 && Ergebnis_Linkskurve(n,3)<=300
       Ergebnis_Linkskurve_0250_0300(m,:)=Ergebnis_Linkskurve(n,:);
       m=m+1;
    end
    
    if Ergebnis_Linkskurve(n,3)>300 && Ergebnis_Linkskurve(n,3)<=350
       Ergebnis_Linkskurve_0300_0350(o,:)=Ergebnis_Linkskurve(n,:);
       o=o+1;
    end
    
    if Ergebnis_Linkskurve(n,3)>350 && Ergebnis_Linkskurve(n,3)<=400
       Ergebnis_Linkskurve_0350_0400(p,:)=Ergebnis_Linkskurve(n,:);
       p=p+1;
    end

    if Ergebnis_Linkskurve(n,3)>400 && Ergebnis_Linkskurve(n,3)<=450
       Ergebnis_Linkskurve_0400_0450(q,:)=Ergebnis_Linkskurve(n,:);
       q=q+1;
    end    

    if Ergebnis_Linkskurve(n,3)>450 && Ergebnis_Linkskurve(n,3)<=500
       Ergebnis_Linkskurve_0450_0500(r,:)=Ergebnis_Linkskurve(n,:);
       r=r+1;
    end
    
    if Ergebnis_Linkskurve(n,3)>500 && Ergebnis_Linkskurve(n,3)<=550
       Ergebnis_Linkskurve_0500_0550(t,:)=Ergebnis_Linkskurve(n,:);
       s=s+1;
    end
    
    if Ergebnis_Linkskurve(n,3)>550 && Ergebnis_Linkskurve(n,3)<=600
       Ergebnis_Linkskurve_0550_0600(u,:)=Ergebnis_Linkskurve(n,:);
       u=u+1;
    end

    if Ergebnis_Linkskurve(n,3)>600 && Ergebnis_Linkskurve(n,3)<=650
       Ergebnis_Linkskurve_0600_0650(v,:)=Ergebnis_Linkskurve(n,:);
       v=v+1;
    end    

    if Ergebnis_Linkskurve(n,3)>650 && Ergebnis_Linkskurve(n,3)<=700
       Ergebnis_Linkskurve_0650_0700(w,:)=Ergebnis_Linkskurve(n,:);
       w=w+1;
    end
    
    if Ergebnis_Linkskurve(n,3)>700 && Ergebnis_Linkskurve(n,3)<=750
       Ergebnis_Linkskurve_0700_0750(x,:)=Ergebnis_Linkskurve(n,:);
       x=x+1;
    end
    
    if Ergebnis_Linkskurve(n,3)>750 && Ergebnis_Linkskurve(n,3)<=800
       Ergebnis_Linkskurve_0750_0800(y,:)=Ergebnis_Linkskurve(n,:);
       y=y+1;
    end

    if Ergebnis_Linkskurve(n,3)>800 && Ergebnis_Linkskurve(n,3)<=850
       Ergebnis_Linkskurve_0800_0850(z,:)=Ergebnis_Linkskurve(n,:);
       z=z+1;
    end     

    if Ergebnis_Linkskurve(n,3)>850 && Ergebnis_Linkskurve(n,3)<=900
       Ergebnis_Linkskurve_0850_0900(a,:)=Ergebnis_Linkskurve(n,:);
       a=a+1;
    end
    
    if Ergebnis_Linkskurve(n,3)>900 && Ergebnis_Linkskurve(n,3)<=950
       Ergebnis_Linkskurve_0900_0950(j,:)=Ergebnis_Linkskurve(n,:);
       j=j+1;
    end
    
    if Ergebnis_Linkskurve(n,3)>950 && Ergebnis_Linkskurve(n,3)<=1000
       Ergebnis_Linkskurve_0950_1000(b,:)=Ergebnis_Linkskurve(n,:);
       b=b+1;
    end

    if Ergebnis_Linkskurve(n,3)>1000 && Ergebnis_Linkskurve(n,3)<=1050
       Ergebnis_Linkskurve_1000_1050(c,:)=Ergebnis_Linkskurve(n,:);
       c=c+1;
    end    

    if Ergebnis_Linkskurve(n,3)>1050 && Ergebnis_Linkskurve(n,3)<=1100
       Ergebnis_Linkskurve_1050_1100(d,:)=Ergebnis_Linkskurve(n,:);
       d=d+1;
    end
    
    if Ergebnis_Linkskurve(n,3)>1100 && Ergebnis_Linkskurve(n,3)<=1150
       Ergebnis_Linkskurve_1100_1150(e,:)=Ergebnis_Linkskurve(n,:);
       e=e+1;
    end
    
    if Ergebnis_Linkskurve(n,3)>1150 && Ergebnis_Linkskurve(n,3)<=1200
       Ergebnis_Linkskurve_1150_1200(f,:)=Ergebnis_Linkskurve(n,:);
       f=f+1;
    end

    if Ergebnis_Linkskurve(n,3)>1200 && Ergebnis_Linkskurve(n,3)<=1250
       Ergebnis_Linkskurve_1200_1250(g,:)=Ergebnis_Linkskurve(n,:);
       g=g+1;
    end
    if Ergebnis_Linkskurve(n,3)>1250 && Ergebnis_Linkskurve(n,3)<=1300
       Ergebnis_Linkskurve_1250_1300(h,:)=Ergebnis_Linkskurve(n,:);
       h=h+1;
    end

    if Ergebnis_Linkskurve(n,3)>1300 && Ergebnis_Linkskurve(n,3)<=1400
       Ergebnis_Linkskurve_1300_1400(ii,:)=Ergebnis_Linkskurve(n,:);
       ii=ii+1;
    end    

    if Ergebnis_Linkskurve(n,3)>1400 && Ergebnis_Linkskurve(n,3)<=1500
       Ergebnis_Linkskurve_1400_1500(jj,:)=Ergebnis_Linkskurve(n,:);
       jj=jj+1;
    end
    
    if Ergebnis_Linkskurve(n,3)>1500 && Ergebnis_Linkskurve(n,3)<=1600
       Ergebnis_Linkskurve_1500_1600(kk,:)=Ergebnis_Linkskurve(n,:);
       kk=kk+1;
    end
    
    if Ergebnis_Linkskurve(n,3)>1600 && Ergebnis_Linkskurve(n,3)<=1700
       Ergebnis_Linkskurve_1600_1700(ll,:)=Ergebnis_Linkskurve(n,:);
       ll=ll+1;
    end

    if Ergebnis_Linkskurve(n,3)>1700 && Ergebnis_Linkskurve(n,3)<=1800
       Ergebnis_Linkskurve_1700_1800(mm,:)=Ergebnis_Linkskurve(n,:);
       mm=mm+1;
    end    
    if Ergebnis_Linkskurve(n,3)>1800 && Ergebnis_Linkskurve(n,3)<=1900
       Ergebnis_Linkskurve_1800_1900(oo,:)=Ergebnis_Linkskurve(n,:);
       oo=oo+1;
    end
    if Ergebnis_Linkskurve(n,3)>1900 && Ergebnis_Linkskurve(n,3)<=2000
       Ergebnis_Linkskurve_1900_2000(pp,:)=Ergebnis_Linkskurve(n,:);
       pp=pp+1;
    end

    if Ergebnis_Linkskurve(n,3)>2000 && Ergebnis_Linkskurve(n,3)<=2200
       Ergebnis_Linkskurve_2000_2200(qq,:)=Ergebnis_Linkskurve(n,:);
       qq=qq+1;
    end    

    if Ergebnis_Linkskurve(n,3)>2200 && Ergebnis_Linkskurve(n,3)<=2400
       Ergebnis_Linkskurve_2200_2400(rr,:)=Ergebnis_Linkskurve(n,:);
       rr=rr+1;
    end
    
    if Ergebnis_Linkskurve(n,3)>2400 && Ergebnis_Linkskurve(n,3)<=2600
       Ergebnis_Linkskurve_2400_2600(ss,:)=Ergebnis_Linkskurve(n,:);
       ss=ss+1;
    end
    
    if Ergebnis_Linkskurve(n,3)>2600 && Ergebnis_Linkskurve(n,3)<=2800
       Ergebnis_Linkskurve_2600_2800(tt,:)=Ergebnis_Linkskurve(n,:);
       tt=tt+1;
    end

    if Ergebnis_Linkskurve(n,3)>2800 && Ergebnis_Linkskurve(n,3)<=3000
       Ergebnis_Linkskurve_2800_3000(uu,:)=Ergebnis_Linkskurve(n,:);
       uu=uu+1;
    end 
    
    if Ergebnis_Linkskurve(n,3)>3000 && Ergebnis_Linkskurve(n,3)<=3500
       Ergebnis_Linkskurve_3000_3500(vv,:)=Ergebnis_Linkskurve(n,:);
       vv=vv+1;
    end

    if Ergebnis_Linkskurve(n,3)>3500 && Ergebnis_Linkskurve(n,3)<=4000
       Ergebnis_Linkskurve_3500_4000(ww,:)=Ergebnis_Linkskurve(n,:);
       ww=ww+1;
    end    
    if Ergebnis_Linkskurve(n,3)>4000 && Ergebnis_Linkskurve(n,3)<=4500
       Ergebnis_Linkskurve_4000_4500(xx,:)=Ergebnis_Linkskurve(n,:);
       xx=xx+1;
    end
    if Ergebnis_Linkskurve(n,3)>4500 && Ergebnis_Linkskurve(n,3)<=5000
       Ergebnis_Linkskurve_4500_5000(zz,:)=Ergebnis_Linkskurve(n,:);
       zz=zz+1;
    end

    if Ergebnis_Linkskurve(n,3)>5000 && Ergebnis_Linkskurve(n,3)<=5500
       Ergebnis_Linkskurve_5000_5500(aa,:)=Ergebnis_Linkskurve(n,:);
       aa=aa+1;
    end    

    if Ergebnis_Linkskurve(n,3)>5500 && Ergebnis_Linkskurve(n,3)<=6000
       Ergebnis_Linkskurve_5500_6000(bb,:)=Ergebnis_Linkskurve(n,:);
       bb=bb+1;
    end
    
    if Ergebnis_Linkskurve(n,3)>6000 && Ergebnis_Linkskurve(n,3)<=6500
       Ergebnis_Linkskurve_6000_6500(cc,:)=Ergebnis_Linkskurve(n,:);
       cc=cc+1;
    end
    
    if Ergebnis_Linkskurve(n,3)>6500 && Ergebnis_Linkskurve(n,3)<=7000
       Ergebnis_Linkskurve_6500_7000(dd,:)=Ergebnis_Linkskurve(n,:);
       dd=dd+1;
    end

    if Ergebnis_Linkskurve(n,3)>7000
       Ergebnis_Linkskurve_7000_Ende(ee,:)=Ergebnis_Linkskurve(n,:);
       ee=ee+1;
    end     
end



clear a aa b bb c cc d dd e ee f g h i ii j jj k kk l ll m mm o oo p pp q qq r rr s ss t tt u uu v vv w ww x xx y yy z zz 

