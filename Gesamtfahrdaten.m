failedFiles={};
FileList = dir(fullfile('D:\Messdaten\040_Volkswagen_Passat_WOB_OQ_616\Landstraße', '*.mat'));  % List of all MAT files
allData  = struct();
Geschwindigkeit=[zeros(1,90002)];
for iFile = 1:numel(FileList)               % Loop over found files
%try
    Data   = load(fullfile('D:\Messdaten\040_Volkswagen_Passat_WOB_OQ_616\Landstraße', FileList(iFile).name));
    currentFile=FileList(iFile);%%%%%%%%%%%%%%TEST ob der Name bei den FailedFiles auftaucht
    %% Definition von variablen Randbedingungen
iFile

Geschwindigkeit(iFile,1:size(Data.fzg_xp_t00,2))=Data.fzg_xp_t00;
Distanz(iFile,1)=Data.fzg_x_t00(1,size(Data.fzg_x_t00,2));


%catch
    %continue

%end
end
Durchschnittgeschwindigkeit=mean(Geschwindigkeit,'all');
Gesamtfahrstrecke=sum(Distanz);