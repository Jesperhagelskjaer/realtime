function [datum] = filterMain(par,data,datum)

if strcmp(par.filtertype{1},'Y') 

tic
fprintf('%-20s','Filtering started')
type = par.filtertype{2};

if (strcmp(type,'butter')) %% No correction since Dsort is based on butterworth filter
    dataF = filterButter(par,data); %butterworth
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
datum.dataF = dataF;

time = toc;
fprintf('%-20s %2.2f %-10s\n', '- finished   - Elepased time',time,'seconds')

end
end

