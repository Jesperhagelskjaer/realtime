function [datum_] = filterMain(par_,datum_,varargin)

if strcmp(par_.filtertype{1},'Y')
    
    tic
    fprintf('%-20s','Filtering started')
    type = par_.filtertype{2};
    try
        for i = 1:2
            if i == 1
                data = datum_.CSC; %create better method
            else
                data = datum_.NRD; %create better method
            end
            
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
            
            if i == 1
                datum_.CSC_F = dataF;
            else
                datum_.NRD_F = dataF;
            end
        end
    catch
    end
end
time = toc;
fprintf('%-20s %2.2f %-10s\n', '- finished   - Elepased time',time,'seconds')
end



