function [WSRp, WSR, ROCp, zscore, Aw] = lei_stats_between_pairwise(H,cl)
%LEI_FOURSTATS computes within group statistics for all groups

%   indat : Data structure that includes all production entropy values

data=H(cl).pwh(cl);
data=data.pairH;

WSR=zeros(cl,cl,2);
WSRp=ones(cl,cl,2);
ROCp=ones(cl,cl,2);
zscore=zeros(cl,cl,2);
Aw=zeros(cl,cl,2);

for i=1:(cl-1)
    for j=(i+1:cl)
        
       
for cmp=1:2

%% Assign data

if cmp ==1
    grp=[5 1]; % Gr 9 - Gr 1
elseif cmp==2
    grp=[2 4]; % Gr 4 - Gr 6
end

Hobs=  squeeze(data(i,j,:,grp(1)));
Hnull= squeeze(data(i,j,:,grp(2)));

%% Wilcoxon Rank Sum

[p, h, st]= ranksum(Hobs,Hnull);
WSR(i,j,cmp)=st.zval;
WSRp(i,j,cmp)=p;

%% ROC based p-value

Hobs_overlap = Hobs (Hobs<max(Hnull) );
Hnull_overlap = Hnull ( Hnull>min(Hobs) );

C = sort( [Hobs_overlap' Hnull_overlap'] );   % vector of criteria


if ~isempty(C)

for ii = 1 : numel(C)
    
    Hi(ii) = sum( Hobs>C(ii) ) / numel(Hobs);
    Fi(ii) = sum( Hnull>C(ii) ) / numel(Hnull);
    
end

Pi = Hi - Fi;
else
Pi=1;
end

pvalue = 1 - max(Pi);

ROCp(i,j,cmp)=pvalue;

%% z-score (Cohen's D)

mobs= mean( Hobs );
vobs = var( Hobs );

mnull = mean( Hnull );
vnull = var( Hnull);

zscore(i,j,cmp) = (mobs - mnull) / sqrt( vobs + vnull);


%% Non-parametric Estimator (Aw)

S=0;

for ii=1:length(Hobs)
   S= S + length(find(Hobs(ii)>Hnull)) + 0.5 * length(find(Hobs(ii)==Hnull)) ;
end

Aw(i,j,cmp)=S/(100^2);    


end
    
    end
end
    
    % Multiple comparsion correction
    WSRp=WSRp*66;
    WSRp(WSRp>0.05)=nan;
    
    ROCp=ROCp*66;
    ROCp(ROCp>0.05)=nan;
    return
end

