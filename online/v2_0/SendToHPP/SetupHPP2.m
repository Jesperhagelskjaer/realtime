function [] = SetupHPP2(par)
%% This Script connects to the real-time neuron detector version 1.7 
durationSec = 300; 
% Template length and width 
tempLength = par.lengthTemplate; % Max. 25
tempWidth = length(par.mainChannel) ; % Max. 5
% Template name
tempName = '33261004.bin';
tempNr = 1;
threshold = par.threshold;

%gradient = 25; % NOT USED Ver. 4.x
% Coherency min/max limits for template to be valid
choherencyMin = par.stdValue(1)*100;  %deelete 100
choherencyMax = par.stdValue(2)*100;  %deelete 100

% Template channel mappings
mapping = par.mainChannel;   
% Template peak max. limits for each mapped channel
peakMaxLimits = ones(1,length(par.mainChannel))*22000; % [100,100,100,100];
% Template peak min. limits for each mapped channel
peakMinLimits = ones(1,length(par.mainChannel),1)*-22000; %[-500,-500,-500,-500];
% Template min/max difference above limits for each mapped channels
peakDiffLimits = [0 0 0]; par.cutRange *-1; %(does he take the abs????)
% Sending only one template
numTemplates = 1;

Path = '';
%template1 = loadFile(Path, tempName, [tempWidth tempLength], 'float');
template1 = par.templateToUpload';
figure, surf(template1);
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
%reply = SendCmd(t, sprintf('s,g,%d,%d', tempNr, gradient)) % Set template gradient 
reply = SendCmd(t, sprintf('s,b,%d,%d,%d', tempNr, choherencyMin, choherencyMax)) % Set template coherency limits
cmdMap = CreateArrayCmd('m', tempNr, mapping); % Create mapping command
reply = SendCmd(t, cmdMap)         % Set template channel map
cmdPeakMax = CreateArrayCmd('h', tempNr, peakMaxLimits);
reply = SendCmd(t, cmdPeakMax)     % Set template peak max. limits
cmdPeakMin = CreateArrayCmd('l', tempNr, peakMinLimits);
reply = SendCmd(t, cmdPeakMin)     % Set template peak min. limits
cmdPeakMin = CreateArrayCmd('a', tempNr, peakDiffLimits);
reply = SendCmd(t, cmdPeakMin)     % Set template peak diff. limits

reply = SendCmdTime(t, 'g,c', 1)   % Reads configuration, wait 1 sec for answer
pause(3);                           % Check that the configuration in USB terminal window

%reply = SendCmdTime(t, sprintf('s,o,DATAFINE.bin,%d,',durationSec*30000), durationSec/2) % fs = 30 kHz waits 2 sec to load file
%reply = SendCmdTime(t, sprintf('s,o,DATA.bin,%d,',durationSec*30000), durationSec/2) % fs = 30 kHz waits 2 sec to load file

reply = SendCmd(t, sprintf('s,e,%d,', 30)) % test time 240 sec.
reply = SendCmd(t, 'b');           % Set to begin processing neuron samples

%pause();
%reply = SendCmd(t, 'e');           % Set to terminate processing samples




end
