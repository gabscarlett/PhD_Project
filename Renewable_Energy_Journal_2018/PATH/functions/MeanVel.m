function [U_1,U_2,U_3,u_1,u_2,u_3]=MeanVel(Hs,Tw,k,h,z0,t_wave,U0,R,n)

% determine the cubed root mean cubed velocity intergrated over the rotor
% and time averaged.

% z0=-26;
% R=9;
% U0=2.76;
% n=200;
% t_wave=1:300;

x=0;         % [0:lambda/100:lambda] horizontal coordinate (m);
g=9.81;
z=linspace(z0+R,z0-R,n)'; % depth depth of rotor
r=linspace(-R,R,n);      % blade location from hub

sigma=2*pi/Tw; % angular frequency of wave (rad/s)

u_wave =(Hs*g*k/(2*sigma)).*(cosh(k*(h+z))/cosh(k*h)).*cos(k*x-sigma.*t_wave)+(3*Hs^2*sigma*k/16).*(cosh(2*k.*(h+z))./(sinh(k*h))^4).*cos(2*(k*x-sigma.*t_wave));

Urot = U0+u_wave;

U_1=mean(mean(Urot,2));
U_2=((mean(mean(Urot.^2,2)))^(1/2));
U_3=((mean(mean(Urot.^3,2)))^(1/3));

WeightF=cos(asin(r./R))*2;

u=(WeightF.*Urot')*(2/(pi));


u_1= mean(mean(u,2));

u_2=((mean(mean(u.^2,2)))^(1/2));

u_3=((mean(mean(u.^3,2)))^(1/3));