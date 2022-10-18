%% This script uses bootstrapping method to generate new sequences based on the observed brain transition dynamics of the groups
function [H] = lei_grandstats

no_clust=12;

lei_analyze % call this script to prepare the data

grlist=lei_grlist_prepare(Data); % average within each observer

nogrp=numel(grlist); % number of groups
grps=unique([Data.Grp]);

Nbootstrap = 1000 ; % the number of bootstrapped trajectory

for n=1:nogrp
   
   grp_nsub=length(find([Data.Grp]==grps(n))); % number of subject in a group
   
   len=grlist(n).ID;
   len=[len(1:end-1),len(2:end)];
   len=len(:,1)-len(:,2);
   len(len==0)=[];
   sim_len=length(len) ;
%    sim_len=grlist(n).ID)/grp_nsub; % simulation length (i.e., average duratin within a group)
   
   full_trans = grlist(n).pji; % full transition matrix of the group   
   null_trans=(full_trans+full_trans')/2; % null transition matrix of the group

   
   for k=1:Nbootstrap
        
   % Observed Transition Dynamics
   
   sim_traject = simulate(dtmc(full_trans),round(sim_len)); % simulate a markov-chain based on observed full transition probabiliy matrix and average duration
   sim_trans=[sim_traject(1:end-1), sim_traject(2:end)]; % generate a new transition list
   trans_count_table=histcounts2(sim_trans(:,1),sim_trans(:,2)); % get transition counts as a table
 
   
   trans_prob_table=trans_count_table/sum(trans_count_table(:)); % convert transition counts to proabibilities
   trans_prob_table=trans_prob_table-diag(diag(trans_prob_table)); % remove diagonal (i.,e, self-transitions)
   trans_prob_table=trans_prob_table/sum(trans_prob_table(:)); % scale transition probability table
   
   [t,a,s]=lei_kl_entropy(trans_prob_table);
   
   O(k)=t;
   OS(:,:,k)=s;

   % Null Transition Dynamics
  
    
   null_traject = simulate(dtmc(null_trans),round(sim_len)); % simulate a markov-chain based on null full transition probabiliy matrix and average duration
   null_sim_trans=[null_traject(1:end-1), null_traject(2:end)]; % generate a new transition list
   null_count_table=histcounts2(null_sim_trans(:,1),null_sim_trans(:,2)); % get transition counts as a table
%    
%    if (find(null_count_table==0))
%        null_count_table=null_count_table+1;
%    end
   
   null_prob_table=null_count_table/sum(null_count_table(:)); % convert transition counts to proabibilities
   null_prob_table=null_prob_table-diag(diag(null_prob_table)); % remove diagonal (i.,e, self-transitions)
   null_prob_table=null_prob_table/sum(null_prob_table(:)); % scale transition probability table
   
   [t,a,s]=lei_kl_entropy(null_prob_table);

   N(k)=t;
   NS(:,:,k)=s;
   end
   
   H(n).obs=O;
   H(n).obs_sym=OS;
   H(n).null=N;
   H(n).null_sym=NS;
end

return;

