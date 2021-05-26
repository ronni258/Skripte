
Name1 = allg_datum_t00; %dient zur Benennung und Abspeicherung
Name2 = allg_zeit_t00;
%Bennenung der Figure
inp2 = 'Querbeschleunigung_';
[~,fnm,ext] = fileparts(inp2);
out = sprintf('%s',fnm,Name1,'_' ,Name2,ext);

fig=figure;
set(fig,'Name',out)
hold
% fzg_ypp_t00_average=smoothdata(fzg_ypp_t00);
% plot (smoothdata(fzg_ypp_t00));
% plot (fzg_ypp_t00);

for i=1:(anzahl/int)

    if fzg_ypp_t00_average(1,i*int) <0.25 && fzg_ypp_t00_average(1,i*int) >-0.25
        color_ypp = [0, 0.5020,0];                              %green
    end
        
    if fzg_ypp_t00_average(1,i*int) <0.75 && fzg_ypp_t00_average(1,i*int) >=0.25   
        color_ypp = [ 0.6039, 0.8039,0.1961];                   %yellowgreen
    end
    
    if fzg_ypp_t00_average(1,i*int) <1.25 && fzg_ypp_t00_average(1,i*int) >=0.75
        color_ypp = [1, 1, 0];                                   %yellow
    end
    
    if fzg_ypp_t00_average(1,i*int) <1.75 && fzg_ypp_t00_average(1,i*int) >=1.25
        color_ypp = [1, 0.6471, 0];                             %orange
    end
    
    if fzg_ypp_t00_average(1,i*int) <2.25 && fzg_ypp_t00_average(1,i*int) >=1.75
        color_ypp = [1, 0.2706, 0];                             %orangered
    end
    
    if fzg_ypp_t00_average(1,i*int) <2.75 && fzg_ypp_t00_average(1,i*int) >=2.25
        color_ypp = [1, 0, 0];                                  %red
    end
    
    if fzg_ypp_t00_average(1,i*int) >=2.75
        color_ypp = [0.5451, 0, 0];                             %darkred
    end 
    
 
    
    
    
    
        
    if fzg_ypp_t00_average(1,i*int) <=-0.25 && fzg_ypp_t00_average(1,i*int) >-0.75
        color_ypp = [0, 0.9804, 0.6039];                        %mediumspringgreen
    end
    
    if fzg_ypp_t00_average(1,i*int) <=-0.75 && fzg_ypp_t00_average(1,i*int) >-1.25
        color_ypp = [0.2510, 0.8784, 0.8157];                   %turquiose
    end
    
    if fzg_ypp_t00_average(1,i*int) <=-1.25 && fzg_ypp_t00_average(1,i*int) >-1.75
        color_ypp = [0.2745, 0.5098, 0.7059];                   %steelblue
    end
    
    if fzg_ypp_t00_average(1,i*int) <=-1.75 && fzg_ypp_t00_average(1,i*int) >-2.25
        color_ypp = [0, 0, 1];                                  %blue
    end
    
    if fzg_ypp_t00_average(1,i*int) <=-2.25 && fzg_ypp_t00_average(1,i*int) >-2.75
        color_ypp = [0.2941, 0, 0.5098];                        %indigo
    end
    
    if fzg_ypp_t00_average(1,i*int) <=-2.75
        color_ypp = [0.5020, 0, 0.5020];                        %purple
    end
    

   if i<(anzahl/int)
    plot(x(1,i:i+1),y(1,i:i+1),'Color',color_ypp,'LineWidth',3)
   else
    plot(x(1,i:(anzahl/int)),y(1,i:(anzahl/int)),'Color',color_ypp,'LineWidth',3)
   end

end

scatter (xEast(Ergebnis01_kM(28,:)),yNorth(Ergebnis01_kM(28,:)),20,'blue','filled')

daspect([1 1 20])
pbaspect([16 9 9])


saveas(fig,out,'fig')