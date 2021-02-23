% README

% Using mexEMD to compute KT (standard complete optimal transport)
% mexEMD is a third-party software: https://github.com/gpeyre/2017-ot-beginners/tree/master/matlab/mexEMD

% Using BuildTreeMetric_HighDim_V2 to sample tree metric (clustering-based
% tree metric sampling)
% BuildTreeMetric_HighDim_V2 is a third-party software: https://github.com/lttam/TreeWasserstein
% (Used in document classification experiments)

% We adapted BuildTreeMetric_HighDim_V2 to BuildTreeMetric_LowDim_V2
% (partition-based tree metric sampling) to sample tree metric for
% persistence diagrams in our experiments.

% Implementation for d_{\alpha} and \tilde{ET}_\lambda^\alpha is simple
% (closed-form solution). Therefore, 
% (step-1) sample tree metrics
% (step-2) use the closed-form solutions

