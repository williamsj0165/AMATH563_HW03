%% Average Faces

figure
imagesc( reshape( mean(X_crp,2),crp_img_hei,crp_img_len))
ttl_str = sprintf('Average Face from Cropped Dataset');
title(ttl_str, 'fontsize',20)

figure
imagesc( reshape( mean(X_unc,2),unc_img_hei,unc_img_len))
ttl_str = sprintf('Average Face from Uncropped Dataset');
title(ttl_str, 'fontsize',20)

%%

men = 1;
wom = 1;
X_men = zeros(crp_img_sze,30);
X_wom = zeros(crp_img_sze,8);
for i = 1 : length(crp_genders)
    if crp_genders(i) == -1
        X_men(:,men) = X_crp(:,i);
        men = men + 1;
    elseif crp_genders(i) == 1
        X_wom(:,wom) = X_crp(:,i);
        wom = wom + 1;
    else
        fprintf('\n********\nError in creating male and female data matrices.\n********\n')
    end
end

figure
imagesc( reshape( mean(X_men,2),crp_img_hei,crp_img_len))
ttl_str = sprintf('Average Male Face from Cropped Dataset');
title(ttl_str, 'fontsize',20)

figure
imagesc( reshape( mean(X_wom,2),crp_img_hei,crp_img_len))
ttl_str = sprintf('Average Female Face from Cropped Dataset');
title(ttl_str, 'fontsize',20)
