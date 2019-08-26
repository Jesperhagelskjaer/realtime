function [par] = pathFolder()
if 1
    
    par.path                     = {'P:\AU256873\recording\2019-05-21_10-21-44\','L';...
                                    'P:\AU256873\recording\2019-05-21_10-55-05\','N'};...
        
elseif 0
    par.path                        = {'P:\AU256873\recording\2019-05-21_10-21-44\','L';... &
                                       'P:\AU256873\recording\2019-05-21_10-44-16\','N';...
                                       'P:\AU256873\recording\2019-05-21_10-55-05\','N'};...
        %                                    5 6 7 8
elseif 0
    par.path                    = {'P:\AU256873\recording\2019-07-09_12-23-51\','N';... % 'openEphys' only: where raw files are
        'P:\AU256873\recording\2019-07-09_13-16-56\','L';...; %light
        'P:\AU256873\recording\2019-07-09_12-23-51\','N'}; % 'openEphys' only: where raw files are
    %                                 ( 29 30 31 32)
elseif 0
    % par.path                    = {'P:\AU256873\recording\2019-08-13_11-49-51\','N';... % 'openEphys' only: where raw files are
    %                                'P:\AU256873\recording\2019-08-13_12-39-48\','L';...; %light
    %                                'P:\AU256873\recording\2019-08-13_13-18-47\','N'}; % 'openEphys' only: where raw files are
    %Template 10 ch 21 22 23 24
    
    %par.path                     = {'P:\AU256873\recording\2019-05-21_10-21-44\','L'}; %LFP
    %                               (5 6 7 8)
end

end

