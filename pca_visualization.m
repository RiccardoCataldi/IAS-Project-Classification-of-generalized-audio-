function [num_coeffs] = pca_visualization(AllFeats,C) 

[COEFF, SCORE, LATENT, TSQUARED, EXPLAINED] = pca(AllFeats);

%disp('explained variance...')
%EXPLAINED
% plotting
S=[]; 
% size of each point, empty for all equal
%C=[repmat([1 0 0],length(AllFeatsCrickets),1); repmat([0 1 0],length(AllFeatsPig),1); repmat([0 0 1],length(AllFeatsSipping),1)];
    % define color R G B
figure
scatter3(SCORE(:,1),SCORE(:,2),SCORE(:,3),S,C)
axis equal

xlabel('1st Principal Component')
ylabel('2nd Principal Component')
zlabel('3rd Principal Component')
  

cumulative_var = cumsum(EXPLAINED)./sum(EXPLAINED);

num_coeffs = find(cumulative_var>=0.8, 1, 'first');


disp(['Number of coefficients explaining at least 80% of the variance: ', num2str(num_coeffs)]);
