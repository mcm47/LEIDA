% figure
% close all


%% WSR
WSR=reshape([Stats(3:16).WSR],5,14)';

subplot (2,2,1)
plot([3:16],WSR,'LineWidth',2)
% ylim ([-0.01 max(WSR(:))+0.02]); 
ylim auto
xticks ([3:16])
title 'Wilcoxon Signed Rank (z-val) - Observed vs. Null'
xlabel '# of cluster'
ylabel 'z-value'
grid on
yline (1.96,'LineWidth',2)
set(gca,'FontSize',14)
legend ({'Gr 1','Gr 4','Gr 5','Gr 6','Gr 9','p=.05'},'Location','se')

%% ROCp

ROCp=reshape([Stats(3:16).ROCp],5,14)';

ROCp2=ROCp;
ROCp2(ROCp2==0)=0.001; % change this

subplot (2,2,2)
plot([3:16],-log(ROCp2),'LineWidth',2)
% ylim ([-0.1 max(ROCp(:))+0.1]);
ylim auto
xticks ([3:16])
ymax=ceil(max(-log(ROCp2(:))));
yticks ([0:ymax])
yticklabels({[0:ymax-1],'\infty'})
title 'ROC based p - Observed vs. Null'
xlabel '# of cluster'
ylabel '-ln(p_{ROC})'
grid on
yline (-log(0.05),'LineWidth',2)
set(gca,'FontSize',14)
legend ({'Gr 1','Gr 4','Gr 5','Gr 6','Gr 9','p=.05'},'Location','se')

%% z-score (Cohen's D)

Z=reshape([Stats(3:16).Z],5,14)';

subplot (2,2,3)
plot([3:16],Z,'LineWidth',2)
ylim ([-0.01 max(Z(:))+0.5]);
xticks ([3:16])
title 'z-score (Cohens D)- Observed vs. Null'
xlabel '# of cluster'
ylabel 'z-norm'
grid on
set(gca,'FontSize',14)
legend ({'Gr 1','Gr 4','Gr 5','Gr 6','Gr 9'},'Location','northwest')

%% Non-parametric Aw

Aw=reshape([Stats(3:16).Aw_pa],5,14)';

Aw2=Aw;
Aw2(Aw2==0)=0.00001; % change this

subplot (2,2,4)
plot([3:16],-log(Aw2),'LineWidth',2)
% ylim ([min(Aw(:))-0.05 max(Aw(:))+0.05]);
ylim auto
xticks ([3:16])
ymax=ceil(max(-log(Aw2(:))));
yticks ([0:ymax])
yticklabels({[0:ymax-1],'\infty'})
title 'Non-parametric ES (Aw)- Observed vs. Null'
xlabel '# of cluster'
ylabel '-ln(p_{A})'
grid on
yline (-log(0.05),'LineWidth',2)
set(gca,'FontSize',14)
legend ({'Gr 1','Gr 4','Gr 5','Gr 6','Gr 9','p=.05'},'Location','se')
