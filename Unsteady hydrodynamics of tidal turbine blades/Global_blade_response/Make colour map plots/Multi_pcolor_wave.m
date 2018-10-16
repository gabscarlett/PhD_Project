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
F=16;


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
    
    if (plotId ~=3) && (plotId ~=4)
    hold on
    
    if plotId==1
        x0=[8.8,9.4,11.2,12];
        y0=[6,5.4,4.8,4.6];
        text(9.8,5.42,'1','Rotation',-30,'FontSize',F);

        
    elseif plotId==2
        x0=[10.6,10.8,11.6,12];
        y0=[6,5.8,5.6,5.57];
        text(11.2,5.85,'1','Rotation',-20,'FontSize',F);

        
    elseif plotId==5
        x0=[10.6,10.8,11.8,12];
        y0=[6,5.6,5,4.98];
        text(11,5.65,'1','Rotation',-42,'FontSize',F);
        
    elseif plotId==6
        x0=[10.2,10.8,11.6,12];
        y0=[6,5.2,4.6,4.4];
        text(11,5.25,'1','Rotation',-45,'FontSize',F);
    end
        X0 = linspace(x0(1),x0(end),50);
        Y0 = interp1(x0,y0,X0,'PCHP');
        plot(X0,Y0,'k','LineWidth',1)
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