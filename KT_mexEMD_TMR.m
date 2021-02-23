function dd = KT_mexEMD_TMR(TMR, XT, WX, ZT, WZ, TM, opt)

% % opt.a = 1;
% % opt.b = 1;
% % opt.lambda = 1;
% % opt.alpha = 0;
% % opt.c = 1;
% % opt.x_0 = 'r'; % root --> w(r) = a; [w(x) = d(r, x) + a]

% cost/ground metric
CC = zeros(length(XT) + 1, length(ZT) + 1);

% w1(x) --> X<-->\hat{s}
for ii = 1:length(XT)
    CC(ii, end) = opt.c*TMR(XT(ii)) + opt.a; % w1(x) = cd(x, x_0) + a 
end

% w2(x) --> Z<-->\hat{s}
for jj = 1:length(ZT)
    CC(end, jj) = opt.c*TMR(ZT(jj)) + opt.a;% w2(z)
end

% XX to ZZ
for ii = 1:length(XT)
    for jj=1:length(ZT)
        dd_r2ca = TreeMetric_Root2CA(XT(ii), ZT(jj), TM);
        
        % TreeMetric: d(r, x) + d(r, z) - 2d(r, ca)
        tm_ij = TMR(XT(ii)) + TMR(ZT(jj)) - 2*dd_r2ca; 

        CC(ii, jj) = opt.b*(tm_ij - opt.lambda); % b[c(x, y) - \lambda]
    end
end

% mexEMD
% format
% Extracted from mexEMD.cpp
% function [dist, flow] = mexEMD(X, Y, D)
%
%
% Input:
% X, Y: column vectors
% D: |X| x |Y|
% Optional:
% The 4th input argument will be maximum iterations
%
% Output:
% dist: distance
% flow: transportation plan

XX = [WX; sum(WZ)];
ZZ = [WZ; sum(WX)];

dd = mexEMD(XX, ZZ, CC);


end
