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

% GROUPED BOX PLOT SCRIPT

% FOUR COBMINED FLOW FORCINGS ARE GROUPED BY BLADE LOCATION


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

% Enter graph settings manually

set(0,'DefaultLineLineWidth',1.5)
%set(0,'DefaultAxesFontSize',20)
set(0,'DefaultTextFontSize',20)
set(0,'defaultfigurecolor',[1 1 1]) % set frame to white
 
% Allows you to use latex formatting on figures
set(0,'defaulttextinterpreter','latex')
set(0,'DefaultLegendInterpreter','latex')
set(0,'defaultAxesTickLabelInterpreter','latex');

clear, clc, close all


load Multi_cases_8

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Distributed normal force plots

tip=squeeze(FN(98,:,:))/1000;
mid=squeeze(FN(50,:,:))/1000;
root=squeeze(FN(2,:,:))/1000;

no=NaN(size(tip(:,1))); % trick for spacing between each blade location
A=[tip(:,5:8),no,mid(:,5:8),no,root(:,5:8)]; % NaNs give white space!


h1=figure('Color', 'w');
c = colormap(gray(5)); % graysale bounded by black and white
c(end,:)=[]; % remove white!


C = [c; ones(1,3); c; ones(1,3)];  % this is the trick for coloring the boxes


% regular plot
boxplot(A, 'colors', C, 'plotstyle', 'compact', ...
    'labels', {'','Tip','','','','','Mid','','','','','Root','',''},'LabelOrientation','horizontal'); % label only three categories
grid off
hold on;

for ii = 1:4
    plot(NaN,1,'color', c(ii,:))%, 'LineWidth', 4);
end

ylabel('$$F_N$$ [kNm$$^{-1}$$]')
legend({Label{5}, Label{6},Label{7},Label{8}});
set(gca, 'Ticklength', [0 0])
print('Box_FN','-depsc2','-r1000');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Lift coefficient plots

tip=squeeze(CL(98,:,:));
mid=squeeze(CL(50,:,:));
root=squeeze(CL(2,:,:));

no=NaN(size(tip(:,1)));
A=[tip(:,5:8),no,mid(:,5:8),no,root(:,5:8)];


h2=figure('Color', 'w');
c = colormap(gray(5)); % graysale bounded by black and white
c(end,:)=[]; % remove white!

% A = randn(60,14);        % some data
% A(:,5) = NaN;           % this is the trick for boxplot
% A(:,10) = NaN;           % this is the trick for boxplot

C = [c; ones(1,3); c; ones(1,3)];  % this is the trick for coloring the boxes


% regular plot
boxplot(A, 'colors', C, 'plotstyle', 'compact', ...
    'labels', {'','Tip','','','','','Mid','','','','','Root','',''},'LabelOrientation','horizontal'); % label only three categories
grid off
hold on;

for ii = 1:4
    plot(NaN,1,'color', c(ii,:))%, 'LineWidth', 4);
end

ylabel('$$C_L$$')
legend({Label{5}, Label{6},Label{7},Label{8}});
set(gca, 'Ticklength', [0 0])

print('Box_CL','-depsc2','-r1000');

