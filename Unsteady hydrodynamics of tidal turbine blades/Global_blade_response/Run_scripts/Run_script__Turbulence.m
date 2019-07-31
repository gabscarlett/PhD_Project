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

% Run model for different turbulent flow conditions 

% Outputs the mean and standard deviation of the root mending moment for both unsteady and quasi-steady cases.

% The script loops over:

% turbulent ratio (isotropic or anisptropic)
% turbulent intensity
% turbulent length scale

% OPERATING AT RATED VELOCITY AND OPTIMUM TIP-SPEED RATIO

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
Gamma=0;
Hs=0;
Tw=0;
wd=0;
WAVES = false;

TURB = true;
Ratio=1:-0.1:0.5;
I=0.05:0.005:0.2;
L=5:0.2:30;
% control random generator
rng shuffle % new seed
seed=rng; % save seed for simulation



TSR=4.5;
omega =TSR*Ur/R; % Rotor speed FIXED

Rotations = 5;
% PITCH CONTROL PARAMATERS (OFF IF ZERO)
P0=0;


for hh=1:length(Ratio)


for j=1:length(L)


parfor i=1:length(I)

    % POSSIBLE OUTPUTS  *****************
    % [t(:,i),Tr(i),Twr(i),P(:,i),T(:,i),Fsep(:,:,i),Vortex(:,:,i),FN(:,:,i),FTan(:,:,i),CMY(:,i),CMYqs(:,i),Wrel(:,:,i),LifCoef(:,:,i),ut(:,i),Phi(:,:,i),aoa(:,:,i)] .....
    % REQUIRED INPUTS  *****************
    ...= Full_model(U0,LAW,Rotations,Gamma,Hs(i),Tw(j),wd,WAVES,I,L,Ratio,TURB,omega,seed,P0);
    % ****************************************************************************************************

[~,~,~,~,~,~,~,~,~,CMY(:,i),CMYqs(:,i),~,~,~,~,~] = Full_model(Ur,LAW,Rotations,Gamma,Hs,Tw,wd,WAVES,I(i),L(j),Ratio(hh),TURB,omega,seed,P0);
[i,j,hh]

% Unsteady mean and standard deviation
CMyAmp(j,i,hh)=nanstd(CMY(:,i));
CMyMean(j,i,hh)=nanmean(CMY(:,i));

% Quasi-steady mean and standard deviation
CMyAmpQS(j,i,hh)=nanstd(CMYqs(:,i));
CMyMeanQS(j,i,hh)=nanmean(CMYqs(:,i));

end

end

end

fileName='TurbPlotData';
save(fileName,'CMyAmp','CMyAmpQS','CMyMean','CMyMeanQS','TSR','I','L','Ratio')



