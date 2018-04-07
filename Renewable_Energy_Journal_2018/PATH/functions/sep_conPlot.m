function []=sep_conPlot(F_MAT,c,r,G1)
% pcolor version
graph_settings

EDGES=-0.01:0.05:1;

Count =ones(1,length(EDGES)-1);
Percent_sep =ones(length(r),length(EDGES)-1);
for j=1:length(r)
F=F_MAT(j,:);

[I, myBin] =discretize(F,EDGES);


% loop through each bin
for i=1:length(EDGES)-1
INDEX=find(I==i);                % find the indexes in each bin
Count(i)=length(INDEX);
end

Percent_sep(j,:)=Count./length(F) *100;

end

f=myBin(2:end);
x=ones(size(Percent_sep)).*f.*c'; % location of separation point for each section
RR=ones(size(Percent_sep)).*r';

%% % MAKE BLADE OUTLINE 

LE=zeros(size(r)); % leading edge 
TE= LE+c; % trailing edge

c_hub1=TE(1)-0.4; 
c_hub2=c_hub1-(c(1)-0.7);

H= 0.4;
c_hubA=[TE(1),c_hub1];
r_hubA=[r(1),H];

c_hubB=[c_hub2,LE(1)];
r_hubB=[H,r(1)];

c_hubC=[c_hubB(1),c_hubB(1),c_hub1,c_hub1];
r_hubC=[H,0,0,H];


c_tip=[LE(end),TE(end)];
r_tip=[r(end), r(end)];


%% % PLOT ON BLADE
RES=20;
hFig=figure(1000);


contourf(x,RR,Percent_sep,RES) % plot contour
%pcolor(x,RR,Percent_sep) % plot contour
    %colormap(flipud(gray(100)))
    colormap(flipud(hot(50)))
    %colormap(jet(100))
    shading interp
    h = colorbar('eastoutside');
    %set(h, 'ylim', [0 45])
%    hpt1 = get(ax1,'Position');
    
hold on % and plot blade outline

plot(LE,r,'k',TE,r,'k',c_hubA,r_hubA,'k',c_hubB,r_hubB,'k',c_hubC,r_hubC,'k',c_tip,r_tip,'k') 
box off
axis([-0.1 2.3 -0.1 9.1])
ylabel('$$r \; \rm  [m]$$')
xlabel('$$c \; \rm  [m]$$')
ntitle(G1,'location','northeast')


% ax2=subplot(1,3,2); % DS_2D
% contourf(ax2,x(:,:,2),RR(:,:,2),Percent_sep(:,:,2),RES) % plot contour
%     colormap(flipud(hot(50)))
%     shading interp
%      %h = colorbar('northoutside');
%  %ylabel(h,'% of time flow separation occurs');
% %     
% 
% hold on % and plot blade outline
% 
% plot(ax2,LE,r,'k',TE,r,'k',c_hubA,r_hubA,'k',c_hubB,r_hubB,'k',c_hubC,r_hubC,'k',c_tip,r_tip,'k') 
% box off
% color = get(hFig,'Color');
% set(gca,'YColor',[1, 1, 1],'TickDir','out')
% axis([-0.1 2.3 -0.1 9.1])
% %ylabel('$$r \rm  [m]$$')
% xlabel('$$c \; \rm  [m]$$')
% 
% ax3=subplot(1,3,3); % QS_3D
% contourf(ax3,x(:,:,3),RR(:,:,3),Percent_sep(:,:,3),RES) % plot contour
%     colormap(flipud(hot(50)))
%     %h = colorbar('northoutside');
%     shading interp
% 
% hpt3 = get(ax3,'Position');
% 
% colorbar('Position', [hpt1(1) hpt1(2)+hpt1(4)+0.02  -hpt1(1)+hpt3(1)+hpt3(3)  0.03])
% 
% hold on % and plot blade outline
% 
% 
% plot(ax3,LE,r,'k',TE,r,'k',c_hubA,r_hubA,'k',c_hubB,r_hubB,'k',c_hubC,r_hubC,'k',c_tip,r_tip,'k') 
% box off
% color = get(hFig,'Color');
% set(gca,'YColor',[1, 1, 1],'TickDir','out')
% %set(gca,'Ytick',[]);
% axis([-0.1 2.3 -0.1 9.1])
% %ylabel('$$r \rm  [m]$$')
% xlabel('$$c \; \rm  [m]$$')
% 
% print('Blade_sep','-depsc2','-r300');
% 
% %suptitle('Duration of flow separation in [%]')
end



