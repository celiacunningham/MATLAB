
%% get the file names
if ismac
    ui.orig_folder=cd('/Volumes/'); % change the working directory
else
    ui.start_path='Z:\Technology\Polyimide\RTA thermocouples\historicals\';
    if isfolder(ui.start_path)
        ui.orig_folder=cd(ui.start_path);
    else
        ui.orig_folder=cd('C:\');
    end
end
[ui.file_names,ui.file_dirs,ui.filter_index]=uigetfile('.his','MultiSelect','off'); % prompt user for list of files
if ui.filter_index==0
    file_info(1).full_paths='';
    file_info(1).file_names='';
    disp('User selected cancel');
else
    if iscell(ui.file_names) % append directory to each file name
        for i=length(ui.file_names):-1:1
            file_info(i).full_paths=[ui.file_dirs ui.file_names{i}];
            [~,file_info(i).file_names,~]=fileparts(ui.file_names{i});
        end
    else
        file_info(1).full_paths=[ui.file_dirs ui.file_names];
        file_info(1).file_names=ui.file_names;
    end
end
cd(ui.orig_folder); % restore the original working directory


%% load the single .his file
if exist('log','var') % check if any cell data is already loaded
    disp('overwriting the existing file');
end
if ~strcmp('',file_info.full_paths)
        log.data=readtable(file_info.full_paths,...
            'FileType','text',...
            'HeaderLines',7,...
            'TextType','string',...
            'ReadVariableNames',1);
        log.file_names=file_info.file_names;
        log.paths=file_info.full_paths;
    disp('load complete');
end