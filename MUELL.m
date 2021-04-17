for c=1:size(Ergebnis01_kM,2)
if c > 1
  Pkt_b=(Ergebnis01_kM(4,c)-Ergebnis01_kM(4,c-1));
    if Ergebnis01_kM(4,c)*10+5<anzahl
    Ergebnis01_kM(37,c)=round(mean(Sb((Ergebnis01_kM(4,c-1)+0.2*Pkt_b)*10-5:(Ergebnis01_kM(4,c-1)+0.2*Pkt_b)*10+5)),1);
    Ergebnis01_kM(38,c)=round(mean(Sb((Ergebnis01_kM(4,c-1)+0.4*Pkt_b)*10-5:(Ergebnis01_kM(4,c-1)+0.4*Pkt_b)*10+5)),1);
    Ergebnis01_kM(39,c)=round(mean(Sb((Ergebnis01_kM(4,c-1)+0.6*Pkt_b)*10-5:(Ergebnis01_kM(4,c-1)+0.6*Pkt_b)*10+5)),1);
    Ergebnis01_kM(40,c)=round(mean(Sb((Ergebnis01_kM(4,c-1)+0.8*Pkt_b)*10-5:(Ergebnis01_kM(4,c-1)+0.8*Pkt_b)*10+5)),1);
    Ergebnis01_kM(41,c)=round(mean(Sb((Ergebnis01_kM(4,c-1)+1.0*Pkt_b)*10-5:(Ergebnis01_kM(4,c-1)+1.0*Pkt_b)*10+5)),1);
    else
    Ergebnis01_kM(37,c)=round(mean(Sb((Ergebnis01_kM(4,c-1)+0.2*Pkt_b)*10-5:(Ergebnis01_kM(4,c-1)+0.2*Pkt_b)*10)),1);
    Ergebnis01_kM(38,c)=round(mean(Sb((Ergebnis01_kM(4,c-1)+0.4*Pkt_b)*10-5:(Ergebnis01_kM(4,c-1)+0.4*Pkt_b)*10)),1);
    Ergebnis01_kM(39,c)=round(mean(Sb((Ergebnis01_kM(4,c-1)+0.6*Pkt_b)*10-5:(Ergebnis01_kM(4,c-1)+0.6*Pkt_b)*10)),1);
    Ergebnis01_kM(40,c)=round(mean(Sb((Ergebnis01_kM(4,c-1)+0.8*Pkt_b)*10-5:(Ergebnis01_kM(4,c-1)+0.8*Pkt_b)*10)),1);
    Ergebnis01_kM(41,c)=round(mean(Sb((Ergebnis01_kM(4,c-1)+1.0*Pkt_b)*10-5:(Ergebnis01_kM(4,c-1)+1.0*Pkt_b)*10)),1);
    end 
  
  
else
  Pkt_b=Ergebnis01_kM(4,c);  

    if Ergebnis01_kM(4,c)*10+5<anzahl
    Ergebnis01_kM(37,c)=round(mean(Sb((Ergebnis01_kM(4,c)+0.2*Pkt_b)*10-5:(Ergebnis01_kM(4,c)+0.2*Pkt_b)*10+5)),1);
    Ergebnis01_kM(38,c)=round(mean(Sb((Ergebnis01_kM(4,c)+0.4*Pkt_b)*10-5:(Ergebnis01_kM(4,c)+0.4*Pkt_b)*10+5)),1);
    Ergebnis01_kM(39,c)=round(mean(Sb((Ergebnis01_kM(4,c)+0.6*Pkt_b)*10-5:(Ergebnis01_kM(4,c)+0.6*Pkt_b)*10+5)),1);
    Ergebnis01_kM(40,c)=round(mean(Sb((Ergebnis01_kM(4,c)+0.8*Pkt_b)*10-5:(Ergebnis01_kM(4,c)+0.8*Pkt_b)*10+5)),1);
    Ergebnis01_kM(41,c)=round(mean(Sb((Ergebnis01_kM(4,c)+1.0*Pkt_b)*10-5:(Ergebnis01_kM(4,c)+1.0*Pkt_b)*10+5)),1);
    else
    Ergebnis01_kM(37,c)=round(mean(Sb((Ergebnis01_kM(4,c)+0.2*Pkt_b)*10-5:(Ergebnis01_kM(4,c)+0.2*Pkt_b)*10)),1);
    Ergebnis01_kM(38,c)=round(mean(Sb((Ergebnis01_kM(4,c)+0.4*Pkt_b)*10-5:(Ergebnis01_kM(4,c)+0.4*Pkt_b)*10)),1);
    Ergebnis01_kM(39,c)=round(mean(Sb((Ergebnis01_kM(4,c)+0.6*Pkt_b)*10-5:(Ergebnis01_kM(4,c)+0.6*Pkt_b)*10)),1);
    Ergebnis01_kM(40,c)=round(mean(Sb((Ergebnis01_kM(4,c)+0.8*Pkt_b)*10-5:(Ergebnis01_kM(4,c)+0.8*Pkt_b)*10)),1);
    Ergebnis01_kM(41,c)=round(mean(Sb((Ergebnis01_kM(4,c)+1.0*Pkt_b)*10-5:(Ergebnis01_kM(4,c)+1.0*Pkt_b)*10)),1);
    end
end
end