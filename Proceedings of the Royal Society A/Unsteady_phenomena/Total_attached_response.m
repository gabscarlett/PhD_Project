% script to show relationship of the unsteady lift amp with increasing
% reduced frequency

% Normalised amplitude of the total, circulatory and non-circulatory coefficients with 
% reduced frequency for pure angle of attack oscillations.

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


k = 0.0000001:0.001:4;

for i =1:length(k)
% Bessel functions
J0 = besselj(0,k(i));
J1 = besselj(1,k(i));
Y0 = bessely(0,k(i));
Y1 = bessely(1,k(i));
H0 = besselh(0,2,k(i));
H1 = besselh(1,2,k(i));

% Real part of function 
F(i) = (J1*(J1+Y0)+Y1*(Y1-J0))/((J1+Y0)^2 +(Y1-J0)^2);

% Imaginary part of function
G(i) = -(Y1*Y0+J1*J0)/((J1+Y0)^2+(Y1-J0)^2);

% pure AoA oscillations
Cl1c(i) =abs(F(i)+1i*G(i)); % circulatory amp
Cl1nc(i) = abs(1i*k(i)/2); % non circulatory amp
Cl1(i) =sqrt((F(i))^2+(G(i)+0.5*k(i))^2); % total amp

end




%% Plot for Proc Royal Society A

% ZETA PLOT TO SHOW EFFECT OF ADDED MASS

figure(1);
ax1=subplot(1,2,1);
plot(ax1,k,Cl1,'k',k,Cl1c,'k:',k,Cl1nc,'k--') 
xlabel('$$k$$'); 
ylabel('$$\zeta$$');
legend('Total response','Circulatory','Added mass','Location','Best');
legend boxoff
ntitle('(a)','location','northeast','fontsize',20)
ax2=subplot(1,2,2);
plot(ax2,k,Cl1,'k',k,Cl1c,'k:',k,Cl1nc,'k--')
xlabel('$$k$$'); 
ylabel('$$\zeta$$');
ntitle('(b)','location','northeast','fontsize',20)
axis([0 1  0 1])
print('zeta1','-depsc2','-r1000');

