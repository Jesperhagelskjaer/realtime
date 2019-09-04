function [] = extraCheckTime(par,rez,datum,cl)

t_MS = datum.tSpikes_MClust{cl};
C_Total = unique(rez.st(:,end));
jitter = par.jitter;

for i = 1:length(C_Total)
    cl = C_Total(i);
    CS_T_DS = rez.st(find(rez.st(:,end) == cl));
    count = 0;
    for ii = 1:length(t_MS)
        
        index = floor(find(t_MS(ii)- jitter < CS_T_DS  & t_MS(ii) + jitter > CS_T_DS));
        if ~isempty(index)
            count = count + 1;
        end
    end
    CT_SI_DS(i) = count;
end

end

