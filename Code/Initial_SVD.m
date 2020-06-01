%% SVD & SVD Analysis

% Finding ranks
rank_X_crp = rank(X_crp);
fprintf('\nRank of X_crp is %d',rank_X_crp)

rank_X_unc = rank(X_unc);
fprintf('\nRank of X_unc is %d',rank_X_unc)


% Taking the SVDs
fprintf('\nTaking SVD of the cropped images...\n')
[U_crp,S_crp,V_crp] = svd(X_crp,'econ');
V_crp = conj(V_crp)';

fprintf('\nTaking SVD of the uncropped images...\n')
[U_unc,S_unc,V_unc] = svd(X_unc,'econ');
V_unc = conj(V_unc)';

%% Plotting & Analysis

% Analyzing results
fprintf('\nPlotting results...\n')

S_unc_sum =  sum(diag(S_unc));
unc_modes = diag(S_unc) / S_unc_sum;
figure
plot(unc_modes, 'r.', 'markersize',15)
xlabel('Modes', 'fontsize', 20)
ylabel('Amplitude', 'fontsize', 20)
ttl_str = sprintf('Singluar Value Spectrum of Uncropped Images');
title(ttl_str, 'fontsize', 20)
axis([0 20 0 0.5])

S_crp_sum =  sum(diag(S_crp));
crp_modes = diag(S_crp) / S_crp_sum;
figure
plot(crp_modes, 'r.', 'markersize',15)
xlabel('Modes', 'fontsize', 20)
ylabel('Amplitude', 'fontsize', 20)
ttl_str = sprintf('Singluar Value Spectrum of Cropped Images');
title(ttl_str, 'fontsize', 20)
axis([0 20 0 0.5])

% Cumulative Energy Analysis
cum_ene_unc = zeros(length(S_unc),1);
cum_ene_unc(1) = S_unc(1,1) / S_unc_sum;
for i = 2 : length(S_unc)
    cum_ene_unc(i) = cum_ene_unc(i-1) + S_unc(i,i) / S_unc_sum;
end

cum_ene_crp = zeros(length(S_crp),1);
cum_ene_crp(1) = S_crp(1,1) / S_crp_sum;
for i = 2 : length(S_crp)
    cum_ene_crp(i) = cum_ene_crp(i-1) + S_crp(i,i) / S_crp_sum;
end

figure
plot(cum_ene_unc, 'r.--', 'markersize',15, 'linewidth',2)
xlabel('Modes', 'fontsize', 20)
ylabel('Energy', 'fontsize', 20)
ttl_str = sprintf('Cumulative Energy of Singular Values of Uncropped Images');
title(ttl_str, 'fontsize', 20)
axis([0 20 0 1.0])
figure
plot(cum_ene_crp, 'r.--', 'markersize',15, 'linewidth',2)
xlabel('Modes', 'fontsize', 20)
ylabel('Energy', 'fontsize', 20)
ttl_str = sprintf('Cumulative Energy of Singular Values of Cropped Images');
title(ttl_str, 'fontsize', 20)
axis([0 20 0 1.0])


%% Cropped Image Reconstructions – First Number of Modes

% First 25% modes approximation
r_crp_1 = round(length(S_crp) * 0.25);
rank_1_crp = U_crp(:,1:r_crp_1) * S_crp(1:r_crp_1,1:r_crp_1) * V_crp(1:r_crp_1,:);

% First 50% modes approximation
r_crp_2 = round(length(S_crp) * 0.50);
rank_2_crp = U_crp(:,1:r_crp_2) * S_crp(1:r_crp_2,1:r_crp_2) * V_crp(1:r_crp_2,:);

% First 75% modes approximation
r_crp_3 = round(length(S_crp) * 0.75);
rank_3_crp = U_crp(:,1:r_crp_3) * S_crp(1:r_crp_3,1:r_crp_3) * V_crp(1:r_crp_3,:);

figure
imagesc( reshape(X_crp(:,1), crp_img_hei,crp_img_len) )
ttl_str = sprintf('The First Cropped Image');
title(ttl_str, 'fontsize',20)

figure
imagesc( reshape(rank_1_crp(:,1), crp_img_hei,crp_img_len) )
ttl_str = sprintf('First Quarter Modes (Rank %d) Approximation', r_crp_1);
title(ttl_str, 'fontsize',20)

