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

graph_settings
clear, clc, close all

file_turb ='TGL_BLADE_PROFILE';
load(file_turb)                         % load turbine blade profile

NBsec = 100;                            % number of blade sections
r=linspace(rad(1),rad(end),NBsec);      % radial coordinate (m)
c=interp1(rad,c,r,'PCHIP');             % chord length (m)
R=r(end);


% control random generator
rng shuffle % new seed
seed=rng; % save seed for simulation


Ur=2.7; % Rated velocity !!!!
LAW=1/7; % power law for shear profile
TSR=4.5;
omega =TSR*Ur/R; % Rotor speed FIXED

Rotations = 100;
% PITCH CONTROL PARAMATERS (OFF IF ZERO)
P0=0;

%% RUN MULTIPLE CASES

U0=Ur;
parfor i=1:4


if i==1
% Turbulence with yaw:
Gamma=30; Hs=5; Tw=10; wd=deg2rad(0); WAVES=false; I=0.1; L=10; Ratio=1; TURB=true;
MyString='Turbulence with yaw';
Let = '(a)';
end

if i==2
% Waves with yaw:
Gamma=30; Hs=5; Tw=10; wd=deg2rad(0); WAVES=true; I=0.1; L=10; Ratio=1; TURB=false;
MyString='Waves with yaw';
Let = '(b)';
end

if i==3
% Waves with yaw and turbulence:
Gamma=30; Hs=5; Tw=10; wd=deg2rad(0); WAVES=true; I=0.1; L=10; Ratio=1; TURB=true;
MyString='Waves, yaw and turbulence';
Let = '(c)';
end

if i==4
% Waves with turbulence:
Gamma=0; Hs=5; Tw=10; wd=deg2rad(0); WAVES=true; I=0.1; L=10; Ratio=1; TURB=true;
MyString='Waves with turbulence';
Let = '(d)';
end


i    
    % POSSIBLE OUTPUTS  *****************
    % [t(:,i),Tr(i),Twr(i),P(:,i),T(:,i),Fsep(:,:,i),Vortex(:,:,i),FN(:,:,i),FTan(:,:,i),CMY(:,i),CMYqs(:,i),Wrel(:,:,i),LifCoef(:,:,i),ut(:,i),Phi(:,:,i),aoa(:,:,i)] .....
    % REQUIRED INPUTS  *****************
    ...= Full_model(U0,LAW,Rotations,Gamma,Hs(i),Tw(j),wd,WAVES,I,L,Ratio,TURB,omega,seed,P0);
    % ****************************************************************************************************

[t(:,i),Tr(i),Twr(i),~,~,F(:,:,i),V(:,:,i),~,~,~,~,Wrel(:,:,i),CL(:,:,i),~,~,~,] = Full_model(U0,LAW,Rotations,Gamma,Hs,Tw,wd,WAVES,I,L,Ratio,TURB,omega,seed,P0);


Label{i}=MyString;
G{i}=Let
end

%% SAVE DATA FOR FFT ETC

% % save data for refuced frequency calculation
% Tw=10;
% fileName='Combi_4';
% save(fileName,'Label','t','Tr','Twr','Tw','Wrel','CL')

%% MAKE BLADE PLOTS

% RATED VELOCITY
close all
r1=[25, 13, 0, 0];   % k=0.56
r2=[57, 44, 34, 11]; % k=0.2
r3=[42, 32, 21, 0];  % k=0.3
sep_conPlot_3(F,V,c,r,G,r1,r2,r3)
print('Blades','-depsc2','-r1000');




