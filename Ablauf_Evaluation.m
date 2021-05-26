%% Dieses Skript dient zur Evaluation einzelner Kurven durch den Vergleich von realer Fahrdaten mit Simulierten

% als erstes muss eine geeignete Kurve aus dem einzelnen Ergebnisvektor
% gesucht werden (durchgaengige Markierungserkennung und Querablage) die
% entsprechende Spalte wird fuer 'n' eingetragen. 
% Anschließend wird der aufgezeichnete gemittelte Kruemmungsverlauf der Spurmarkierung
% und der Geschwindigkeitsverlauf aufbereitet (um das Einschwingen des Einspurmodells
% zu umgehen, werden jeweils 20 Sekunden vor den aufgezeichneten Daten eingefügt 
% die einen relativ geraden Abschnitt darstellen der mit einer konstanten 
% Geschwindigkeit befahren wird) und als Eingangsgroessen fuer
% ein Einspurmodell verwendet, das daraus u.a. die Querbeschleunigung
% berechnet. (Da die gemittelte Kruemmung der Spurmarkierung exakt der
% Fahrspurmitte entspricht kann diese als Solltrajektorie angesehen werden)
% Eine anschliessende Rueckumwandlung des Lenkwinkels und des
% Schwimmwinkels in Koordinaten mithilfe des Simulinkmodells 'Gierwinkel_Schwimmwinkel_
% zu_Koordinaten' zeigt, dass die simulierte Kurve der Originalen aehnelt.
% (Die originale wurde allerdings durch GPS-Daten aufgezeichnet und verlief
% nicht dauerhaft in der Spurmitte, deshalb koennen kleine Abweichungen
% vorhanden sein). Die Erhaltenen x- und y-Koordinaten werden mit der
% errechneten Querablage beaufschlagt, um so den tatsaechlichen Verlauf der
% Durchfahrt darstellen zu koennen. Aus dieser wird mithilfe der Funktion
% 'curvature' der Radien- und Kruemmungsverlauf der tatsaechlichen
% Durchfahrt berechnet, der dann wiederum erneut mit dem ESM simuliert wird
% um die tatsaechlichen Querbeschleunigungen simulieren zu koennen.

n=19;

%Das Skript Evaluation:
%1. bereitet die realen Fahrdaten fuer das ESM vor (fuegt 20 Sekunden konstante Fahrt vor den Daten ein, um das Schwingen des ESM zu neutralisieren)
%2. fuehrt ESM aus (speichert Querbeschleunigung der Solldurchfahrt)
%3. erstellt Koordinaten aus der Durchfahrt
Evaluation

%Das Skript Querablagenkoordinaten berechnet die Koordniaten der Istkurve,
%in dem die Sollkoordinaten aus dem ESM mit der gemessenen Querablage
%beaufschlagt werden
Querablagenkoordinaten


%Diese Funktion berechnet aus den Querablagenkoordinaten einen Radien-,
%Kruemmungsverlauf und die Bogenlaenge
L=[];
R=[];
K=[];
[L,R,K]=curvature(XY_qab);



%Radienverlauf wird geglaettet
R_smoothed=[];
R_smoothed=smooth(R,100); 
% R_smoothed=R;

%Dieses Skript Simuliert den berechneten Kruemmungsverlauf der
%Querablagendurchfahrt erneut mit dem ESM um die unterschiedlichen
%Querbeschleunigungen aufzuzeigen
Evaluation_Querablage

disp('Ende')
