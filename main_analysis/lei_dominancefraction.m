function [outdata] = lei_dominancefraction(Data)
% Dominance fraction, Individual lifetime, and average lifetime is
% calculated


n_sub=length(Data);
noclust=max(unique (Data(1).filteredID));

for kk=1:n_sub
    
    
    for n=1:noclust % based on number of cluster (brain states)

    df(n)=sum(Data(kk).filteredID==n)/length(Data(kk).filteredID);
    end
    
    Data(kk).Dominancefrac=df;

end

outdata = Data;

end
