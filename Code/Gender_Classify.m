%% Gender Classification

%% Setup

rank_recon_crp = 400;
[U_crp,S_crp,V_crp] = svd(X_crp,'econ');
V_crp = conj(V_crp)';

crp_ft_spc = V_crp(1:rank_recon_crp,:);

%% Analysis

train_prct_vect = [5 10:10:90 95];

class_lin_dat = zeros(length(train_prct_vect),1);
class_qd_dat  = zeros(length(train_prct_vect),1);
svm_dat       = zeros(length(train_prct_vect),1);
bayes_dat     = zeros(length(train_prct_vect),1);
for trn_iter = 1 : length(train_prct_vect)
    train_prct = train_prct_vect(trn_iter); % percent to train on; between 0 and 100
    fprintf('\n Training percent val = %d',train_prct)
    train_number = round(crp_num_img * train_prct/100);

    nmb_trials = 20;
    prct_correct_class_lin = zeros(nmb_trials,1);
    prct_correct_class_qd  = zeros(nmb_trials,1);
    prct_correct_svm       = zeros(nmb_trials,1);
    prct_correct_bayes     = zeros(nmb_trials,1);
    for K = 1 : nmb_trials
        fprintf('\n%d',K)

        run Gender_Bld_Trn_Tst.m

        run mthd_classify_lin.m
        run mthd_classify_qd.m
        run mthd_svm.m
        run mthd_Bayes.m

    end
    class_lin_dat(trn_iter) = mean(prct_correct_class_lin);
    class_qd_dat(trn_iter)  = mean(prct_correct_class_qd);
    svm_dat(trn_iter)       = mean(prct_correct_svm);
    bayes_dat(trn_iter)     = mean(prct_correct_bayes);
end

