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

% Script to plot individual box plots showing the quartile distribution of
% the root bending moment for 8 different flow combinations

% Enter plt settings manually
% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% GRAPH SETTING HAVE TO BE MANUAL - BOX PLOT DOES NOT LIKE MY
% graph_settings FUNCTION
% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

set(0,'DefaultLineLineWidth',1.5)
%set(0,'DefaultAxesFontSize',20)
set(0,'DefaultTextFontSize',18)
set(0,'defaultfigurecolor',[1 1 1]) % set frame to white
 
% Allows you to use latex formatting on figures
set(0,'defaulttextinterpreter','latex')
set(0,'DefaultLegendInterpreter','latex')
set(0,'defaultAxesTickLabelInterpreter','latex');

clear, clc, close all

load Multi_cases_8


%% My multi-case plot

figure()
boxplot(CMY,Label,'orientation', 'horizontal','PlotStyle','compact')%,'Symbol','')
xlabel('$$C_{M_y}$$')
xlim([0.05 0.3])
grid off

print('Box_My','-depsc2','-r1000');