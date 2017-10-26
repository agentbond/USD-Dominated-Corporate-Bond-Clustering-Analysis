cd C:/Users/Ran/Documents/NJIT/MachineLearning/Project

fprintf('\nRunning K-Means clustering on example dataset.\n\n');

% Load normalized data file and Eigenvectors generated as Yating's PCA
% coefficients.
load('PCA_Eigen2.mat');
load('PriceInfo.mat');
data=normdata;
PCA_Eigen2=coeff;
size (normdata) % 4810*36 matrix
size (coeff) % 36*36 matrix

% Remove NaN in dataset.
data(isnan(data(:,2)),:)=[];

% According to score from PCA, the last two vectors are deleted. But
% certainly you can add them by changing I to 38.
I = 26; 

% Generate new data matrix after being processed by PCA.
PostPCA=data*PCA_Eigen2(:,1:I);

% Set the number of clusters.
K = 20;
Cluster=zeros(K,3);

% Select an initial set of centroids
initial_centroids = kMeansInitCentroids(PostPCA, K);

% Set number of iterations
max_iters = 10;

% Run K-Means algorithm. The 'true' at the end tells our function to plot
% the progress of K-Means
[centroids, idx] = runkMeans(PostPCA, initial_centroids, max_iters, true);

% For each cluster, print information on: number of bonds within, mean of
% bid price for all bonds, standard deviation of bid prices for all bonds.
Bid=PriceInfo(:,1);
for i=1:K
    Cluster(i,1)=sum(idx==i);
    Tempdata=Bid(find(idx==i));
    Cluster(i,2)=mean(Tempdata);
    Cluster(i,3)=std(Tempdata);
end
fprintf('Bid Information per cluster Number, Mean, Standard Deviation');
Cluster

% For each cluster, print information on: number of bonds within, mean of
% price mid for all bonds, standard deviation of price mid for all bonds.
Mid=PriceInfo(:,2);
for i=1:K
    Tempdata=Mid(find(idx==i));
    Cluster(i,2)=mean(Tempdata);
    Cluster(i,3)=std(Tempdata);
end
fprintf('Mid Information per cluster Mean, Standard Deviation');
Cluster

fprintf('\nK-Means Done.\n\n');
