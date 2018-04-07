function [Utx, Utz,nx] = TurbVelFluct(NO,Fl,Fh,t,Ix,Iz,U)

% OUTPUTS TURBULENT VELOCITY FLUCTUATIONS IN THE STREAMWISE (Utx) AND
% DEPTHWISE (Utz)

% This function creates NO turbulent amplitudes which are scaled
% between low Fl and high Fh frequencies

% The scaling in this function uses empirical data taken from the turbulent
% spectra generated for Puget sound by Thomson et al.

% The energy in the spectrum is scaled by normalising the amplitude with
% the turbulent kinetic energy, thus energy is independent of the number of
% components NO requested.

% Frequency vector
F=linspace(Fl,Fh,NO);

% Prealocation
Ekx=ones(size(F));
Ekz=ones(size(F));

for i=1:length(F)
if F(i) >=0.0001 && F(i) <=0.0499
   Ekx(i) =-0.099*log(F(i)) -0.245;
else
   Ekx(i) =0.00035.*F(i).^(-5/3);
end
if F(i) >=0.0001 && F(i) <=0.1999
   Ekz(i) =0.0124*exp(-5.361.*F(i));
else
   Ekz(i) =0.00029.*F(i).^(-5/3);
end

end


% TURBULENT VELOCITY AMPLITUDES
DelF=F(2)-F(1);
DelF=1;

Ax=1/sum(DelF*sqrt(Ekx));
Az=1/sum(DelF*sqrt(Ekz));

nx=Ax.*DelF*sqrt(Ekx);
nz=Az.*DelF*sqrt(Ekz);

% RANDOM PHASE
RandPhaseX = rand(size(F))*2*pi;
RandPhaseZ = rand(size(F))*2*pi;

% VELOCITY FLUCTUATIONS
Utx=U*sum(Ix*nx'.*sin(2*pi.*F'.*t + RandPhaseX'));
Utz=sum(Iz*nz'.*sin(2*pi.*F'.*t + RandPhaseZ'));
end