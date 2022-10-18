function [outdata] = lei_transitions(Data) 

% Between brain states transition statistics

% Number of Full Transitions is the transition between each successive time points, thus includes wiwthin state transitions as well
% Number of Partial Transitions is the transition between different states

n_sub=length(Data);
noclust=max(unique (Data(1).filteredID));

for k=1:n_sub
    
    % Calculate number of transitions
    
    for p=1:noclust % based on number of cluster (brain states)

        c=find(Data(k).filteredID==p); % find indexes of LEIDAs labeled as brain state k
        cc=c+1; % get the next brain states of each brain state k
        
        if isempty(cc)
            continue
        elseif cc(end)>length(Data(k).filteredID) % check for the last datapoint to stay within the range
            cc(end)=[];
        end
    
        % get the label of next LEIDAS for each brain state k
        FullTransit=Data(k).filteredID(cc);
    
        PartTransit=FullTransit;
        cind=find(Data(k).filteredID(cc)==p);
        PartTransit(cind)=[]; % remove the LEIDAS labeled as brain state k

        for m=1:noclust
                   
            NoFullTrans(p,m)=length(find(FullTransit==m));
        
            if m==p % pass calculating the within brain state transition calculation
                continue
            else
            
                NoPartTrans(p,m)=length(find(PartTransit==m));
            
            end

        end
    
    
    end
    
Data(k).NoPartTransit=NoPartTrans;
Data(k).NoFullTransit=NoFullTrans;

end

outdata = Data;
end

