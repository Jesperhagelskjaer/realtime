function [] = setupHPPmatlab(jesper)
%% This Script connects to the real-time neuron detector version 1.7 
durationSec = 100; 
% Template length and width 
%tempLength = jesper.WindowP + abs(jesper.WindowN ) ; % Max. 17
%tempWidth = length(jesper.mainChannel{1}); % Max. 9
% Template name
tempName = '11011608.bin';
tempNr = 1;
threshold = jesper.threshold;
gradient = abs(min(jesper.gradVal{1}));
% Template channel mappings
mapping = jesper.mainChannel{1}-1;
% Template peak max. limits for each mapped channel
peakMaxLimits = ones(1,length(jesper.mainChannel{1}))*22000; % [100,100,100,100];
% Template peak min. limits for each mapped channel
peakMinLimits = ones(1,length(jesper.mainChannel{1}),1)*-22000; %[-500,-500,-500,-500];
% Sending only one template
numTemplates = 1;


template1 = jesper.templateToUpload';
figure,
if (length(mapping) == 1)
    plot(template1);
else
    surf(template1);
end
    ylabel('Channels');
xlabel('Samples');
title(['Template 1 - ' tempName]);

%pause();

% sends setup commands for using pulse test generator
port = 7;
t = tcpclient('192.168.1.10', port, 'Timeout', 3);
reply = SendCmd(t, 'g,v')          % Read version number, expected ver. 1.7
reply = SendCmd(t, 's,p,1')        % Neuron data from SD card (2) or HPP (1)
reply = SendCmd(t, sprintf('s,n,%d', numTemplates)) % Set number of templates to use

cmdTemplate1 = CreateTemplateCmd(template1, tempNr); % Create command to update template
reply = SendCmd(t, cmdTemplate1)   % Sets template data
reply = SendCmd(t, sprintf('s,t,%d,%f', tempNr, threshold)) % Set template thredshold 
reply = SendCmd(t, sprintf('s,g,%d,%d', tempNr, gradient)) % Set template gradient 
cmdMap = CreateArrayCmd('m', tempNr, mapping); % Create mapping command
reply = SendCmd(t, cmdMap)         % Set template channel map
cmdPeakMax = CreateArrayCmd('h', tempNr, peakMaxLimits);
reply = SendCmd(t, cmdPeakMax)     % Set template peak max. limits
cmdPeakMin = CreateArrayCmd('l', tempNr, peakMinLimits);
reply = SendCmd(t, cmdPeakMin)     % Set template peak min. limits

%reply = SendCmdTime(t, sprintf('f,u,FIR.bin,%d', jesper.TAPS*jesper.spatial*4),10)

%reply = SendCmdTime(t, sprintf('f,u,FIR.bin'),10)  ,%d', jesper.TAPS*jesper.spatial*4),10)


reply = SendCmdTime(t, 'g,c', 1)   % Reads configuration, wait 1 sec for answer
reply = SendCmdTime(t, 's,p', 1)   % real trigger
reply = SendCmdTime(t, 's,w', 0)   % save filtered data
pause(3);                          % Check that the configuration in USB terminal window

%reply = SendCmdTime(t, sprintf('s,o,DATAFINE.bin,%d,',durationSec*30000), durationSec/2) % fs = 30 kHz waits 2 sec to load file
%reply = SendCmdTime(t, sprintf('s,o,DATA.bin,%d,',durationSec*30000), durationSec*2) % fs = 30 kHz waits 2 sec to load file

reply = SendCmd(t, sprintf('s,e,%d,', 36000)) % test time 240 sec.
%reply = SendCmd(t, 'b');           % Set to begin processing neuron samples