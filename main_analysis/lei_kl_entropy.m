function [tot_entr,asym_entr,sym_entr] = lei_kl_entropy(in1)
%LEI_KL_ENTROPY calculates entropy values for a given input transition
%matrix

% in1 : transition matrix

% tot_entr  : total entropy of the transition matrix
% asym_entr : asymetric entropy matrix for all pairs
% sym_entr  : symetric entropy matrix for all pairs

noclust=size(in1,1);
Transit=in1;

indH=0;
for k=1:noclust
        for i=1:noclust
            if k==i
                continue
            else
                ind_ent(k,i)=Transit(k,i) * log10(Transit(k,i)/Transit(i,k));
                indH=indH+ind_ent(k,i);
            end
        end
end
    
     for cc1=1:noclust
        for cc2=1:noclust
            TT(cc1,cc2)=ind_ent(cc1,cc2)+ind_ent(cc2,cc1); % Sum the symmettric entropies
        end
     end  


tot_entr  = indH;
asym_entr = ind_ent;
sym_entr = TT;


end

