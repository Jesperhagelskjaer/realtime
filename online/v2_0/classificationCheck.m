function [] = classificationCheck(par,dataF_Temp,dataF,rez)

if strcmp(par.changeChannels,'Y')

    [f1W] = vivoGTChan(par,dataF_Temp,rez);
else
    classificationDsort(par,dataF,rez)

end

