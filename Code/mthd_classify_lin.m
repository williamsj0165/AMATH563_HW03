preds_class_lin = classify(X_crp_test',X_crp_train',X_crp_train_lbl,'diaglinear');
diffs_class_lin = preds_class_lin-X_crp_test_lbl;
nmb_correct_class_lin = zeros(crp_num_img - train_number,1);
for i = 1 : crp_num_img - train_number
    if diffs_class_lin(i) ~= 0 % if the prediction was NOT correct
        nmb_correct_class_lin(i) = 0;
    elseif diffs_class_lin(i) == 0 % if the prediction WAS correct
        nmb_correct_class_lin(i) = 1; 
    end
end

prct_correct_class_lin(K) = sum(nmb_correct_class_lin) / (crp_num_img - train_number) * 100;