function [ax]=Multi_pcolor(x,y,z,z1,Range,labels,titles,Leg,xy,dir)

% function to make multiple pcolor subplots
% can also plot additional points using plot
% adds legend and colorbar

%inputs x, y, z
% caxis
% colormap
% labels

figure();
n = size(z,3);
N=4;
F=15;


for plotId = 1 : n
    subplot(2, n/2, plotId);
    H=pcolor(x,y,z(:,:,plotId)');
    set(H,'edgecolor','none')
    caxis(Range)
    
    xlabel(labels(1))
    ylabel(labels(2)) 
    ntitle([titles{plotId}],'Location',dir,'FontSize', 20)
    
    if (plotId~=1) && (plotId~=4)
         set(gca,'ytick',[],'ylabel',[]);
    end
    
    if plotId < 4
         set(gca,'xtick',[],'xlabel',[]);
    end
    
    if xy
    hold on
    

    t0=((z1(:,:,plotId)>0.99) & (z1(:,:,plotId)<1.05));
    [row0,col0] = find(t0);
    p0=plot(x(row0),y(col0),'+','MarkerSize',N,'LineWidth',0.8,'color',[0.7 0 0]);
    
    t1=((z1(:,:,plotId)>1.05) & (z1(:,:,plotId)<1.1));
    [row1,col1] = find(t1);
    p1=plot(x(row1),y(col1),'o','MarkerSize',N,'LineWidth',0.8,'color',[0.7 0 0]);

    t2=(z1(:,:,plotId)>1.1);
    [row2,col2] = find(t2);
    p2=plot(x(row2),y(col2),'s','MarkerSize',N,'LineWidth',0.8,'color',[0.7 0 0]);
    
%       p0=plot(x,y.*((z1(:,:,plotId)>1.02) & (z1(:,:,plotId)<1.05)),'+','MarkerSize',N,'LineWidth',0.8,'color',[0.7 0 0]);
%        p1=plot(x,y.*((z1(:,:,plotId)>1.05)&(z1(:,:,plotId)<1.1)),'o','MarkerSize',N,'LineWidth',0.8,'color',[0.7 0 0]);
%        p2=plot(x,y.*((z1(:,:,plotId)>1.1)),'s','MarkerSize',N,'LineWidth',0.8,'color',[0.7 0 0]);
    
%      if plotId==2
%         hold on       
%          lgnd=legend([p0; p1; p2],Leg);
% 
%         set(lgnd,'color','none');
%      end
    end

    


end

    hpt1 = get(subplot(2, n/2, 1),'Position');
    hpt0 = get(subplot(2, n/2, n),'Position');
    
    C=colorbar('Position', [hpt1(1) hpt1(2)+hpt1(4)+0.02  -hpt1(1)+hpt0(1)+hpt0(3)  0.03]); 
    C.Label.Interpreter = 'latex';
    C.FontName='Times New Roman';
    C.FontSize=20;
    C.Label.String = ((labels(3)));
    C.Label.Rotation = 0; % to rotate the text
    C.Ticks = Range(1):0.02:Range(end);
    colormap(flipud(parula(5000)))
    
end