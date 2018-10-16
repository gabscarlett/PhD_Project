% plot light and deep dynamic stall plots

clear
close all
clc
graph_settings 

load light_DS
load deep_DS

figure()
ax1=subplot(1,2,1);
plot(ax1,Alpha,Cl_2d,'k--',a_light,Cl_light,'k')
xlabel('$$\alpha$$ [deg]')
ylabel('$$C_L$$')
legend('Static','Dynamic','location','best')
legend boxoff
ntitle('(a)','location','northeast','fontsize',20)
axis([0 30 0.5 2.5])

ax2=subplot(1,2,2);
plot(ax2,Alpha,Cl_2d,'k--',a_deep,Cl_deep,'k')
xlabel('$$\alpha$$ [deg]')
ylabel('$$C_L$$')
ntitle('(b)','location','northeast','fontsize',20)
axis([0 30 0.5 2.5])
print('DS_curves','-depsc2','-r1000');