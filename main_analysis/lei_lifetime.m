function [outdata] = lei_lifetime(Data)
% Dominance fraction, Individual lifetime, and average lifetime is
% calculated

n_sub=length(Data);
noclust=max(unique (Data(1).filteredID));

for kk=1:n_sub
    ltdata=nan(length(Data(kk).filteredID),noclust);
    for n=1:noclust % based on number of cluster (brain states)

    a=(Data(kk).filteredID==n); % get a single brain state n
    cc=[];
    count=0;

    % calculate the lifetime
    for k=1:length(a)
        if a(k)==1
            count=count+1;
            if k==length(a)
                cc=[cc;count];
            end
        else
        cc=[cc;count];
        count=0;
        end
    end

    cc(cc==0)=[];
    ltdata(1:length(cc),n)=cc;
    Avlifetime(n)=nanmean(cc);
    
    Data(kk).Lifetime=ltdata';
    Data(kk).AvLifetime=Avlifetime';

    end
end

outdata = Data;
end

