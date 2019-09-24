function [datum] = correlate_main(par,datum,rez) %NCC.,NSSD(inputArg1,inputArg2)


  [datum] = correlate_clusters(par,datum,'method','NSSD'); %NCC.,NSSD

try
    datum.template_mean_MClust;
    [datum] = correlationSpikeTime(par,rez,datum);  
catch
    [datum] = correlationSpikeTime_D_J(par,rez,datum);  
    
    
end

end

