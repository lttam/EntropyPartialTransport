function hh = TreeMapping_Id2V(XX, WW, TM)

% for each probability measure


% % % using MATLAB toolbox (adaptive between kdtree & exhaustive search)
% % % Euclidean distance metric
% % % Idx = knnsearch(X,Y) finds the nearest neighbor in X for each query point in Y 
% % % and returns the indices of the nearest neighbors in Idx, a column vector. 
% % % Idx has the same number of rows as Y.
% % % Input: N x dim
% % % Output: N x 1 (column vector)
% % 
% % % id of all leaves: TM.LeavesIDArray
% % allLeaves = TM.Vertex_Pos(TM.LeavesIDArray, :);
% % idLeaves = knnsearch(allLeaves, allXX);
% % allIdVertices = TM.LeavesIDArray(idLeaves);
% % 
% % TX = zeros(N, TM.nVertices - 1); % edge representation vector
% % for ii = 1:N
% %     tmpVector = zeros(1, TM.nVertices - 1);
% %     for jj = sIDArray(ii):eIDArray(ii)
% %         idEdges = TM.Vertex_EdgeIdPath{allIdVertices(jj)};
% %         tmpVector(idEdges) = tmpVector(idEdges) + allWW(jj); %empirical measures
% %     end
% %     TX(ii, :) = tmpVector .* TM.Edge_Weight'; %row vector
% % end


% XX: set of vertices
% WW: weighted at each vertex
% TM: tree metric

hh = zeros(1, TM.nVertices - 1); %edge representation vector

for ii = 1:length(XX)
   idEdges = TM.Vertex_EdgeIdPath{XX(ii)};
   hh(idEdges) = hh(idEdges) + WW(ii);
end

hh = hh .* TM.Edge_Weight';

hh = hh';

end

