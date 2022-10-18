% Observed
figure; hold on
xlabel 'Production Entropy'; ylabel 'Probability'
title 'Production Entropy Distribution for Bootstrapped Transitions'
set(gca,'FontSize',14)
histogram(H(1).obs,'FaceColor',clr(1),'Normalization','probability')
histogram(H(2).obs,'FaceColor',clr(2),'Normalization','probability')
histogram(H(3).obs,'FaceColor',clr(3),'Normalization','probability')
histogram(H(4).obs,'FaceColor',clr(4),'Normalization','probability')
histogram(H(5).obs,'FaceColor',clr(5),'Normalization','probability')
legend({'Gr1','Gr4','Gr5','Gr6','Gr9'})

%% Observed vs Null
figure; 

subplot(3,3,4); hold on;
xlabel 'Production Entropy'; ylabel 'Probability'
title 'Observed vs. Null Entropy Distribution - Group 1'
set(gca,'FontSize',14)
histogram(H(1).obs,'FaceColor','r','Normalization','probability')
histogram(H(1).null,'FaceColor','b','Normalization','probability')
legend({'Observed','Null'})

subplot(3,3,2); hold on;
xlabel 'Production Entropy'; ylabel 'Probability'
title 'Observed vs. Null Entropy Distribution - Group 4'
set(gca,'FontSize',14)
histogram(H(2).obs,'FaceColor','r','Normalization','probability')
histogram(H(2).null,'FaceColor','b','Normalization','probability')
legend({'Observed','Null'})

subplot(3,3,5); hold on;
xlabel 'Production Entropy'; ylabel 'Probability'
title 'Observed vs. Null Entropy Distribution- Group 5'
set(gca,'FontSize',14)
histogram(H(3).obs,'FaceColor','r','Normalization','probability')
histogram(H(3).null,'FaceColor','b','Normalization','probability')
legend({'Observed','Null'})

subplot(3,3,8); hold on;
xlabel 'Production Entropy'; ylabel 'Probability'
title 'Observed vs. Null Entropy Distribution - Group 6'
set(gca,'FontSize',14)
histogram(H(4).obs,'FaceColor','r','Normalization','probability')
histogram(H(4).null,'FaceColor','b','Normalization','probability')
legend({'Observed','Null'})

subplot(3,3,6); hold on;
xlabel 'Production Entropy'; ylabel 'Probability'
title 'Observed vs. Null Entropy Distribution- Group 9'
set(gca,'FontSize',14)
histogram(H(5).obs,'FaceColor','r','Normalization','probability')
histogram(H(5).null,'FaceColor','b','Normalization','probability')
legend({'Observed','Null'})
