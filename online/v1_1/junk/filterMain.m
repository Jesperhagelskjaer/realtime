function [ par,datum] = filterMain(par,dataRAW,datum )
tic
fprintf('%-20s','Filtering started')
type = par.filtertype;

if (strcmp(type,'butter')) %% No correction since Dsort is based on butterworth filter
    dataFilt1 = filterButter(par.fslow(iFilL),par.fshigh(iFilH),dataRAW,par); %butterworth
    par.filtershift = par.order/2;
elseif (strcmp(type,'ellip'))
    dataFilt1 = filterEllip(par.fslow(iFilL),par.fshigh(iFilH),dataRAW,par); %butterworth
elseif (strcmp(type,'rect'))
    par.filtershift = par.TAPS/2; %Due to the delayline
    dataFilt1 = filterRect(par.fslow(iFilL),par.fshigh(iFilH),dataRAW,par); %rect
elseif (strcmp(type,'filterCpp'))
    par.filtershift = par.order;
    filterCheckCpp(dataRAW);
else
    printf("Wrong filter")
    exit();
end

% if par.GT > 0
%     par.GT = par.GT + par.filtershift;
%     plotAddTemplateData(par,dataFilt1)
% 
% end


datum.dataF = dataFilt1;
time = toc;
fprintf('%-20s %2.2f %-10s\n', '- finished   - Elepased time',time,'seconds')
end

%par.filtershift = 0; butter