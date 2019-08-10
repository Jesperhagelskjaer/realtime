function [data] = filterMain(par,data,string)

if (isfield(data,'NRD') && strcmp(string,'NRD'))

tic
fprintf('%-20s','Filtering started')
type = par.filtertype{2};

if (strcmp(type,'butter')) %% No correction since Dsort is based on butterworth filter
    dataF = filterButter(par,data.NRD); %butterworth
    %jesper.filtershift = jesper.order/2;
elseif (strcmp(type,'ellip'))
    %dataFilt1 = filterEllip(jesper.fslow(iFilL),jesper.fshigh(iFilH),dataRAW,jesper); %butterworth
elseif (strcmp(type,'rect'))
    %jesper.filtershift = jesper.TAPS/2; %Due to the delayline
    %dataFilt1 = filterRect(jesper.fslow(iFilL),jesper.fshigh(iFilH),dataRAW,jesper); %rect
elseif (strcmp(type,'filterCpp'))
    %jesper.filtershift = jesper.order;
    %filterCheckCpp(dataRAW);
else
    printf("Wrong filter")
    exit();
end
data.dataF = dataF;

time = toc;
fprintf('%-20s %2.2f %-10s\n', '- finished   - Elepased time',time,'seconds')

end
end

