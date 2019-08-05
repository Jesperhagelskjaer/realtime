function [] = calTempSum(par,rez,dataRAW)

spatial = par.chs;
window = -par.before:par.after;

count = 1;
clustNr = [];
if strcmp(par.template_LFP{2},'all')
    clustNr = unique(rez.st(:,8)); % 26 22 13  30 21]
else
    for i = 1:size(rez.Chan,1)
        if any(intersect(rez.Chan{i},par.template_LFP{2}))
            clustNr = [clustNr i];
        end
    end
end


fullNameCNS = strcat(par.path{1},par.e_str,'\CSC',num2str(par.chs(1)),'.ncs');
[~, ~, ~,~, Samples, ~] = Nlx2MatCSC(fullNameCNS,[1 1 1 1 1], 1, 1, [] );

[m,n] = size(Samples); %can be be combined with below
sizeR = length(reshape(Samples,[1,n*m]))+count;

for icell_1 = 1:length(clustNr)
    
    Cluster1 = clustNr(icell_1);
    
    T1 = rez.st(rez.st(:,end)==Cluster1,1);  
    
    
    T1_before = T1(logical(T1 < sizeR));   
    T1_after  = T1(logical(T1 > sizeR));
         
    for k = 1:length(T1_before)
        templateStackBefore(:,:,k) = dataRAW(T1_before(k)+window,:);
    end
    
    for k = 1:length(T1_after)
        templateStackAfter(:,:,k) = dataRAW(T1_after(k)+window,:);
    end
    
    templateAve{1,icell_1} = mean(templateStackBefore,3);
    templateAve{2,icell_1} = mean(templateStackAfter,3);
    
end


for ii = 1:size(templateAve,2)
    figure
    if (spatial == 1)
        subplot(2,1,1)
        title('Before')
        plot(templateAve{1,ii})
        subplot(2,1,2)
        plot(templateAve{2,ii})
        title('After')
    else
        subplot(2,1,1)
        title('Before')
        surf(templateAve{1,ii})
        subplot(2,1,2)
        surf(templateAve{2,ii})
        title('After')
    end


    sgtitle(['Templates - ',num2str(templateSe(ii))])

    name = strcat(par.path{1}(1:end-4),'figure\','LFP_effect_',num2str(par.template),'_',num2str(i));
    saveas(h,name,'fig')

end
end


