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


% Script to run 8 different flow combinations.


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

Ur=2.7; % Rated velocity !!!!
LAW=1/7; % power law for shear profile

% % control random generator
% rng shuffle % new seed
% seed=rng; % save seed for simulation

load RandomSeed % load random generator for repeatability

TSR=4.5;
omega =TSR*Ur/R; % Rotor speed FIXED

Rotations = 50;
% PITCH CONTROL PARAMATERS (OFF IF ZERO)
P0=0;

% TURBULENCE
I=0.1; L=10; Ratio=1; 

%% RUN MULTIPLE CASES

parfor i=1:8

if i==1
% Shear:
Gamma=0; Hs=5; Tw=10; wd=deg2rad(0); WAVES=false;TURB=false;
MyString='Shear';
end

if i==2
% Yaw:
Gamma=30; Hs=5; Tw=10; wd=deg2rad(0); WAVES=false; TURB=false;
MyString='Yaw';
end

if i==3
% Turbulence:
Gamma=0; Hs=5; Tw=10; wd=deg2rad(0); WAVES=false; TURB=true;
MyString='Turbulence';
end

if i==4
% Waves:
Gamma=0; Hs=5; Tw=10; wd=deg2rad(0); WAVES=true; TURB=false;
MyString='Waves';
end

if i==5
% Turbulence with yaw:
Gamma=30; Hs=5; Tw=10; wd=deg2rad(0); WAVES=false; TURB=true;
MyString='Turbulence with yaw';
end

if i==6
% Waves with yaw:
Gamma=30; Hs=5; Tw=10; wd=deg2rad(0); WAVES=true; TURB=false;
MyString='Waves with yaw';
end

if i==7
% Waves with turbulence:
Gamma=0; Hs=5; Tw=10; wd=deg2rad(0); WAVES=true; TURB=true;
MyString='Waves with turbulence';
end

if i==8
% Waves with yaw and turbulence:
Gamma=30; Hs=5; Tw=10; wd=deg2rad(0); WAVES=true; TURB=true;
MyString='Waves with yaw and turbulence';
end
i    
    % POSSIBLE OUTPUTS  *****************
    % [t(:,i),Tr(i),Twr(i),P(:,i),T(:,i),Fsep(:,:,i),Vortex(:,:,i),FN(:,:,i),FTan(:,:,i),CMY(:,i),CMYqs(:,i),Wrel(:,:,i),LifCoef(:,:,i),ut(:,i),Phi(:,:,i),aoa(:,:,i)] .....
    % REQUIRED INPUTS  *****************
    ...= Full_model(U0,LAW,Rotations,Gamma,Hs(i),Tw(j),wd,WAVES,I,L,Ratio,TURB,omega,seed,P0);
    % ****************************************************************************************************

    
[t(:,i),Tr(i),Twr(i),~,~,~,~,FN(:,:,i),~,CMY(:,i),~,Wrel(:,:,i),CL(:,:,i),ut(:,i),~,~] = Full_model(Ur,LAW,Rotations,Gamma,Hs,Tw,wd,WAVES,I,L,Ratio,TURB,omega,seed,P0);

Label{i}=MyString;
end


ut=ut(:,8)+U0;
fileName='Multi_cases_8';
save(fileName,'Label','t','Tr','Twr','FN','CMY','Wrel','CL','ut')