figure
imagesc( reshape(rank_2_crp(:,1), crp_img_hei,crp_img_len) )
ttl_str = sprintf('First Half Modes (Rank %d) Approximation', r_crp_2);
title(ttl_str, 'fontsize',20)

figure
imagesc( reshape(rank_3_crp(:,1), crp_img_hei,crp_img_len) )
ttl_str = sprintf('First Three-Quarters Modes (Rank %d) Approximation', r_crp_3);
title(ttl_str, 'fontsize',20)

%% Uncropped Image Reconstructions – First Number of Modes
% First 25% modes approximation
r_unc_1 = round(length(S_unc) * 0.25);
rank_1_unc = U_unc(:,1:r_unc_1) * S_unc(1:r_unc_1,1:r_unc_1) * V_unc(1:r_unc_1,:);

% First 50% modes approximation
r_unc_2 = round(length(S_unc) * 0.50);
rank_2_unc = U_unc(:,1:r_unc_2) * S_unc(1:r_unc_2,1:r_unc_2) * V_unc(1:r_unc_2,:);

% First 75% modes approximation
r_unc_3 = round(length(S_unc) * 0.75);
rank_3_unc = U_unc(:,1:r_unc_3) * S_unc(1:r_unc_3,1:r_unc_3) * V_unc(1:r_unc_3,:);

figure
imagesc( reshape(X_unc(:,1), unc_img_hei,unc_img_len) )
ttl_str = sprintf('The First Uncropped Image');
title(ttl_str, 'fontsize',20)

figure
imagesc( reshape(rank_1_unc(:,1), unc_img_hei,unc_img_len) )
ttl_str = sprintf('First Quarter Modes (Rank %d) Approximation', r_unc_1);
title(ttl_str, 'fontsize',20)

figure
imagesc( reshape(rank_2_unc(:,1), unc_img_hei,unc_img_len) )
ttl_str = sprintf('First Half Modes (Rank %d) Approximation', r_unc_2);
title(ttl_str, 'fontsize',20)

figure
imagesc( reshape(rank_3_unc(:,1), unc_img_hei,unc_img_len) )
ttl_str = sprintf('First Three-Quarters Modes (Rank %d) Approximation', r_unc_3);
title(ttl_str, 'fontsize',20)


%% Cropped Image Reconstructions – Percent of Energy

% 75% of the energy
[crp_75_ene,I_75] = min(abs(cum_ene_crp - 0.75));
crp_75 = U_crp(:,1:I_75) * S_crp(1:I_75,1:I_75) * V_crp(1:I_75,:);

% 95% of the energy
[crp_25_ene,I_25] = min(abs(cum_ene_crp - 0.25));
crp_25 = U_crp(:,1:I_25) * S_crp(1:I_25,1:I_25) * V_crp(1:I_25,:);


figure
imagesc( reshape(crp_75(:,1), crp_img_hei,crp_img_len) )
ttl_str = sprintf('75 %% of Energy (Rank %d) Approximation', I_75);
title(ttl_str, 'fontsize',20)

figure
imagesc( reshape(crp_25(:,1), crp_img_hei,crp_img_len) )
ttl_str = sprintf('25 %% of Energy (Rank %d) Approximation', I_25);
title(ttl_str, 'fontsize',20)


%% Uncropped Image Reconstruction – Percent of Energy

% 75% of the energy
[unc_75_ene,I_75] = min(abs(cum_ene_unc - 0.75));
unc_75 = U_unc(:,1:I_75) * S_unc(1:I_75,1:I_75) * V_unc(1:I_75,:);

% 95% of the energy
[unc_25_ene,I_25] = min(abs(cum_ene_unc - 0.25));
unc_25 = U_unc(:,1:I_25) * S_unc(1:I_25,1:I_25) * V_unc(1:I_25,:);


figure
imagesc( reshape(unc_75(:,1), unc_img_hei,unc_img_len) )
ttl_str = sprintf('75 %% of Energy (Rank %d) Approximation', I_75);
title(ttl_str, 'fontsize',20)

figure
imagesc( reshape(unc_25(:,1), unc_img_hei,unc_img_len) )
ttl_str = sprintf('25 %% of Energy (Rank %d) Approximation', I_25);
title(ttl_str, 'fontsize',20)
