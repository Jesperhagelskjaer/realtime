function [par] = cutRecalculateNCCTemplate(par,datum_,varargin)

tic
fprintf('%-20s','Cutting started')

if find(strcmp(varargin,'ext'))
    version = varargin{find(strcmp(varargin,'ext')) + 1}; %create better method
    if strcmp(version,'nrd')
        dataF = datum_.data_NRD_RAW;
    elseif strcmp(version,'csc')
        dataF = datum_.data_CSC_RAW;
    end
end




templateAverageBig = par.templateAverageBig;


chN = par.template{2};
chMain = par.template{3}; %change function
dataAdTempF = dataF; %change naming


ChSTD_Diff = std(diff(dataAdTempF),1);
fprintf('STD mainCH: %0.2f\n',ChSTD_Diff(chMain))

diffV = ChSTD_Diff(chMain)*2;

[~, minI] = min(templateAverageBig(:,chMain));
[~, maxI] = max(templateAverageBig(:,chMain));

minI = minI -1; %Sometimes there is a plateau
maxI = maxI +1; %Sometimes there is a plateau

if minI > maxI
    holder = minI;
    minI = maxI;
    maxI = holder; 
end

template = templateAverageBig(minI:maxI,:);

lengthLeff = par.maxL_template - size(template,1);
lengthTemplate = size(template,1);
for i = 1:lengthLeff
    value1_1 = abs(templateAverageBig(minI-1,chMain));
    value1_2 = abs(templateAverageBig(maxI+1,chMain));
    value1 = abs(templateAverageBig(minI,chMain)) - abs(templateAverageBig(minI-3,chMain)) ;
    value2 = abs(templateAverageBig(maxI,chMain)) - abs(templateAverageBig(maxI+3,chMain));
    if ( value1_1 > diffV || value1_2 > diffV )        
        if ( value1 > value2)
            minI = minI - 1;
            template = vertcat(templateAverageBig(minI,:), template );           
        else
            maxI = maxI + 1;
            template = vertcat(template, templateAverageBig(maxI,:));
        end
        lengthTemplate = lengthTemplate + 1;
    end
end
[template] = setValuesToZeroTemplate(par,template);

if strcmp(par.plotNCC_template,'Y')
    figure
    subplot(2,1,1)
    surf(template)
    subplot(2,1,2)
    surf(templateAverageBig)
end



par.reCalculateTemplate = template;
par.lengthTemplate = lengthTemplate;
time = toc;
fprintf('%-20s %2.2f %-10s\n', '- finished   - Elepased time',time,'seconds')

fprintf('STD mainCH: %0.2f\n',std(dataAdTempF(:,4)))

end
