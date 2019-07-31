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

% Turbulence and yaw fixed

% The script changes:

% wave period
% wave height

graph_settings
clear, clc, close all

file_turb ='TGL_TURBINE';
load(file_turb)                         % load turbine blade profile

NBsec = 100;                            % number of blade sections
r=linspace(rad(1),rad(end),NBsec);      % radial coordinate (m)
c=interp1(rad,c,r,'PCHIP');             % chord length (m)
R=r(end);

Ur=2.7; % Rated velocity !!!!
LAW=1/7; % power law for shear profile
Gamma=30;

Hs=1:0.2:6;            % Significant wave height (m)
Tw=2:0.2:12;           % Apparant wave period (s)
WD=0;   % Wave direction (deg)
wd=deg2rad(WD);         % Wave direction (rad)
WAVES = true;

TURB = true;
Ratio=1;                % Component turbulence intensity ratio 1 = isotropic
I=0.1;                    % Streamwise turbulence intensity
L=10;                    % Turbulent length scale

% control random generator
%rng shuffle % new seed
%seed=rng; % save seed for simulation

load RandomSeed

TSR=4.5;
omega =TSR*Ur/R; % Rotor speed FIXED

Rotations = 50;
% PITCH CONTROL PARAMATERS (OFF IF ZERO)
P0=0;


for hh=1:length(wd)


for j=1:length(Hs)


parfor i=1:length(Tw)
    
    % POSSIBLE OUTPUTS  *****************
    % [t(:,i),Tr(i),Twr(i),P(:,i),T(:,i),Fsep(:,:,i),Vortex(:,:,i),FN(:,:,i),FTan(:,:,i),CMY(:,i),CMYqs(:,i),Wrel(:,:,i),LifCoef(:,:,i),ut(:,i),Phi(:,:,i),aoa(:,:,i)] .....
    % REQUIRED INPUTS  *****************
    ...= Full_model(U0,LAW,Rotations,Gamma,Hs(i),Tw(j),wd,WAVES,I,L,Ratio,TURB,omega,seed,P0);
    % ****************************************************************************************************

    [~,~,~,~,~,~,~,~,~,CMY(:,i),CMYqs(:,i),~,~,~,~,~] = Full_model(Ur,LAW,Rotations,Gamma,Hs(j),Tw(i),wd,WAVES,I,L,Ratio,TURB,omega,seed,P0);
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

fileName='CombPlotData_gamma_30';
save(fileName)



