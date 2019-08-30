function [datum_] = filterMain(par_,datum_,varargin)

if strcmp(par_.filtertype{1},'Y')
    
    if any(find(strcmp(varargin,'OpenEphys')))
        data = datum_.CSC_RAW; %create better method
    end
    
   
    
    tic
    fprintf('%-20s','Filtering started')
    type = par_.filtertype{2};
    
    if (strcmp(type,'butter')) %% No correction since Dsort is based on butterworth filter
        dataF = filterButter(par_,data); %butterworth
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
    datum_.CSC_F = dataF;
    
    time = toc;
    fprintf('%-20s %2.2f %-10s\n', '- finished   - Elepased time',time,'seconds')
end
end


