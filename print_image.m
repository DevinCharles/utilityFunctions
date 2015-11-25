% Copyright (C) 2015  Devin C Prescott
function print_image(varargin)
% PRINT_IMAGE Print figure to pdf or png
%   PRINT_IMAGE(figure(1)) Prints figure(1)
%   PRINT_IMAGE(figure(1),[width height]) Prints figure one to specified
%   page size
%   PRINT_IMAGE(figure(1),[width height],path) Prints to the specified
%   path.
%
%   See also PRINT

FilterSpec = {'*.pdf';'*.png'};
DialogTitle = 'Save Figure As';
Format = {'-dpdf','-dpng'};

if ~any(size(varargin))
    disp('You need to input a figure to print');
    return
elseif nargin == 1
    PrnFig = varargin{1}(1);
    width = 11;
    height = 8.5;
    [FileName,PathName,FilterIndex] = uiputfile(FilterSpec,DialogTitle);
elseif nargin == 2
    PrnFig = varargin{1}(1);
    width = varargin{2}(1);
    height = varargin{2}(2);
    [FileName,PathName,FilterIndex] = uiputfile(FilterSpec,DialogTitle);
elseif nargin == 3
    PrnFig = varargin{1}(1);
    width = varargin{2}(1);
    height = varargin{2}(2);
    [PathName,FileName,ext] = fileparts(varargin{3});
    if ~(strcmpi(PathName(end),'\'))
        PathName = strcat(PathName,'\');
    end
    FileName = strcat(FileName,ext);
    if strfind(ext,'png')>0
            FilterIndex = 2;
    elseif strfind(ext,'pdf')>0
            FilterIndex = 1;
    end
end
    
set(PrnFig,'PaperUnits', 'inches',...
'PaperPosition', [0 0 width height],...
'PaperSize', [width height]);

 try
    print(PrnFig,Format{FilterIndex},strcat(PathName,FileName),...
        '-r300','-opengl');
    catch
        msg = 'Cannot write to Image File. Is it open in another program?';
        uiwait(errordlg(msg),2*60);
        try
            print(PrnFig,Format{FilterIndex},strcat(PathName,FileName),...
                '-r300','-opengl');
        catch
            msg = 'Error writing Image File. Please check the file.';
            uiwait(errordlg(msg),2*60);
        end
end