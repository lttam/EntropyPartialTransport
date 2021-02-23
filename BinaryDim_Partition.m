function [K, clusterIndex, clusterCenter] = BinaryDim_Partition(d, N, x)            

% Adapted from farthest-point clustering for BuildTreeMetric_HighDim_V2
% into BinaryDim_Partition used in partition-based tree metric sampling for
% persistence diagrams (BuildTreeMetric_LowDim_V2)

% % function [K, rx, clusterIndex, clusterCenter, numPoints, clusterRadii] = 
            % %                    ...figtreeKCenterClustering(d, N, x, K)
            % % ===(THIRD-PARTY TOOLBOX: Gonzalez's farthest-point clustering algorithm)
            % % Input
            % %    * d --> data dimensionality.
            % %    * N --> number of source points.
            % %    * x --> d x N matrix of N source points in d dimensions 
            % %    * kMax --> maximum number of clusters.
            % % Ouput
            % %    * K --> actual number of clusters (less than kMax if duplicate pts exist)
            % %    * rx --> maximum radius of the clusters.
            % %    * clusterIndex --> vector of length N where the i th element is the 
            % %                cluster number to which the i th point belongs. 
            % %                ClusterIndex[i] varies between 0 to K-1.
            % %    * clusterCenters --> d x K matrix of K cluster centers 
            % %    * numPoints --> number of points in each cluster.
            % %    * clusterRadii --> radius of each cluster.
            
            % perform clustering to find children nodes (children's clusters)
            % rKCLL_idCCPP: ==<rKC(real #clusters)>
            % idZZLL_idCCPP: idZZ("supports")LL("child level") from "idCCPP" clusterID at parent level
            % kcCenterLL_idCCPP: kcCenter("centroids") ...
            
% INPUT K = 2^d                     
% %             [rKCLL_idCCPP, ~, idZZLL_idCCPP, kcCenterLL_idCCPP, ~, ~] = ...
% %                 figtreeKCenterClustering(dim, length(idZZ_idCCPP), allZZ_idCCPP', KC);
            

x = x'; % --> N x dim

cube = GetHyperCube(x); % 2 x dim
center = GetCenterHyperCube(cube); % dim x 1

clusterBinArray = zeros(N, d);

for ii = 1:d
    data = x(:, ii);
    clusterBinArray(:, ii) = (data >= center(ii));
end

%Ktmp = 2^d;

clusterID_tmp = zeros(N, 1);
for ii = 1:N
    clusterID_tmp(ii) = bin2dec(clusterBinArray(ii, :));
end

unique_clusterID = unique(clusterID_tmp);
K = length(unique_clusterID);

clusterIndex = zeros(N, 1); % 0 --> K-1
clusterCenter = zeros(d, K);

binCenter = GetBinCenterHyperCube(cube); % 2 x dim

for ii = 1:K
    idII = find(clusterID_tmp == unique_clusterID(ii));
    clusterIndex(idII) = ii - 1;
    
    % binary
    valID = clusterBinArray(idII(1), :); % 1 or 2
    for jj = 1:d
        clusterCenter(jj, ii) = binCenter(valID(jj)+1, jj);
    end
end


            
           