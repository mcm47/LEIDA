function [outdata] = lei_gr_kl_entropy(Data)

% Computes the group level entropy by averaging the transition
% matrices of subjects belonging to the same group and then calculates
% KL entropy

n_sub = length(Data);
noclust=max(unique(Data(1).filteredID));

Grp=[Data.Grp]; % get group of each subject
Transit=reshape([Data.CorrPartTransit],noclust,noclust,n_sub); %get transition matrix for each subject

ug=unique(Grp);

% Group entropies
for i=1:length(ug)
    GrpTr(:,:,i)=mean(Transit(:,:,find(Grp==ug(i))),3); % get average transition matrix for each group
end

for gr=1:length(ug)
        
    dumH=0;
    for k=1:noclust
        for i=1:noclust
            if k==i
                continue
            else
                ent(k,i)=GrpTr(k,i,gr) * log10(GrpTr(k,i,gr)/GrpTr(i,k,gr));
                dumH=dumH+ent(k,i);
            end
        end
    end
    
     for cc1=1:noclust
        for cc2=1:noclust
            TT(cc1,cc2)=ent(cc1,cc2)+ent(cc2,cc1); % Sum the symmettric entropies
        end
     end
    
    GrEnt(gr).AsymEntropyMatrix=ent; % Entropy matrix of the groups
    GrEnt(gr).SymEntMatrix=TT;
    GrEnt(gr).TotalEntropy=dumH; % Total entropy of the groups
    
end

outdata=GrEnt;

end

