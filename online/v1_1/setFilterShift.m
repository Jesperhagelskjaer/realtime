function [ jesper ] = setFilterShift(jesper)

type = jesper.filtertype;
%fprintf('Filter\n')
if (strcmp(type,'butter')) %%
    jesper.shift = -30;
    jesper.filtershift = 0;
 elseif (strcmp(type,'rect'))
    jesper.shift = 60;
    jesper.filtershift = 30;
elseif (strcmp(type,'filterCpp'))
    jesper.shift = 0;
    jesper.filtershift = 30;
elseif (strcmp(type,'ellip'))
    jesper.shift = 0;%not correct
    jesper.filtershift = 0; %not correct
else
    fprintf("Wrong filter")
    exit();
end



end

