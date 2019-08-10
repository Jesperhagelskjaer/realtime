function [] = gassuasianRaster(par_,rezT,RasterR1)

X = -par_.before:1:par_.after;

for i = 1:3
    figure
    histogram(X,RasterR1{1,i})
    
    
    
end

