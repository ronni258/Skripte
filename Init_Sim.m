%% ===== Erweitertes Einspurmodell ====
% Felix Tigges
% Institut für Fahrzeugtechnik
% TU Braunschweig
% 26.01.2016
% Einspurmodell wurde um Wankdynamik, dynamische Radlasten und Pacejka MF 5.2 für reinen Seitenschlupf erweitert
% Einspurmodell enthält keine Längsdynamik
%% ========================================
% clear all
clc

%% === Fahrzeugparameter laden ===
load('Polo_erweitertesESM.mat');

% === Modellparameter ===
FZGpars.m    = 1400;                        % Fahrzeugmasse [kg]
FZGpars.Jz   = 1700;                        % Fahrzeugträgheit [kgm²]
FZGpars.l    = 2.5;                         % Radstand [m]
FZGpars.lv_l = 0.5;                         % SP-Lage VA
FZGpars.lv = FZGpars.lv_l *FZGpars.l;
FZGpars.lh = FZGpars.l-FZGpars.lv;          % SP-Lage HA
FZGpars.il = 15;                            % Lenkübersetzung

FZGpars.Fz_0V = FZGpars.m*9.81*FZGpars.lv_l*0.5;
FZGpars.Fz_0H = FZGpars.Fz_0V;
FZGpars.c2V=0.288;
FZGpars.CyV=1.35;


FZGpars.ch = FZGpars.cv;

FZGpars.muy_0H=FZGpars.muy_0V;
FZGpars.CyH=FZGpars.CyV;
FZGpars.c1H=FZGpars.c1V;
FZGpars.c2H=FZGpars.c2V;
FZGpars.c5H=FZGpars.c5V;
FZGpars.Dy_0H=FZGpars.Dy_0V;
FZGpars.EyH=FZGpars.EyV;

FZGpars.CFalpha0V=FZGpars.c1V*FZGpars.c2V*FZGpars.Fz_0V*sin(2*atan(1/FZGpars.c2V));
FZGpars.CFalpha0H=FZGpars.CFalpha0V;
FZGpars.sigma_alphaH = FZGpars.sigma_alpha;

%elastische Lenkung
FZGpars.nv=0.05;                            % Nachlauf [m]
FZGpars.CL=20000;                          % Lenkungssteifigkeit [Nm/rad]
FZGpars.VL=3; 

%neue Parameter fürs Buch, Wanken realistischer
FZGpars.Jx = 500;
FZGpars.mv = 30;
FZGpars.mh = 30;
FZGpars.pv = 0.13;
FZGpars.ph = 0.15;
FZGpars.hs = 0.25;

%% === Fahrmanöverdefinition ===
%Eingangsgrößen ===
deltal_max = 180/180*pi;        % maximaler Lenkwinkel [rad] bei Lenkwinkelsprung
% v_max = 50/3.6;                % Fahrgeschwindigkeit konstant [m/s]
% rho_soll = 100; % Radius der Kurve
% rho_soll(:,1)=(1:size(PATH.kappa(2:end-1),2));
% rho_soll(:,2)=(1./PATH.kappa(2:end-1))';
% 
% tsim= 100;                       %Simulationsdauer


%% === Simulation erweitertes ESM starten ===

sim('esm_wanken.slx');

%% === Simulation lineares Einspurmodell ===

% FZGpars.cah = 120000;      % Seitensteifigkeit HA und VA [N/rad]
% FZGpars.cav = FZGpars.cah;
% sim('esm_wanken_linear.slx');


%% === Postprocessing ===
% groesse=10;
% 
% figure(111);
% hold all
% 
% hp = plot(simout.signals.values(:,1)/9.81,[simin.signals.values(:,1)*180/pi]); set(hp,'LineWidth',2);
% xlabel('Querbeschleunigung b [g]','FontSize',groesse); 
% ylabel('Lenkwinkel [°]', 'FontSize',groesse);
% set(gca,'FontSize',groesse)
% xlim([0.1 0.8]); ylim([20 80]); grid on;hold on;
% 
% figure(222)
% hp = plot(simout.signals.values(:,1)/9.81,simout.signals.values(:,7)*180/pi);  set(hp,'LineWidth',2); h_legend=legend('c_{\alpha}=120000N/rad','c_{\alpha}=80000N/rad','c_{\alpha}=160000N/rad'); set(h_legend, 'FontSize',groesse);
% xlabel('Querbeschleunigung b [g]','FontSize',groesse); 
% ylabel('Radlenkwinkel [°]','FontSize',groesse); 
% set(gca,'FontSize',groesse)
% ylim([0 3]); 
% grid on; hold on
% xlim([0.1 0.8]); ylim([0 5]); grid on;hold on;
% 
% figure(333)
% hp = plot(simout.signals.values(:,1)/9.81,simout.signals.values(:,3)*180/pi);  set(hp,'LineWidth',2);
% xlabel('Querbeschleunigung b [g]','FontSize',groesse);
% ylabel('Beta [°]','FontSize',groesse);
% set(gca,'FontSize',groesse)
% ylim([0 15]);
% grid on;hold on
% xlim([0.1 0.8]); ylim([-6 1]); grid on;hold on;
% 
% figure(444)
% hp = plot(simout.signals.values(:,1)/9.81,simout.signals.values(:,6));  set(hp,'LineWidth',2);
% xlabel('Querbeschleunigung b [g]','FontSize',groesse);
% ylabel('Lenkmoment [Nm]','FontSize',groesse); 
% set(gca,'FontSize',groesse)
% ylim([-1.5 0.5]); 
% grid on;hold on
% xlim([0.1 0.8]); ylim([0 7]); grid on;hold on;
% set(gcf,'Color','w');
% 
% 
% figure(555)
% hp = plot(simout.signals.values(:,1)/9.81, [simout.signals.values(:,4)*180/pi,  simout.signals.values(:,5)*180/pi]);  set(hp,'LineWidth',2);
% xlabel('Querbeschleunigung b [g]','FontSize',groesse);
% ylabel('Alpha [°]','FontSize',groesse);
% set(gca,'FontSize',groesse)
% ylim([0 15]);
% grid on;hold on
% xlim([0.1 0.8]); ylim([0 5]); grid on;hold on;
