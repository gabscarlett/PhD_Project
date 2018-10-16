%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                                                 %%%
%%%       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     %%%
%%%       %%%%%% Written by Gabriel Scarlett August 2018 %%%%%%     %%%
%%%       %%%%%%     The University of Edinburgh, UK     %%%%%%     %%%
%%%       %%%%%%         School of Engineering           %%%%%%     %%%
%%%       %%%%%%       Institute for Energy Systems      %%%%%%     %%%
%%%       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     %%%
%%%                                                                 %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Run model for different once per revolution flow conditions 

% Outputs the mean and standard deviation of the root mending moment for both unsteady and quasi-steady cases.

% The script loops over:

% freestream velocity
% tip-speed ratio
% yaw angle

% ASSIGN PATHS TO FUNCTIONS AND DATA: WORK PC
path(path,genpath('\Users\s1040865\Dropbox\PhD\Modelling\Programs\Matlab\Working_Folder_April_2018\PATH\functions')); % Functions
path(path,genpath('\Users\s1040865\Dropbox\PhD\Modelling\Programs\Matlab\Working_Folder_April_2018\PATH\data')); % Input data
path(path,genpath('\Users\s1040865\Dropbox\PhD\Modelling\Programs\Matlab\Working_Folder_April_2018\PATH\Saved_Simulation_data')); % Saved simulation data

% ASSIGN PATHS TO FUNCTIONS AND DATA: HOME W520
path(path,genpath('\Users\gabsc\Dropbox\PhD\Modelling\Programs\Matlab\Working_Folder_April_2018\PATH\functions')); % Functions
path(path,genpath('\Users\gabsc\Dropbox\PhD\Modelling\Programs\Matlab\Working_Folder_April_2018\PATH\data')); % Input data
path(path,genpath('\Users\gabsc\Dropbox\PhD\Modelling\Programs\Matlab\Working_Folder_April_2018\PATH\Saved_Simulation_data')); % Saved simulation data

% ASSIGN PATHS TO FUNCTIONS AND DATA: WORK MACPRO
path(path,genpath('/Users/s1040865/Dropbox/PhD/Modelling/Programs/Matlab/Working_Folder_April_2018/PATH/functions')); % Function path
path(path,genpath('/Users/s1040865/Dropbox/PhD/Modelling/Programs/Matlab/Working_Folder_April_2018/PATH/data')); % Data path
path(path,genpath('/Users/s1040865/Dropbox/PhD/Modelling/Programs/Matlab/2018/Working_Folder_April_2018/Saved_Simulation_data')); % Saved simulation data

graph_settings
clear, clc, close all

file_turb ='TGL_BLADE_PROFILE';
load(file_turb)                         % load turbine blade profile

NBsec = 100;                            % number of blade sections
r=linspace(rad(1),rad(end),NBsec);      % radial coordinate (m)
c=interp1(rad,c,r,'PCHIP');             % chord length (m)
R=r(end);

U0=1.5:0.1:3.5;
Gamma=0:10:50;
Hs=0;
Tw=0;
wd=0;
WAVES = false;
LAW=1/7;

TURB = false;
Ratio=1;
I=0;
L=0;
% control random generator
rng shuffle % new seed
seed=rng; % save seed for simulation

TSR=3:0.1:7;

Rotations = 5;
% PITCH CONTROL PARAMATERS (OFF IF ZERO)
P0=0;

for hh=1:length(Gamma)
    
for j=1:length(TSR)

    tsr=TSR(j);
parfor i=1:length(U0)
    
    omega=tsr.*U0(i)/R;

    % POSSIBLE OUTPUTS  *****************
    % [t(:,i),Tr(i),Twr(i),P(:,i),T(:,i),Fsep(:,:,i),Vortex(:,:,i),FN(:,:,i),FTan(:,:,i),CMY(:,i),CMYqs(:,i),Wrel(:,:,i),LifCoef(:,:,i),ut(:,i),Phi(:,:,i),aoa(:,:,i)] .....
    % REQUIRED INPUTS  *****************
    ...= Full_model(U0,LAW,Rotations,Gamma,Hs(i),Tw(j),wd,WAVES,I,L,Ratio,TURB,omega,seed,P0);
    % ****************************************************************************************************

[~,~,~,~,~,~,~,~,~,CMY(:,i),CMYqs(:,i),~,~,~,~,~] = Full_model(U0(i),LAW,Rotations,Gamma(hh),Hs,Tw,wd,WAVES,I,L,Ratio,TURB,omega,seed,P0);
[i, j, hh]

% Unsteady mean and standard deviation
CMyAmp(j,i,hh)=nanstd(CMY(:,i));
CMyMean(j,i,hh)=nanmean(CMY(:,i));

% Quasi-steady mean and standard deviation
CMyAmpQS(j,i,hh)=nanstd(CMYqs(:,i));
CMyMeanQS(j,i,hh)=nanmean(CMYqs(:,i));

end

end


end

fileName='YawPlotData';
save(fileName,'CMyAmp','CMyAmpQS','CMyMean','CMyMeanQS','TSR','U0','Gamma')


