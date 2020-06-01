%% Initialize

crp_sub_num = 38;
crp_img_typ = 64;
crp_num_img = crp_sub_num * crp_img_typ;

crp_img_hei = 192;
crp_img_len = 168;
crp_img_sze = crp_img_hei * crp_img_len;

% 0 for male, 1 for female
crp_genders = -1*ones(crp_num_img,1);
women = [5 15 22 27 28 32 34 37];
for gnd = 1 : length(women)
    w_s = 1 + (women(gnd)-1)*64;
    w_e = women(gnd)*64;
    crp_genders(w_s:w_e) = 1;
end

crp_poses = ones(crp_num_img,1);
img_cnt = 1;
for img = 1 : crp_num_img/crp_img_typ
    for pose = 1 : crp_img_typ
        crp_poses(img_cnt) = pose;
        img_cnt = img_cnt + 1;
    end
end

crp_individuals = zeros(crp_num_img,1);
counter = 1;
for indv = 1 : 64 : crp_num_img
    crp_individuals(indv:counter*64) = counter;
    counter = counter+1;
end


%% Read in images, build X_crp

stem = sprintf('/Users/josephwilliams/Documents/MATLAB/CroppedYale/');

X_crp = zeros(crp_img_sze, crp_num_img);
crp_iter_num_img = 1;
for fld_nmb = 1 : crp_sub_num
    fld_name = sprintf('yaleB%02.f',fld_nmb);
    fld_path = [stem fld_name];
    cd(fld_path)
    
    clear fds
    clear crp_filename
    % This code borrowed from https://matlab.fandom.com/wiki/FAQ#How_can_I_process_a_sequence_of_files.3F
    fds = fileDatastore('*.pgm', 'ReadFcn', @importdata);
    crp_filename = fds.Files;
    for k = 1 : crp_img_typ
        X_crp(:,crp_iter_num_img) = reshape(imread(crp_filename{k}),crp_img_hei*crp_img_len,1);
        crp_iter_num_img = crp_iter_num_img + 1;
    end
end

cd /Users/josephwilliams/Documents/MATLAB

%% Verify that pixel information stored in X_crp correctly corresponds to provided images
% 2020 May 29 13:21: appears to work; consequently, commented out.

% crp_img_tst_num = 1+(27-1)*64 + 0;
% figure
% image(reshape(X_crp(:,crp_img_tst_num),crp_img_hei,crp_img_len))