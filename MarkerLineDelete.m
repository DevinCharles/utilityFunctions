% Copyright (C) 2015  Devin C Prescott
function MarkerLineDelete(~,~)
    if strcmpi(get(gca,'SelectionType'),'alt')
        try
            delete(findall(gcf,'Tag','MarkerLine'))
        catch
        end
        return
    end
end