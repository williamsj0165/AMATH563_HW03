%% Reading in the images

fprintf('\nReading in the uncropped images...\n')
run Unc_00_ReadIn.m

fprintf('\nReading in the cropped images...\n\n')
run Crp_00_ReadIn.m


%% SVD & SVD Analysis

run AvgFaces.m

run Initial_SVD.m


%% 2.1 Face Classification
% use cropped images
tic
run Individual_Classify.m
toc
%% 2.2 Gender Classification
% use cropped images
tic
run Gender_Classify.m
toc

%% Plotting results from Face/Gender Classification

figure
hold on
plot(train_prct_vect,class_lin_dat(:,1), 'r.--', 'markersize',15, 'linewidth', 2)
% plot(train_prct_vect,class_qd_dat(:,1),  'b.--', 'markersize',15, 'linewidth', 2)
plot(train_prct_vect,svm_dat(:,1),       'g.--', 'markersize',15, 'linewidth', 2)
% plot(train_prct_vect,bayes_dat(:,1),     'm.--', 'markersize',15, 'linewidth', 2)
axis([0 100 0 100])

xlabel('Training %', 'fontsize',20)
ylabel('Accuracy', 'fontsize',20)
% ttl_str = sprintf('Gender Classification Task:\nTraining Prc. vs. Accuracy, k = %d, r = %d',nmb_trials,rank_recon_crp);
ttl_str = sprintf('Face Classification Task:\nTraining Prc. vs. Accuracy, k = %d, r = %d',nmb_trials,rank_recon_crp);
title(ttl_str, 'fontsize',20);

lgd_1 = sprintf('Diaglinear Disc.');
% lgd_2 = sprintf('Diagquadratic Disc.');
lgd_3 = sprintf('SVM');
% lgd_4 = sprintf('Naive Bayes');
% legend(lgd_1,lgd_2,lgd_3,lgd_4, 'location','southeast', 'fontsize',12)
legend(lgd_1,lgd_3, 'location','southeast', 'fontsize',12)


%% 2.3 Unsupervised Algorithms

run Unsupervised_Algs.m



