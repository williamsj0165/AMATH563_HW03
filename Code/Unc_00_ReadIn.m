%% Initialize

unc_sub_num = 15;
unc_img_typ = 11;
unc_num_img = unc_sub_num * unc_img_typ;

unc_img_hei = 243;
unc_img_len = 320;
unc_img_sze = unc_img_hei * unc_img_len;

lst_img_typ = {
    'centerlight'
    'glasses'
    'happy'
    'leftlight'
    'noglasses'
    'normal'
    'rightlight'
    'sad'
    'sleepy'
    'surprised'
    'wink'
    };


%% Read in images, build X_unc

cd /Users/josephwilliams/Documents/MATLAB/yalefaces_uncropped/yalefaces

X_unc = zeros(unc_img_sze, unc_num_img);
unc_iter_num_img = 1;
for sub_num = 1 : unc_sub_num
    for img_typ = 1 : unc_img_typ
        unc_filename = sprintf('subject%s.%s', num2str(sub_num,'%02.f'),char(lst_img_typ(img_typ)));
        X_unc(:,unc_iter_num_img) = reshape(imread(unc_filename),unc_img_hei*unc_img_len,1);
        unc_iter_num_img = unc_iter_num_img + 1;
    end
end


%% Verify that pixel information stored in X_unc correctly corresponds to provided images
% 2020 May 20 12:27: appears to work; consequently, commented out.

% unc_img_tst_num = 165;
% figure
% image(reshape(X_unc(:,unc_img_tst_num),unc_img_hei,unc_img_len))

