function output_txt = dataCursor(obj,event_obj)
    % Display the position of the data cursor
    % obj          Currently not used (empty)
    % event_obj    Handle to event object
    % output_txt   Data cursor text string (string or cell array of strings).

    pos = get(event_obj,'Position');
    output_txt = {['X: ',num2str(pos(1),'%1.4f')],...
        ['Y: ',num2str(pos(2),'%1.4f')]};

    if exist('vline','file')==2
        try
            dcm = datacursormode(gcf);
            cc = dcm.CurrentCursor;
            dcs = findall(gca,'Type','hggroup');
            for i = 1:length(dcs)
                if get(dcs(i),'Cursor')==cc
                    delete(dcs(i).UserData);
                    cc_num = i;
                end
            end
        catch 
        end

        p = vline(pos(1),'-r');%,num2str(cc_num));
        dcs(cc_num).UserData = p;
        dcs(cc_num).DeleteFcn = @dataCursorDelete;
    else
        warning('Vline is not installed. Get it here:')
        disp('<a href="https://www.mathworks.com/matlabcentral/fileexchange/1039-hline-and-vline">https://www.mathworks.com/matlabcentral/fileexchange/1039-hline-and-vline</a>')
    end

    % If there is a Z-coordinate in the position, display it as well
    if length(pos) > 2
        output_txt{end+1} = ['Z: ',num2str(pos(3),'%1.4f')];
    end
end

function dataCursorDelete(obj,event_obj)
    delete(obj.UserData);
    delete(obj);
end