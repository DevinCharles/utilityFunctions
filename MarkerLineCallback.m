% Copyright (C) 2015  Devin C Prescott
function MarkerLineCallback(~,evt)
      
    pos = evt.IntersectionPoint;
    try
        delete(findall(gcf,'Tag','MarkerLine'))
    catch
    end
    
    x = [pos(1),pos(1)];
    objs = findobj(gcf);
    ax = objs(strcmpi(get(findobj(gcf),'Type'),'axes'));
    
    for i = 1:length(ax)
        axes(ax(i))
        xlims = get(gca,'XLim');
        ylims = get(gca,'YLim');

        y = ylims;

        hold on
        plot(x,y,'r-','Tag','MarkerLine')

        tObj = text(0.9*diff(xlims)+xlims(1),0.95*diff(ylims)+ylims(1),...
            {'X,Y Pairs:',[num2str(pos(1)),', ',num2str(pos(2))]},...
            'Tag','MarkerLine','HorizontalAlignment','center');
    %     set(gca,'XLimMode', 'manual', 'YLimMode', 'manual');
        p = get(tObj, 'Extent');
    %     offset = 0.005*(p(1)-p(3));
    %     p(1) = p(1)-offset;
    %     p(3) = p(3)+2*offset;

        pObj = patch([p(1) p(1) p(1)+p(3) p(1)+p(3)],...
            [p(2) p(2)+p(4) p(2)+p(4) p(2)], 'k', 'Tag','MarkerLine');
        uistack(tObj, 'top'); % put the text object on top of the patch object
        set(pObj , 'FaceAlpha', .1); % set alpha

        hold off
    end
end