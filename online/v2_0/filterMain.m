function [datum] = filterMain(par,datum,varargin )

if strcmp(par.filtertype{1},'Y')

    tic
    fprintf('%-20s','Filtering started')
    if find(strcmp(varargin,'ext'))
        version = varargin{find(strcmp(varargin,'ext')) + 1}; %create better method
        if strcmp(version,'nrd')
            dataRAW = datum.data_NRD_RAW;
        elseif strcmp(version,'csc')
            dataRAW = datum.data_CSC_RAW;
        end
    end
     
    type = par.filtertype{2};
    
    if (strcmp(type,'butter')) %% No correction since Dsort is based on butterworth filter
        dataF = filterButter(par,dataRAW); %butterworth
    elseif (strcmp(type,'ellip'))
        dataF = filterEllip(par.fslow,par.fshigh,dataRAW,par); %butterworth
    elseif (strcmp(type,'rect'))
        dataF = filterRect(par.fslow,par.fshighdataRAW,par); %rect
    elseif (strcmp(type,'filterCpp'))
        filterCheckCpp(dataRAW);
    else
        printf("Wrong filter")
        exit();
    end
    
    if strcmp(version,'nrd')
        datum.data_NRD_F = dataF;
    elseif strcmp(version,'csc')
        datum.data_CSC_F=dataF;
    end
    
    time = toc;
    fprintf(' - finished - Elepased time, %2.2f seconds\n',time)
end
end
