% Dieses Skript sucht sich alle einzelnen Ergebnis-Matrizen, die am definierten Speicherort dem
% festgelegten Namen entsprechen und fuegt die zu einem "struct" zusammen
% mit dem Namen "allData". Zusaetzlich wird die zusammengefuehrte
% Ergebnismatrix unter dem Namen "AddData_Kruemmung" als .mat-File abgespeichert



FileList = dir(fullfile('F:\Eigene Dateien\01_Tu Braunschweig\IfF\Masterarbeit\05_Datenauswertung\Auswerteskripte\Curvefitting\Skripte', 'Ergebnis_Kr*.mat'));  % List of all MAT files
allData  = struct();
for iFile = 1:numel(FileList)               % Loop over found files
  Data   = load(fullfile('F:\Eigene Dateien\01_Tu Braunschweig\IfF\Masterarbeit\05_Datenauswertung\Auswerteskripte\Curvefitting\Skripte', FileList(iFile).name));
  Fields = fieldnames(Data);
  for iField = 1:numel(Fields)              % Loop over fields of current file
    aField = Fields{iField};
    if isfield(allData, aField)             % Attach new data:
       allData.(aField) = [allData.(aField), Data.(aField)];
       
    else
       allData.(aField) = Data.(aField);
    end
  end
end
save(fullfile('F:\Eigene Dateien\01_Tu Braunschweig\IfF\Masterarbeit\05_Datenauswertung\Auswerteskripte\Curvefitting\Skripte', 'AllData_Kruemmung.mat'), '-struct', 'allData');