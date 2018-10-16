function []=sep_conPlot_3(Fsep,LEV,c,r,G,r1,r2,r3)


% This function makes two figures each containing subplots with individul
% labels given by (G)

% 1) The separation location and time duration on the blade out putting n
%    sublots(n=size(Fsep,3)).

% 2) The locations on the blades where LEV shedding occurs on the blade. 
%    This is binary

graph_settings

%% SORT SEPARATION POINT LOCATION BY DURATION
EDGES=-0.01:0.1:1;

Count =ones(1,length(EDGES)-1);
Percent_sep =ones(length(r),length(EDGES)-1);

n=size(Fsep,3);
for k=1:n
for j=1:length(r)
F=Fsep(j,:,k);

[I, myBin] =discretize(F,EDGES);


% loop through each bin
for i=1:length(EDGES)-1
INDEX=find(I==i);                % find the indexes in each bin
Count(i)=length(INDEX);
end

Percent_sep(j,:)=Count./length(F) *100;
f=myBin(2:end);
end


x(:,:,k)=ones(size(Percent_sep)).*f.*c'; % location map of separation point for each section
RR(:,:,k)=ones(size(Percent_sep)).*r';   % corresponding radial map
Psep(:,:,k)=Percent_sep;
end

%% SORT VORTEX OCCURANCE BINARY

for m=1:n
lev=(sum(LEV(:,:,m),2))>0;

    rVor = r(lev);
    cVor = c(lev);
    
    for X=1:length(cVor)
        % stretch over chord
    xVor(:,X,m) = linspace(0,cVor(X),11);
    yVor(:,X,m) = ones(size(xVor(:,X,m))).*rVor(X);
    end

end
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


%% % PLOT SEPARATION ON BLADE

 RES=100;
 figure(1) ;
 for plotId = 1 : n
    subplot(1, n, plotId) ;
    
    % CONTOUR PLOT SHOWING SEPARATION
    contourf(x(:,:,plotId),RR(:,:,plotId),Psep(:,:,plotId),RES,'LineColor', 'flat','Linewidth', 0.2)%[0.9 0.9 0.9]) % plot contour
    %set(findobj(gca,'Type','patch','UserData',1),'EdgeColor',[0 0 0])
    caxis([0,60])
    colormap(flipud(hot(100)))
    shading interp
    
    hold on
    
    % PLOT BLADE OUTLINE
    plot(LE,r,'k',TE,r,'k',c_hubA,r_hubA,'k',c_hubB,r_hubB,'k',c_hubC,r_hubC,'k',c_tip,r_tip,'k')
    hold on
    % PLOT VORTEX SHEDDING
    h2=plot(xVor(2:end-1,:,plotId),yVor(2:end-1,:,plotId),'o','color',[0.2 0.2 0.2],'linewidth',0.3,'Markersize',2);
    box off
    hold on
    
    % PLOT REDUCED FREQUENCY LINES AT BLADE LOCATION
    if r1(plotId)>0
    plot(linspace(0,c(r1(plotId)),4),r(r1(plotId))*ones(4,1),'r:')    
    end
    
    if r2(plotId)>0
    plot(linspace(0,c(r2(plotId)),4),r(r2(plotId))*ones(4,1),'b-.')
    end
    
    if r3(plotId)>0
    plot(linspace(0,c(r3(plotId)),4),r(r3(plotId))*ones(4,1),'k--')
    end
    
    if plotId ==1
    text(c(r1(plotId))/3,r(r1(plotId)-3),'$$k>0.56$$')
    text(c(r2(plotId))/8,r(r2(plotId)-3),'$$k>0.2$$')
    text(c(r3(plotId))/4,r(r3(plotId)-3),'$$k>0.3$$')
    end
    
    if plotId ==4
    legend(h2,'LEV')
    legend boxoff
    end
    
    axis([-0.1 2.3 -0.1 9.1])
    if plotId==1
    ylabel('$$r \; \rm  [m]$$')
    else
    set(gca,'YTick',[])
    end
    
    xlabel('$$c \; \rm  [m]$$')
%     title(G{plotId},'FontSize', 15)
    ntitle(G{plotId},'location','north')
    
    hpt1 = get(subplot(1, n, 1),'Position');
    hpt0 = get(subplot(1, n, n),'Position');
    
    C=colorbar('Position', [hpt1(1) hpt1(2)+hpt1(4)+0.02  -hpt1(1)+hpt0(1)+hpt0(3)  0.03]);
    %C=colorbar('Location','southoutside');
    C.Label.String = ('% time separated');
 end

%   figure(2) ;
%  for plotId = 1 : n
%     subplot(1, n, plotId) ;
%     plot(xVor(:,:,plotId),yVor(:,:,plotId),'K');
%     grid off
%     box off
%     
%     hold on
%     
%     plot(LE,r,'k',TE,r,'k',c_hubA,r_hubA,'k',c_hubB,r_hubB,'k',c_hubC,r_hubC,'k',c_tip,r_tip,'k')
%     box off
%     axis([-0.1 2.3 -0.1 9.1])
%     ylabel('$$r \; \rm  [m]$$')
%     xlabel('$$c \; \rm  [m]$$')
%     ntitle(G{plotId},'location','northeast')
% 
%  end

end



