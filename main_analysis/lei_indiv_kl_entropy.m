function [outdata] = lei_indiv_kl_entropy(Data)
%KL_ENTROPY calculates KL entropy/asymmetry for both between states and the
% total entropy

n_sub=length(Data);
noclust=max(unique(Data(1).filteredID));

for k=1:n_sub
    Grp(k)=Data(k).Grp;
    Transit(:,:,k)=Data(k).CorrPartTransit;
end

for sub=1:n_sub

% Individual Entropies    
indH=0;
    for k=1:noclust
        for i=1:noclust
            if k==i
                continue
            else
                ind_ent(k,i)=Transit(k,i,sub) * log10(Transit(k,i,sub)/Transit(i,k,sub));
                indH=indH+ind_ent(k,i);
            end
        end
    end
    
     for cc1=1:noclust
        for cc2=1:noclust
            TT(cc1,cc2)=ind_ent(cc1,cc2)+ind_ent(cc2,cc1); % Sum the symmettric entropies
        end
     end
     
    Data(sub).AsymEntropyMatrix=ind_ent;
    Data(sub).SymEntropyMatrix=TT;
    Data(sub).TotalEntropy=indH;
    
end

outdata=Data;

end

