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

% plot script : CALLS multi_pcolor and plots multifigures for wave, yaw and
% turbulence cases.

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

%% YAW PLOT

load YawPlotData_NEW

CMyAmp_R=CMyAmp./CMyAmpQS;
Mean_Ratio=CMyMean./CMyMeanQS;


x='$$\lambda$$';
y='$$U_0$$ [ms$$^{-1}$$]';
z='$$\sigma_{C_{M_y}}$$';

Range=[0,0.06];
labels={x,y,z};
t0='$$\gamma =0^{\circ}$$';
t1='$$\gamma =10^{\circ}$$';
t2='$$\gamma =20^{\circ}$$';
t3='$$\gamma =30^{\circ}$$';
t4='$$\gamma =40^{\circ}$$';
t5='$$\gamma =50^{\circ}$$';
titles={t0,t1,t2,t3,t4,t5};
l1='$$\Delta\bar{C}_{M_y}>0\%$$';
l2='$$\Delta\bar{C}_{M_y}>5\%$$';
l3='$$\Delta\bar{C}_{M_y}>10\%$$';
Leg={l1,l2,l3};
dir ='southeast';
Multi_pcolor_yaw(TSR,U0,CMyAmp,Mean_Ratio,Range,labels,titles,Leg,true,dir);
print('1P','-depsc2','-r1000');

%% TURBULENCE PLOT
load TurbPlotData

CMyAmp = permute(conj(CMyAmp),[2 1 3]);
CMyMean = permute(conj(CMyMean),[2 1 3]);
CMyAmpQS = permute(conj(CMyAmpQS),[2 1 3]);
CMyMeanQS = permute(conj(CMyMeanQS),[2 1 3]);

CMyAmp_R=CMyAmp./CMyAmpQS;
Mean_Ratio=CMyMean./CMyMeanQS;

I=I*100;


x='$$I_x$$ \rm [\%]';
y='$$L_x$$ \rm [m]';
z='$$\sigma_{C_{M_y}}$$';

Range=[0,0.06];
labels={x,y,z};
t0='$$R_{t} =1$$';
t1='$$R_{t} =0.9$$';
t2='$$R_{t} =0.8$$';
t3='$$R_{t} =0.7$$';
t4='$$R_{t} =0.6$$';
t5='$$R_{t} =0.5$$';
titles={t0,t1,t2,t3,t4,t5};
l1='$$\Delta\bar{C}_{M_y}>0\%$$';
l2='$$\Delta\bar{C}_{M_y}>5\%$$';
l3='$$\Delta\bar{C}_{M_y}>10\%$$';
Leg={l1,l2,l3};
dir ='northwest';
Multi_pcolor_turb(I,L,CMyAmp,Mean_Ratio,Range,labels,titles,Leg,true,dir);
print('Turb','-depsc2','-r1000');

%% WAVES PLOT
load WavePlotData

CMyAmp = fillmissing(CMyAmp,'nearest');
CMyAmpQS = fillmissing(CMyAmpQS,'nearest');
CMyMean = fillmissing(CMyMean,'nearest');
CMyMeanQS = fillmissing(CMyMeanQS,'nearest');

CMyAmp_R=CMyAmp./CMyAmpQS;
Mean_Ratio=CMyMean./CMyMeanQS;

x='$$T_a$$ \rm [s]';
y='$$H_s$$ \rm [m]';
z='$$\sigma_{C_{M_y}}$$';

Range=[0,0.06];
labels={x,y,z};


t0='$$\theta =0$$';
t1='$$\theta =\frac{\pi}{5}$$';
t2='$$\theta =\frac{2\pi}{5}$$';
t3='$$\theta =\frac{3\pi}{5}$$';
t4='$$\theta =\frac{4\pi}{5}$$';
t5='$$\theta =\pi$$';

titles={t0,t1,t2,t3,t4,t5};
l1='$$\Delta\bar{C}_{M_y}>0\%$$';
l2='$$\Delta\bar{C}_{M_y}>5\%$$';
l3='$$\Delta\bar{C}_{M_y}>10\%$$';
Leg={l1,l2,l3};
dir ='northwest';
Multi_pcolor_wave(Tw,Hs,CMyAmp,Mean_Ratio,Range,labels,titles,Leg,true,dir);
print('Wave','-depsc2','-r1000');
