nb = fitcnb(X_crp_train',X_crp_train_lbl);
preds_bayes = nb.predict(X_crp_test');
diffs_bayes = preds_bayes-X_crp_test_lbl;
nmb_correct_bayes = zeros(crp_num_img - train_number,1);
for i = 1 : crp_num_img - train_number
    if diffs_bayes(i) ~= 0 % if the prediction was NOT correct
        nmb_correct_bayes(i) = 0;
    elseif diffs_bayes(i) == 0 % if the prediction WAS correct
        nmb_correct_bayes(i) = 1; 
    end
end

prct_correct_bayes(K) = sum(nmb_correct_bayes) / (crp_num_img - train_number) * 100;