function [par] = minMaxHeight2D(par,datum_,rez,varargin)

tic
fprintf('%-20s','Cutting amplitude started')

if find(strcmp(varargin,'ext'))
    version = varargin{find(strcmp(varargin,'ext')) + 1}; %create better method
    if strcmp(version,'nrd')
        dataF = datum_.data_NRD_F;
    elseif strcmp(version,'csc')
        dataF = datum.data_CSC_F;
    end
end





[par] = calMinMax(par,dataF,rez);

indexCheck = par.passed;
cutRange = par.cutRange;
holderCut = [];
for k = 1:length(indexCheck)
    if all(par.holder(k,:) <  cutRange  )
        holderCut = [holderCut; par.holder(k,:)];
    else
        indexCheck(k) = nan; %can be made better
    end
    
end

indexCheck(isnan(indexCheck)) = [];
par.passed = indexCheck;

if 1
    lgt1 = length(par.template{2});
    figure('NumberTitle', 'off', 'Name','Cutting in amplitude');
    
    for i = 1:length(par.template{2})
        
        if strcmp(par.useBitmVolt,'Y')
            binranges = -300:10:50;
            xString = 'Volt [uV]';
        else
            binranges = -2000:10:50;
            xString = '[Bits]';
        end
        
        [bincounts2] = histc(par.holder(:,i),binranges);
        [bincounts3] = histc(holderCut(:,i),binranges);
        
        
        subplot(lgt1,2,1+2*(i-1))
        bar(binranges,bincounts2,'histc')
        plotSettingsSub(i,3,xString)
        title('Before Cut')
        %xlim([-300 50])
        subplot(lgt1,2,2+2*(i-1))
        bar(binranges,bincounts3,'histc')
        %plotSettingsSub(i,5,xString)
        title('After Cut')
        %xlim([-300 50])
    end
end
%plotSumPassed(par,dataF,rez,'After Cut',0)


time = toc;

fprintf('%-20s %2.2f %-10s\n', ' - finished - Elepased time:',time,'seconds')

fprintf('passed after Cut %d:\n',length(holderCut))
end




