function [holder] =  clearAllExpectDatum(datum)

if isfield(datum,'data_NRD_RAW')
    holder = datum.data_NRD_RAW;
else
    holder = [];    
end

end