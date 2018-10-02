function [Cl, Cl_c, Cl_nc, a] = theo_AoA(a0,k,f)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%*********Analytical theory for unsteady flow on a static foil************%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t=0:0.001:1/f;       % time vector
w=2*pi*f;              % angular frequency
a= a0*exp(1i*w*t);      % Harmonic pitching motion

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                %%% Formation of Theodorsen's function %%%

% Bessel functions
J0 = besselj(0,k);
J1 = besselj(1,k);
Y0 = bessely(0,k);
Y1 = bessely(1,k);

% Real part of function 
F = (J1*(J1+Y0)+Y1*(Y1-J0))/((J1+Y0)^2+(Y1-J0)^2);
% Imaginary part of function
G = -(Y1*Y0+J1*J0)/((J1+Y0)^2+(Y1-J0)^2);
% Theodorsen's function with argument reduced frequency
Ck=F+1i*G;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% For pure AoA oscillations %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

              %%% Theodorsen's unsteady lift coefficient %%%%

Cl_nc = pi*(1i*k)*a;                  % non-circulatory lift coefficient
Cl_c = pi*(2*Ck)*a;                  % circulatory lift coefficient
Cl = real(Cl_nc + Cl_c);          % total lift coefficient
end