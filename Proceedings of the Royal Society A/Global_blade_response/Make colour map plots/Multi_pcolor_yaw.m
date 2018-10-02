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
    
    hold on
    y0=[1.5,3.5];
    
    if plotId==1
        x0=3.8;
        x5=3.5;
        x10=3.3;
    
        
    elseif plotId==2
        x0=3.8;
        x5=3.4;
        x10=3.2;
    
        
    elseif plotId==3
        x0=3.8;
        x5=3.4;
        x10=3.1;
    
        
    elseif plotId==4
        x0=3.8;
        x5=3.3;
        x10=-20;
    
        
    elseif plotId==5
        x0=4;
        x5=3.2;
        x10=-30;
    
        
    elseif plotId==6
        x0=4.6;
        x5=3.2;
        x10=-40;
    
    end
    
        plot([x0,x0],y0,'k',[x5,x5],y0,'k',[x10,x10],y0,'k','LineWidth',1)
        text(x0-0.12,2,'1.00','Rotation',90,'FontSize',F,'Interpreter','latex');
        text(x5-0.11,2.5,'1.05','Rotation',90,'FontSize',F,'Interpreter','latex');
        text(x10-0.12,3,'1.10','Rotation',90,'FontSize',F,'Interpreter','latex');
%         X0 = linspace(x0(1),x0(end),50);
%         Y0 = interp1(x0,y0,X0,'PCHP');
        %plot(x0,y0,'k-.','LineWidth',1,'color',[0.2 0.2 0.2])

          

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