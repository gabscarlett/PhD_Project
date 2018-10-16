% ASSIGN PATHS TO FUNCTIONS AND DATA: WORK PC
% Unsteady lift coefficient given by Theodorsen for a section near the tip of the blade. The static linear value is shown for comparison.

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

% analytical analysis 

%% THEODORSEN

%% LOEWY

Ff=1/10;  % 10 s wave frequency 

Fr=1/4.6; % rotational frequency

Fff=2*Fr;  % twice rotational frequency


M=Ff/Fr;
F=Ff;

a0 =deg2rad(4);
c= 0.8;
U=2.7;
W=7;
ui=0.3*U;
Blades=3;

k1=2*pi*Ff*c/W;
k2=2*pi*Fr*c/W;
k3=2*pi*Fff*c/W;
am=deg2rad(5);

% Call Theodorsen function
[Cl1, ~, ~, a1] = theo_AoA(a0,k1,Ff);
[Cl2, ~, ~, a2] = theo_AoA(a0,k2,Fr);
[Cl3, ~, ~, a3] = theo_AoA(a0,k3,Fff);

% take real parts and add mean value

aoa1=rad2deg(real(a1)+am);
aoa2=rad2deg(real(a2)+am);
aoa3=rad2deg(real(a3)+am);
CLqs=2*pi*deg2rad(aoa1);
Cl1=Cl1+2*pi*am;
Cl2=Cl2+2*pi*am;
Cl3=Cl3+2*pi*am;


% Plot total lift responses
plot(aoa1,CLqs,'k-',aoa1,Cl1,'k--',aoa2,Cl2,'k-.',aoa3,Cl3,'k:')
xlabel('$$\alpha$$ [deg]')
ylabel('$$C_L$$')
legend('$$2\pi\alpha$$','$$k=0.07$$','$$k=0.16$$','$$k=0.31$$','Location','Best')
legend boxoff
axis([0 10 0 1])
print('Theo_CL','-depsc2','-r1000');



