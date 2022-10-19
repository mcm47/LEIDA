function [outdata] = lei_transitioncorrection_for_klentropy(Data)
% This function changes '0' with '1' in partial transition matrix so that
% it can be used in KL based entropy/asymmetry calculations.

n_sub=length(Data);

for sub=1:n_sub
    
    Data(sub).CorrNoPartTransit=(Data(sub).NoPartTransit+1); % add 1 to everywhere
    Data(sub).CorrNoPartTransit= Data(sub).CorrNoPartTransit - diag(diag(Data(sub).CorrNoPartTransit)); % remove diagonal values
    Data(sub).CorrPartTransit=Data(sub).CorrNoPartTransit/sum(Data(sub).CorrNoPartTransit(:));
end

outdata=Data; 

end

