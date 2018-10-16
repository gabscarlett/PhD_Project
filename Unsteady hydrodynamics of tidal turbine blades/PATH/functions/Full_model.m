function[t,Tr,Twr,Pout,Tout,Fsep,Vortex,FNorm,FTan,CMy,CMyqs,Wr,LifCoef,ut,Phi,aoa] = Full_model(U0,LAW,Rotations,Gamma,Hs,Tw,wd,WAVES,I,L,Ratio,TURB,omega,seed,P0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                                                 %%%
%%%       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     %%%
%%%       %%%%%% Written by Gabriel Scarlett August 2017 %%%%%%     %%%
%%%       %%%%%%     The University of Edinburgh, UK     %%%%%%     %%%
%%%       %%%%%%         School of Engineering           %%%%%%     %%%
%%%       %%%%%%       Institute for Energy Systems      %%%%%%     %%%
%%%       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     %%%
%%%                                                                 %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GLOBAL SCRIPT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% combined wave yaw and shear model with unsteady loading
 
 
% LOADS ON 3 BLADES
% POWER AND THRUST COEFFICIENTS FOR FULL ROTOR DETERMINED BY ANALYSING
% THE  LOADING ON ALL 3 BLADES BLADES
 
% DETERMINED BENDING MOMENTS, POWER AND THRUST COEFFICIENT FOR THE ROTOR
 
 
 
% COMPARES THE UNSTEADY, QUASI-STEADY AND STEADY ANALYSIS
 
% DETEMINES THE FLOW RELATIVE VELOCITY AND ANGLE OF ATTACK DUE TO THE
% COMBINED EFFECTS OF WAVES, SHEAR LAYER AND A YAW MISALIGNMENT
% INDUCTION FACTORS CALCULATED USING STATIC AEROFOIL COEFFICIENTS 
% INDUCTION FACTORS ARE CORRECTED FOR YAW MISALIGNMENT
% LOADS COUPLE THE EFFECT OF DYNAMIC STALL AND ROTATIONAL AUGMENTATION
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% INITIALISATION CALLS
% FOLLOWING CALLS TO PRE-PROCESS DATA
 
% 1: CALL TO VitExt             - Extrapolate 2D airfoil data (1D array)
% 2: CALL TO sep_point          - Determine 2D point of separation (1D array)
% 3: CALL TO stall_delay        - Determine 3D Cl and Cd along blade due to rotation (2D array)
% 4: CALL TO VitExt             - Extrapolate 3D airfoil data (2D array)
% 5: CALL TO sep_point          - Determine 3D point of separation (2D array)
                                 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% BLADE LOADS
% FOLLOWING CALLS MADE 
 
% 6:  CALL TO wag                 - Determine unsteady linear Cl for each blade(2D array)
% 7:  CALL TO DS_2D               - Determine 2D unsteady non-linear Cl and Cd  for each blade (2D array)
% 8:  CALL TO DS_3D               - Determine 3D unsteady non-linear Cl and Cd  for each blade (2D array)
% 9:  CALL TO loads               - Determine the power, thrust, and moments for each blade
% 10: CALL TO BEM_steady          - Induction factors determined for steady analysis 
% 12: CALL TO GRAPHS              - Produced graphs for Renewable Energy paper 
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TURBINE SPECIFICATIONS AND OPERATING CONDITIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% graph_settings
% clear, clc, close all
 
%Rotations =10; % number of rotations simulated
 
%% ====================== INPUT VARIABLES =============================== %
 
%TSR=4.5;                % tip speed ratio
Pitch = 0.1;            % pitch angle (deg)  
%U0=2.77;                % streamwise current (m/s) at hub height
%LAW=1/7;                % shear profile shape
z0=-26;                 % distance from bed to the hub centre (m)
g=9.81;                 % acceleration due to gravity (m/s^2)
rho = 1025;             % density of sea water (kg/m^3)
%Gamma=5;                % yaw angle (deg)
gamma=deg2rad(Gamma);   % yaw angle (rad)
 
%% ============================ WAVE DATA =============================== %  

% WAVES =false;           % boolean - true model waves / false no waves
% Hs=5.0;                 % significant wave height (m)
% Tw=10.0;                % zero crossing period (s)
% wd=pi;                  % wave direction in relation to the freestream (rad)
h=45;                   % water depth, free surface to seabed (m) 



%% ========================= TURBULENCE DATA ============================ %  

%TURB =false;            % boolean - true model turbulence / false no turbulence
It=[I,Ratio*I,Ratio*I];          % Turbulence intensity in [u,v,w]
dudz=U0/(h+z0);          % Shear [m^2/s]
 

%% ============================ TURBINE SPECS =========================== %
file_turb ='TGL_TURBINE';
load(file_turb)                         % load turbine blade profile
 
Blades=3;                               % Number of blades
pitch=deg2rad(Pitch);                   % operational pitch applied (rad)
phase=[0,deg2rad(120),deg2rad(240)];    % phase of each blade
 
NBsec = 100;                            % number of blade sections
r=linspace(rad(1),rad(end),NBsec);      % radial coordinate (m)
B=interp1(rad,B,r,'PCHIP')+pitch;       % gemoetrical twist + pitch (rad)
c=interp1(rad,c,r,'PCHIP');             % chord length (m)
 
R=(r(end));                             % radius of blade (m)
R_InRange=(r>0.8*r(end));               % boolean (TRUE for outer section) 
Mu=r/R;                                 % normalised radial coordinate
A=pi*R^2;                               % swept area (m^2)
%omega = abs(U0*TSR/R);                  % rotational speed of blades (rad/s)
TSR=R*omega/U0;
Tr = (2*pi)/omega;                      % period of rotation (s)

%% ============================ TIME/FREQUENCY ========================== %
steps=72;
dt=Tr/steps;                   % time step; (5 degree/step)
t=0:dt:Rotations*Tr - dt;        % time (s)
psi=omega.*t;               % azimuthal position (deg)

fs=1/dt;                    % sampling frequency
f0 = 1/t(end);              % lowest frequency             
f = [f0:f0:fs/2]';          % frequency array for turbulence model
df = median(diff(f));       % if distributed unifoirmly df=f0


%% ======================== BEM SOLUTION METHOD ========================= %

BEM_STEADY = true;                     % (uniform current)
BEM_QS = false;                        % (unsteady flow, static coeffs, running average)
BEM_UNSTEADY = false;                  % (unsteady, flow, unsteady coeffs, fully coupled,running average)

%% ============================ PRE-PROCESSOR =========================== %
 
        % ROTATONAL AUGMENTATION / STALL DELAY / SEPARATION POINT
    
        file_foil = 'S814_static_data';
        load(file_foil)                 % Load airfoil data

        [Values_360, Values_360r] = PreProcessor1(aoa,Cl_2d,Cd_2d,Cn_2d,Clin,LinRange,B,r,c,az);
        
        file_ds ='S814_DS_parameters';
        
% ======================================================================= %        


%% FLOW AT EACH BLADE SECTION FOR EVERY BLADE

%initial parameters
ut=zeros(size(t));u_wave=0;wt=zeros(size(t));w_wave=0;vt=zeros(size(t));


        %% Turbulence 
        if TURB
        % Turbulence is assumed to be perfeectly correlated in space.
        % Thus fluctuations at blade1 = blade2 = blade3  for all r.
        %Suvw = TideSpec(U0,It,dudz,f); % NREL tidal PSD for [u,v,w] velocity fluctuations [ m^2/s]
        Suvw = vKSpec(U0,I,L,f',Ratio);% von Karmen PSD for [u,v,w] velocity fluctuations [ m^2/s]
        
        rng(seed);
        PHI = rand(size(Suvw))*2*pi; % random phase
        % create velocity fluctuations
        ut= sum(sqrt(2*df*Suvw(:,1)).*cos(2*pi*f.*t +PHI(:,1)));
        vt= sum(sqrt(2*df*Suvw(:,2)).*cos(2*pi*f.*t +PHI(:,2)));
        wt= sum(sqrt(2*df*Suvw(:,3)).*cos(2*pi*f.*t +PHI(:,3)));
        end
        
for i=1:Blades 
        
 
        % Blade position
        z_blade = r'.*sin(psi-phase(i));
        z = z0 + z_blade;                    
          
        % WAVE VELOCITIES
        if WAVES
        [u_wave,w_wave,WaveNumber]=WaveVel(Hs,Tw,wd,h,z,(psi-phase(i)),r,TSR,U0,gamma);
        end
         
        % Shear profile
        %U_shear = U0.*((z0 + z_blade + h)./h).^(LAW);
        U_shear = U0.*((abs(z0) + z_blade)./abs(z0)).^(LAW);
                        
        % Total streamwise velocity       
        U_axial(:,:,i) = (U_shear+ut).*cos(gamma) + u_wave.*cos(gamma+wd);
        
        % Tangential (DEPTHWISE CONTRIBUTION)
        W_Tan =w_wave.*sin(psi-phase(i)) +wt.*sin(psi-phase(i));
        
        % Tangential (TRANSVERSE HORIZONTAL CONTRIBUTION)
        V_Tan =vt.*cos(psi-phase(i));
        
        % Yaw and wave angle transverse components        
        U_tan =(U_shear+ut)*sin(gamma).*cos(psi-phase(i))+ u_wave.*sin(gamma+wd).*cos(psi-phase(i));
        
        % Total tangential velocity
        %U_theta(:,:,i) = omega.*r' + U_tan +w_wave.*sin(psi-phase(i)) +wt.*sin(psi-phase(i)) +vt.*cos(psi-phase(i));
        U_theta(:,:,i) = omega.*r' + U_tan + W_Tan + V_Tan;
                
end
         
%% BEM SOLUTION FOR AXIAL AND TANGENTIAL INDUCTION FACTORS

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % BEM induction calculation based on steady blade 1 only %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % (uniform current then yaw correction post solution)
        [Ax,ap] = BEM_steady3D_0(U0,TSR,Blades,r,c,B,Values_360r);
        [Ax,ap] = MeanInduction(Ax,ap);
        ap=ap.*ones(size(psi));
        Aa=Ax.*ones(size(psi));

        
        
        chi=(0.6.*Ax+1)*gamma;       % wake skew angle
         
for i=1:Blades % Loop over each blade for loads
%% RELATIVE VELOCITY, ANGLE OF ATTACK AND FLOW ANGLE

        % yaw correction to axial induction factor to give azimuthal variation
        ak = Aa.*(1+((15.*pi)/64).*tan(0.5.*chi).*Mu'.*sin(psi-phase(i))); % correction to axial induction factor for skewed wake
        ak(1,:)=0.990;
        ak(end,:)=0.990;

        % Relative velocity
        Wrel(:,:,i) = sqrt((U_axial(:,:,i).*(1-ak)).^2+(U_theta(:,:,i).*(1+ap)).^2);
         
        % Angle of attack
        
        AoA(:,:,i) = 90-atan2d(U_theta(:,:,i).*(1+ap),U_axial(:,:,i).*(1-ak))-rad2deg(B)' - P0;

      
        % Flow angle
        %phi=deg2rad(AoA(:,:,i))+B';
        
        phi(:,:,i)=deg2rad(AoA(:,:,i)+P0)+B';
         
         
%% LOADS, MOMENTS AND POWER

        
        % CALL INDICIAL SOLUTION
        % pass AoA history to indicial load model
        [Cl_us(:,:,i),Cl_c,Cl_nc,Ds,aE(:,:,i)] = wag(c,dt,U0,deg2rad(AoA(:,:,i)),az,Clin);
        
        % CALL DYNAMIC STALL SOLUTION
        % ROTATIONAL AUGMENTATION SOLUTION
        [~,~,Cl(:,:,i), Dvis, Cd_Ind, ff_3d(:,:,i), fff_3d(:,:,i), VortexTracker_3d(:,:,i)] =.....
            DS_3D(B,c,Values_360r,r,Cl_us(:,:,i),Cl_c,Cl_nc,Ds,aE(:,:,i),deg2rad(AoA(:,:,i)),file_ds);    

        
        % DRAG ROTATIONAL 
        [Cd(:,:,i)] = UnstCD(Dvis,Cd_Ind,Values_360,Values_360r,aE(:,:,i),r,Cd0);
        
        % Quasi-steady (2D & 3D) coefficients
        % Interpotation with the rotatonal 360 degree values
      
        % Interpotation with the 360 degree values
        Cl_QS2d(:,:,i)=interp1(Values_360r.Alpha,Values_360.Cl,deg2rad(AoA(:,:,i)),'spline');
        Cd_QS2d(:,:,i)=interp1(Values_360r.Alpha,Values_360.Cd,deg2rad(AoA(:,:,i)),'spline');
        rr=r'.*ones(size(AoA(:,:,i)));
        Cl_QS3d(:,:,i)=interp2(r,Values_360r.Alpha,Values_360r.Cl,rr,deg2rad(AoA(:,:,i)),'spline');
        Cd_QS3d(:,:,i)=interp2(r,Values_360r.Alpha,Values_360r.Cd,rr,deg2rad(AoA(:,:,i)),'spline');
        Cd_QS3d(R_InRange,:,i)=Cd_QS2d(R_InRange,:,i); % VALUES NEAR THE TIP = 2D (No augmentation)
        
        % Moments, thrust, power
        FF=0.5.*rho.*c'.*Wrel(:,:,i).^2; % Dynamic pressure
        [MY(:,i),MX(:,i),T(:,i),P(:,i),FN(:,:,i),FT(:,:,i)]=loads_2(FF(2:end-1,:),Cl(2:end-1,:,i),Cd(2:end-1,:,i),phi(2:end-1,:,i),r(2:end-1),omega);
        
        [MYqs(:,i),MXqs(:,i),Tqs(:,i),Pqs(:,i),~,~]=loads_2(FF,Cl_QS3d(:,:,i),Cd_QS3d(:,:,i),phi(:,:,i),r,omega); % Quasi-steady
        

end

% STANDARD DEVIATION OF AoA
DelAlpha=std(AoA(:,:,1),0,2);

% POWER COEFFICIENT
Pin=0.5*rho*A*U0^3; % total power available to rotor
Pout=sum(P,2);      % total power out

Tout=sum(T,2);      % total thrust out

CP=Pout./Pin; 
%CP_Mean=mean(CP);

Fsep=ff_3d(:,:,1);
Vortex=VortexTracker_3d(:,:,1);
FNorm=FN(:,:,1);
FTan=FT(:,:,1);
%My=MY(:,1);
%Myqs=MYqs(:,1);
Wr=Wrel(:,:,1);
LifCoef=Cl(:,:,1);
Phi=rad2deg(phi(:,:,1));
aoa=AoA(:,:,1);

if WAVES
%Twr=2*pi/(WaveNumber*sqrt(g*h));  % relative wave period (Shallow)
Twr=2*pi/sqrt(WaveNumber*g*tanh(WaveNumber*h)) ;  % relative wave period (Intermediate)
%Twr=2*pi/sqrt(WaveNumber*g); % relative wave period (Deep)
else 
    Twr=0;
end

%WaveLength=2*pi/WaveNumber;

% ROOT BENDING MOMENT IN COEFFICIENT FORM
%Urate=2.7;

M_IN=0.5*A*rho*U0.^2*R;

CMy=MY(:,1)/M_IN;
CMyqs=MYqs(:,1)/M_IN;

end

