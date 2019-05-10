% STATE_initialize
% Add the codebase, project secific code, cd to data, and initialize the global variables 



%% Add the codebase

close all
restoredefaultpath
global PARAMS

if isunix
    PARAMS.data_dir = '/Volumes/Fenrir/State_dep'; % where to find the raw data
    PARAMS.inter_dir = '/Volumes/Fenrir/State_dep/Temp/'; % where to put intermediate files
    PARAMS.stats_dir = '/Volumes/Fenrir/State_dep/Stats/'; % where to put the statistical output .txt
    PARAMS.code_base_dir = '/Users/jericcarmichael/Documents/GitHub/vandermeerlab/code-matlab/shared'; % where the codebase repo can be found
    PARAMS.code_state_dir = '/Users/jericcarmichael/Documents/GitHub/EC_State'; % where the multisite repo can be found
    PARAMS.ft_dir = '/Users/jericcarmichael/Documents/GitHub/fieldtrip'; % if needed. 
    PARAMS.filter_dir = '/Volumes/Fenrir/State_dep/Filters/'; % stores custom built filters for speed.  
else
%     PARAMS.data_dir = 'G:\Multisite\'; % where to find the raw data
%     PARAMS.inter_dir = 'G:\Multisite\temp\'; % where to put intermediate files
%     PARAMS.stats_dir = 'G:\Multisite\temp\Stats\'; % where to put the statistical output .txt
%     PARAMS.code_base_dir = 'D:\Users\mvdmlab\My_Documents\GitHub\vandermeerlab\code-matlab\shared'; % where the codebase repo can be found
%     PARAMS.code_MS_dir = 'D:\Users\mvdmlab\My_Documents\GitHub\EC_Multisite'; % where the multisite repo can be found
end
% log the progress
PARAMS.log = fopen([PARAMS.inter_dir 'STATE_log.txt'], 'w');
% define subjects, phases, 
PARAMS.Phases = {'pre', 'burst', 'stim', 'post'}; % recording phases within each session
PARAMS.Subjects = {'M13', 'M14'}; %list of subjects
PARAMS.all_sites = {'vStr', 'dStr', 'Ctrx'}; 
PARAMS.Good_cells = {'M13_2018_12_09_TT1_05_OK',...
    'M13_2018_12_09_TT6_01_OK',...
    'M13_2018_12_09_TT8_01_OK',...
    'M13_2018_12_11_TT7_01_OK',...
    'M13_2018_12_11_TT7_02_OK',...
    'M13_2018_12_16_TT3_02_OK',...
    'M13_2018_12_17_TT2_02_Good',...
    'M14_2018_12_01_TT3_02_OK',...
    'M14_2018_12_08_TT1_04_Good',...
    'M14_2018_12_09_TT8_02_OK',...
    'M14_2018_12_10_TT1_02_Good',...
    'M14_2018_12_10_TT2_01_Good',...
    'M14_2018_12_10_TT2_02_Good',...
    'M14_2018_12_15_TT1_03_OK',...
    'M14_2018_12_17_TT2_01_OK',...
    'M16_2019_02_16_TT5_01_Great',...
    'M16_2019_02_16_TT7_01_Good',...
    'M16_2019_02_18_TT4_01_Good',...
    'M16_2019_02_17_TT7_01_Good',...
    'M16_2019_02_20_TT5_01_Good',...
    'M16_2019_02_22_TT8_01_Good',...
    'M16_2019_02_23_TT4_01_Good',...
    'M16_2019_02_25_TT1_01_Good',...
    'M16_2019_02_27_TT5_01_Good',...
    'M17_2019_02_15_TT3_02_OK',...
    'M17_2019_02_18_TT5_02_OK',...
    'M17_2019_02_19_TT5_01_OK',...
    'M17_2019_02_20_TT5_01_Good',...
    'M18_2019_04_10_TT4_01_Good',...
    'M18_2019_04_11_TT7_01_Good',...
    'M18_2019_04_12_TT4_02_Good',...
    'M18_2019_04_12_TT7_01_Good',...
    'M18_2019_04_13_TT6_02_OK',...
    'M18_2019_04_14_TT3_01_Good',...
    'M19_2019_04_12_TT7_01_OK',...
    'M19_2019_04_13_TT3_01_OK',...
    'M19_2019_04_13_TT2_01_OK',...
    'M19_2019_04_14_TT8_01_OK',...
    'M19_2019_04_14_TT5_01_Good',...
    };



rng(11,'twister') % for reproducibility


% add the required code
addpath(genpath(PARAMS.code_base_dir));
addpath(genpath(PARAMS.code_state_dir));
cd(PARAMS.data_dir) % move to the data folder

