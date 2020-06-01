svm = fitcecoc(X_crp_train',X_crp_train_lbl);
preds_svm = predict(svm,X_crp_test');
diffs_svm = preds_svm-X_crp_test_lbl;
nmb_correct_svm = zeros(crp_num_img - train_number,1);
for i = 1 : crp_num_img - train_number
    if diffs_svm(i) ~= 0 % if the prediction was NOT correct
        nmb_correct_svm(i) = 0;
    elseif diffs_svm(i) == 0 % if the prediction WAS correct
        nmb_correct_svm(i) = 1; 
    end
end
prct_correct_svm(K) = sum(nmb_correct_svm) / (crp_num_img - train_number) * 100;
    