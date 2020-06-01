preds_class_qd = classify(X_crp_test',X_crp_train',X_crp_train_lbl,'diagquadratic');
diffs_class_qd = preds_class_qd-X_crp_test_lbl;
nmb_correct_class_qd = zeros(crp_num_img - train_number,1);
for i = 1 : crp_num_img - train_number
    if diffs_class_qd(i) ~= 0 % if the prediction was NOT correct
        nmb_correct_class_qd(i) = 0;
    elseif diffs_class_qd(i) == 0 % if the prediction WAS correct
        nmb_correct_class_qd(i) = 1; 
    end
end

prct_correct_class_qd(K) = sum(nmb_correct_class_qd) / (crp_num_img - train_number) * 100;