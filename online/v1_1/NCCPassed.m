function [ jesper,data ] = bandWidthN( jesper,dataFilt,iNNC,iCHT,iCHTre,data)
%tic;
%fprintf('Volt. bandw. started   - ')


%check up on the filterShift

pNCC = jesper.passed;
windowT = abs(jesper.WindowN(iCHT))+abs(jesper.WindowP(iCHTre))-1;%-jesper.addV;%jesper.window;
windowT = -windowT:-1;

if strcmp(jesper.changeChannels,'YES')
    mChls = jesper.channelMapTo;
else
    mChls = jesper.mainChannel;
end

vB = jesper.voltageSTD_B;
vA = jesper.voltageSTD_A;

%removing index close to eachother by one sample

%pNCC(pNCC < 80) = [];

pNCCVoltage = 0;
i = 0;

%%instead of sum is any
for k = 1:length(pNCC)
    if 0
        figure
        surf(dataFilt(pNCC(k)+windowT,:))
    end
    %test if each channel is with the band (any). (All) is used all channel
    %is within the band
    if (all(any(dataFilt(pNCC(k)+windowT,mChls) < vB )) && all(~any(dataFilt(pNCC(k)+windowT,mChls) < vA)))
        i = i + 1;
        pNCCVoltage(i) = pNCC(k);
        if 0
            figure
            subplot(1,2,1)
            surf(dataFilt(pNCC(k)+windowT,mChls))
            title('Passed')
            view(90,0)
            subplot(1,2,2)
            surf(dataFilt(pNCC(k)+windowT,:))
            view(-180,0)
        end
    else
        if 0
            figure
            title('not Passed')
            subplot(1,2,1)
            surf(dataFilt(pNCC(k)+windowT,mChls))
            view(90,0)
            subplot(1,2,2)
            surf(dataFilt(pNCC(k)+windowT,mChls))
            view(-180,0)
        end
    end  
    
end
data.pNCCVoltage = pNCCVoltage;        
data.pNCC = pNCC;
jesper.pNCCVoltage = pNCCVoltage;        
jesper.pNCC = pNCC;
jesper.passed = pNCCVoltage;
%time = toc;
%fprintf('   finished. Elapsed time: %0.2f seconds\n',time);
end


