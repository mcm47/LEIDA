function [Stats] = lei_stats_between(H,cl)
%LEI_FOURSTATS computes within group statistics for all groups

%   indat : Data structure that includes all production entropy values


obsdata=H(cl).boh; obsdata=obsdata(:,:,cl); % removes all zero pages
nulldata=H(cl).bnh; nulldata=nulldata(:,:,cl); % removes all zero pages

for cmp=1:2

%% Assign data

if cmp ==1
grp=[5 1]; % Gr 9 - Gr 1
elseif cmp==2
grp=[2 4]; % Gr 4 - Gr 6
end

Hobs=obsdata(:,grp(1));
Hnull=obsdata(:,grp(2));

%% Wilcoxon Rank Sum

% [p] = ranksum(Hobs,Hnull);
[p, h, st]= signrank(Hobs,Hnull);
WSR(cmp)=st.zval;

%% ROC based p-value

Hobs_overlap = Hobs (Hobs<max(Hnull) );
Hnull_overlap = Hnull ( Hnull>min(Hobs) );

C = sort( [Hobs_overlap' Hnull_overlap'] );   % vector of criteria


if ~isempty(C)

for i = 1 : numel(C)
    
    Hi(i) = sum( Hobs>C(i) ) / numel(Hobs);
    Fi(i) = sum( Hnull>C(i) ) / numel(Hnull);
    
end

Pi = Hi - Fi;
else
Pi=1;
end

pvalue = 1 - max(Pi);

ROCp(cmp)=pvalue;

%% z-score (Cohen's D)

mobs= mean( Hobs );
vobs = var( Hobs );

mnull = mean( Hnull );
vnull = var( Hnull);

zscore(cmp) = (mobs - mnull) / sqrt( vobs + vnull);


%% Non-parametric Estimator (Aw)

S=0;

for i=1:length(Hobs)
   S= S + length(find(Hobs(i)>Hnull)) + 0.5 * length(find(Hobs(i)==Hnull)) ;
end

Aw(cmp)=S/(100^2);   
Aw_pA(cmp)=1-Aw(cmp);


end

Stats.WSR=WSR;
Stats.ROCp=ROCp;
Stats.Z=zscore;
Stats.Aw=Aw;
Stats.Aw_pa=Aw_pA;
end

