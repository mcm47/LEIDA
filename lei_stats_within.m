function [Stats] = lei_stats_within(H,cl)

% One needs to run NewSignificanceTest_Murat_probabilities.m to get H

% lei_stats_within computes within group statistics for all groups

%   indat : Data structure that includes all production entropy values


obsdata=H(cl).boh; obsdata=obsdata(:,:,cl); % removes all zero pages
nulldata=H(cl).bnh; nulldata=nulldata(:,:,cl); % removes all zero pages

gr=size(obsdata,2);

for grp=1:gr

%% Assign data

Hobs=obsdata(:,grp);
Hnull=nulldata(:,grp);

%% Wilcoxon Signed Rank

% [p] = signrank(Hobs,Hnull);

[p, h, st]= signrank(Hobs,Hnull);
WSR(grp)=st.zval;

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

ROCp(grp)=pvalue;

%% z-score (Cohen's D)

mobs= mean( Hobs );
vobs = var( Hobs );

mnull = mean( Hnull );
vnull = var( Hnull);

zscore(grp) = (mobs - mnull) / sqrt( vobs + vnull);


%% Non-parametric Estimator (Aw)

S=0;

for i=1:length(Hobs)
   S= S + length(find(Hobs(i)>Hnull)) + 0.5 * length(find(Hobs(i)==Hnull)) ;
end

Aw(grp)=S/(100^2);
Aw_pA(grp)=1-Aw(grp);

end

Stats.WSR=WSR;
Stats.ROCp=ROCp;
Stats.Z=zscore;
Stats.Aw=Aw;
Stats.Aw_pa=Aw_pA;
end

