function [datum] = main_trace(par_,rez_,datum,varargin)

if any(strcmp(varargin,'dsort'))
    datum = traceDSort(par_,rez_,datum);
end 

if  any(strcmp(varargin,'MClust'))
    datum = traceMClust(par_,datum);
end 

if  any(strcmp(varargin,'JSearch'))
    datum = traceJSearch(par_,datum,'type','csc');
end 


end

