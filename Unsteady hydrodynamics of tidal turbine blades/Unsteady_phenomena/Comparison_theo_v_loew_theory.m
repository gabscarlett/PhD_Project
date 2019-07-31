%Unsteady lift coefficient given by Theodorsen and Loewy for a section near the blade tip for a range of oscillation frequencies.

graph_settings
clear, clc, close all

% Operating params

Fr=1/4.6; % rotational frequency
Blades=3;
a0 =deg2rad(4);
c= 0.8;
U=2.7;
W=7;
am=deg2rad(5);

% % Theodorsen vs Loewy plot for each forcing

Ff=1/10; % 10 s wave
[Cl,Cll,Clqs,aoa] = TheoLoew(a0,am,Ff,Fr,c,U,W,Blades);

figure()
ax1=subplot(2,3,1);
plot(ax1,aoa,Clqs,'k--',aoa,Cl,'k',aoa,Cll,'k:')
xlabel('$$\alpha$$ [deg]')
ylabel('$$C_L$$')
legend('$$2\pi\alpha$$','Theodorsen','Lowey','Location','best')
legend boxoff
set(gca,'xtick',[],'xlabel',[]);
axis([0 10 0 1])
grid off
ntitle('$$k =0.07$$','location','northwest','fontsize',20)

Ff=Fr; % 1P
[Cl,Cll,Clqs,aoa] = TheoLoew(a0,am,Ff,Fr,c,U,W,Blades);

ax2=subplot(2,3,2);
plot(ax2,aoa,Clqs,'k--',aoa,Cl,'k',aoa,Cll,'k:')
xlabel('$$\alpha$$ [deg]')
ylabel('$$C_L$$')
set(gca,'xtick',[],'xlabel',[]);
set(gca,'ytick',[],'ylabel',[]);
axis([0 10 0 1])
grid off
ntitle('$$k=0.16$','location','northwest','fontsize',20)

Ff=1/3; % 3 s wave
[Cl,Cll,Clqs,aoa] = TheoLoew(a0,am,Ff,Fr,c,U,W,Blades);

ax3=subplot(2,3,3);
plot(ax3,aoa,Clqs,'k--',aoa,Cl,'k',aoa,Cll,'k:')
xlabel('$$\alpha$$ [deg]')
ylabel('$$C_L$$')
axis([0 10 0 1])
set(gca,'xtick',[],'xlabel',[]);
set(gca,'ytick',[],'ylabel',[]);
grid off
ntitle('$$k=0.24$$','location','northwest','fontsize',20)

Ff=2*Fr; % 2P
[Cl,Cll,Clqs,aoa] = TheoLoew(a0,am,Ff,Fr,c,U,W,Blades);

ax4=subplot(2,3,4);
plot(ax4,aoa,Clqs,'k--',aoa,Cl,'k',aoa,Cll,'k:')
xlabel('$$\alpha$$ [deg]')
ylabel('$$C_L$$')
axis([0 10 0 1])
grid off
ntitle('$$k=0.31$','location','northwest','fontsize',20)
print('Theo_Loew','-depsc2','-r1000');

Ff=3*Fr; % 3P
[Cl,Cll,Clqs,aoa] = TheoLoew(a0,am,Ff,Fr,c,U,W,Blades);

ax3=subplot(2,3,5);
plot(ax3,aoa,Clqs,'k--',aoa,Cl,'k',aoa,Cll,'k:')
xlabel('$$\alpha$$ [deg]')
ylabel('$$C_L$$')
axis([0 10 0 1])
set(gca,'ytick',[],'ylabel',[]);
grid off
ntitle('$$k=0.47$$','location','northwest','fontsize',20)

Ff=1; % turbulence

[Cl,Cll,Clqs,aoa] = TheoLoew(a0,am,Ff,Fr,c,U,W,Blades);

ax4=subplot(2,3,6);
plot(ax4,aoa,Clqs,'k--',aoa,Cl,'k',aoa,Cll,'k:')
xlabel('$$\alpha$$ [deg]')
ylabel('$$C_L$$')
axis([0 10 0 1])
set(gca,'ytick',[],'ylabel',[]);
grid off
ntitle('$$k=0.72$','location','northwest','fontsize',20)

print('Theo_Loew','-depsc2','-r1000');