function[Cl,Cll,Clqs,aoa] = TheoLoew(a0,am,Ff,Fr,c,U,W,Blades)

% function which calls theodorsen and Loewy and returns CL and alpha values
% with mean value applied


M=Ff/Fr;

a=0.3;

ui=U*(1-1.5*a);

k=2*pi*Ff*c/W;

s=2*ui/(c*Blades*Fr);

[Cl, ~, ~, a] = theo_AoA(a0,k,Ff);
[Cll, ~, ~, ~] = loew_AoA(a0,k,Ff,Blades,M,s);

aoa=rad2deg(real(a)+am);
Clqs=2*pi*deg2rad(aoa);
Cl=Cl+2*pi*am;
Cll=Cll+2*pi*am;



end