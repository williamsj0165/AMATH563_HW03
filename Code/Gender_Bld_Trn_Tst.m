imgs_indx_randomized = randperm(crp_num_img); % randomized list of the image indices

X_crp_train = zeros(rank_recon_crp,train_number);
X_crp_train_lbl = zeros(train_number,1);
for i = 1 : train_number
    X_crp_train(:,i) = crp_ft_spc(:,imgs_indx_randomized(i));
    X_crp_train_lbl(i) = crp_genders(imgs_indx_randomized(i));
end

X_crp_test = zeros(rank_recon_crp,crp_num_img - train_number);
X_crp_test_lbl = zeros(crp_num_img - train_number,1);
for i = 1 : crp_num_img - train_number
    X_crp_test(:,i) = crp_ft_spc(:,imgs_indx_randomized(train_number+i));
    X_crp_test_lbl(i) = crp_genders(imgs_indx_randomized(train_number+i));
end