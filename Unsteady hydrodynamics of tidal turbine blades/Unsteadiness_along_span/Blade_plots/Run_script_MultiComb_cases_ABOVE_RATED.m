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


% Run model for different wave cases and save mean and standard deviation
% of the root bending moment for both unsteady and quasi-steady cases.

% The script changes:

% tip-speed ratio
% wave period
% wave height
% wave direction


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

% % control random generator
% rng shuffle % new seed
% seed=rng; % save seed for simulation

load RandomSeed % load random generator for repeatability

Ur=2.7; % Rated velocity !!!!
LAW=1/7; % power law for shear profile
TSR=4.5;
omega =TSR*Ur/R; % Rotor speed FIXED
Rotations = 100;
% Wave parameters
Hs=5; Tw=10; wd=deg2rad(0);

U0=3.2; % Free stream velocity
% PITCH CONTROL PARAMATERS (OFF IF ZERO)
P0=4.623;
% Turbulence parameters
I=0.1; L=10; Ratio=1;



%% RUN MULTIPLE CASES

parfor i=1:4

if i==1
% Turbulence with yaw:
Gamma=30; WAVES=false; TURB=true;
MyString='Turbulence with yaw';
Let = '(a)';
end

if i==2
% Waves with yaw:
Gamma=30; WAVES=true; TURB=false;
MyString='Waves with yaw';
Let = '(b)';
end

if i==3
% Waves with yaw and turbulence:
Gamma=30; WAVES=true; TURB=true;
MyString='Waves, yaw and turbulence';
Let = '(c)';
end

if i==4
% Waves with turbulence:
Gamma=0; WAVES=true; TURB=true;
MyString='Waves with turbulence';
Let = '(d)';
end


i    
    % POSSIBLE OUTPUTS  *****************
    % [t(:,i),Tr(i),Twr(i),P(:,i),T(:,i),Fsep(:,:,i),Vortex(:,:,i),FN(:,:,i),FTan(:,:,i),CMY(:,i),CMYqs(:,i),Wrel(:,:,i),LifCoef(:,:,i),ut(:,i),Phi(:,:,i),aoa(:,:,i)] .....
    % REQUIRED INPUTS  *****************
    ...= Full_model(U0,LAW,Rotations,Gamma,Hs(i),Tw(j),wd,WAVES,I,L,Ratio,TURB,omega,seed,P0);
    % ****************************************************************************************************

    [t(:,i),Tr(i),Twr(i),~,~,F(:,:,i),V(:,:,i),~,~,~,~,Wrel(:,:,i),CL(:,:,i),~,~,~,~,~] = Full_model(U0,LAW,Rotations,Gamma,Hs,Tw,wd,WAVES,I,L,Ratio,TURB,omega,seed,P0);


Label{i}=MyString;
G{i}=Let
end



%% SAVE DATA FOR FFT ETC

% % save data for refuced frequency calculation
% Tw=10;
% fileName='Combi_4_AbvRated';
% save(fileName,'Label','t','Tr','Twr','Tw','Wrel','CL')

%% MAKE BLADE PLOTS

% ABOVE RATED VELOCITY
close all
F(100,:,:)=1;
r1=[21, 11, 0, 0];  % k=0.56
r2=[57, 44, 32, 0]; % k=0.2
r3=[41, 30, 20, 0]; % k=0.3
sep_conPlot_3(F,V,c,r,G,r1,r2,r3)
print('BladesR','-depsc2','-r1000');






