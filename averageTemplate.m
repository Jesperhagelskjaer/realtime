function averageTemplate(par,data,varargin)
if nargin > 2
    if varargin{1} > varargin{2}
    fprintf('Error - start is coming after end')
    else
    start = varargin{1};
    end
    endC = size(data,3);
    if varargin{2} > size(data,3)
        endC = size(data,3);
    else
        endC = varargin{2};
    end
else
    start = 1;
    endC = size(data,3);
end



figure
surf(mean(data(:,:,start:endC),3))
title(['Template JSearch   ',par.path(34:end-1),'    light: ',num2str(endC-start)])
xlabel('Channels')
ylabel('Time [samples]')
zlabel('Voltage [uV]')
end

