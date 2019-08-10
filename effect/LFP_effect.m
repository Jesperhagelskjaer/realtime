function [] = LFP_effect(par,rezT)
  
    buff = fread(fid, [NchanTOT NTbuff], '*int16');

%     if strcmp(par.datatype , 'digiLynxCSC')
%         [dataRAW] = loadRawCSC_Data(par);
%     elseif strcmp(par.datatype , 'digiLynxNRD')
%         [dataRAW] = loadRawNRD_Data(par);
%     else
%         fprintf('Error in LFP_effect')    
%     end    
    
    calTempSum(par,rezT,dataRAW)
    
end

