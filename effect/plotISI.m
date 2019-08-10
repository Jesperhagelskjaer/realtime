function [] = plotISI(rez)

for i =1:size(rez{1}.rez.M_template,3)
wv_ccg(rez{1}.rez,i)
end
end


