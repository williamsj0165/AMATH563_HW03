%% SVD


[U_crp,S_crp,V_crp] = svd(X_crp,'econ');
V_crp = conj(V_crp)';

labels = {crp_genders'; crp_individuals'; crp_poses'}

%% Rank r trunction

rank_recon_crp = 5;
crp_ft_spc = V_crp(1:rank_recon_crp,:);


%% k-means

reps = 1000;
kmeans_k_vect = [2 38 64];

idx_crp_kmeans = zeros(length(crp_ft_spc),length(kmeans_k_vect));
I1_gnd = zeros(length(kmeans_k_vect),reps);
KL_div = zeros(length(kmeans_k_vect),1);
for kmeans_k_iter = 1 : length(kmeans_k_vect)
    kmeans_k = kmeans_k_vect(kmeans_k_iter);
%     fprintf('\n---------- c = %d ----------\n\n', kmeans_k);
    idx_crp_kmeans_reps = zeros(length(crp_ft_spc),reps);
    
    for reps_iter = 1 : reps
        if mod(reps_iter,100) == 0
            fprintf('\nrep = %d, %d',kmeans_k,reps_iter)
        end
        idx_crp_kmeans_reps(:,reps_iter) = kmeans(crp_ft_spc',kmeans_k);
        
        f_gnd = hist(labels{kmeans_k_iter},1:kmeans_k)+0.01;
        f_gnd = f_gnd / trapz(1:kmeans_k,f_gnd);
        g1_gnd = hist(idx_crp_kmeans_reps(:,reps),1:kmeans_k)+0.01;
        g1_gnd = g1_gnd / trapz(1:kmeans_k,g1_gnd);
        Int1_gnd = f_gnd.*log(f_gnd./g1_gnd);
        I1_gnd(kmeans_k_iter,reps_iter) = trapz(1:kmeans_k,Int1_gnd);
        
        clear f_gnd
        clear g1_gnd
        clear Int1_gnd
    end
    
    KL_div(kmeans_k_iter) = mean(I1_gnd(kmeans_k_iter,:));
    fprintf('\nKL_%d = %0.5f, STD = %0.5f,',kmeans_k_iter,KL_div(kmeans_k_iter),std(I1_gnd(kmeans_k_iter,:)))
    
    idx_crp_kmeans(:,kmeans_k_iter) = mode(idx_crp_kmeans_reps,2);
    
end


%%

KL_div(1) = NaN;

for kmeans_k_iter = 1 : length(kmeans_k_vect)
    figure
    bar(idx_crp_kmeans(:,kmeans_k_iter))
    xlabel('Image No.', 'fontsize',20)
    ylabel('Label', 'fontsize',20)
    ttl_str = sprintf('Proposed Label Distribution k-means\nc = %d, r = %d, k = %d; KL Div. = %0.4f, STD = %0.4f',kmeans_k_vect(kmeans_k_iter),rank_recon_crp,reps,KL_div(kmeans_k_iter),std(I1_gnd(kmeans_k_iter,:)));
    title(ttl_str, 'fontsize',20)
end

fprintf('\n')

%% Compute KL Divergences

% Genders
f_gnd = hist(crp_genders',[1,2])+0.01;
f_gnd = f_gnd / trapz([1,2],f_gnd);
g1_gnd = hist(idx_crp_kmeans(:,1),[1,2])+0.01;
g1_gnd = g1_gnd / trapz([1,2],g1_gnd);
Int1_gnd = f_gnd.*log(f_gnd./g1_gnd);
I1_gnd_mode = trapz([1,2],Int1_gnd)

% Subjects
f_gnd = hist(crp_individuals',1:38)+0.01;
f_gnd = f_gnd / trapz(1:38,f_gnd);
g2_gnd = hist(idx_crp_kmeans(:,3),1:38)+0.01;
g2_gnd = g2_gnd / trapz(1:38,g2_gnd);
Int2_gnd = f_gnd.*log(f_gnd./g2_gnd);
I2_gnd_mode = trapz(1:38,Int2_gnd)

% Poses
f_gnd = hist(crp_poses',1:64)+0.01;
f_gnd = f_gnd / trapz(1:64,f_gnd);
g3_gnd = hist(idx_crp_kmeans(:,3),1:64)+0.01;
g3_gnd = g3_gnd / trapz(1:64,g3_gnd);
Int3_gnd = f_gnd.*log(f_gnd./g3_gnd);
I3_gnd_mode = trapz(1:64,Int3_gnd)


%% Actual Distributions

figure
bar(crp_genders)
xlabel('Image No.', 'fontsize',20)
ylabel('Gender', 'fontsize',20)
ttl_str = sprintf('Gender Distribution in Images');
title(ttl_str, 'fontsize',20)

figure
bar(crp_individuals)
xlabel('Image No.', 'fontsize',20)
ylabel('Subject', 'fontsize',20)
ttl_str = sprintf('Subject Distribution in Images');
title(ttl_str, 'fontsize',20)

figure
bar(crp_poses)
xlabel('Image No.', 'fontsize',20)
ylabel('Pose', 'fontsize',20)
ttl_str = sprintf('Pose Distribution in Images');
title(ttl_str, 'fontsize',20)


%%


