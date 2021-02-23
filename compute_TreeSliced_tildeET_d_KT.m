% sample code to compute tildeET -- d_\alpha -- KT
% in experiments (for TWITTER dataset)

clear all
clc

% [1, 5, 10, 15, 20];
nTS = 1; % number of slices

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% using clustering-based tree metric construction
% from tree-sliced TW

load('twitter.mat');

TM_L = 6; %highest level
TM_KC = 4; %# of clusters

% OUTPUT
tET_SUM = zeros(N, N);
KT_SUM = zeros(N, N);
dAlpha_SUM = zeros(N, N);

runTime_TM = 0;
runTime_Mapping = 0;
runTime_tET = 0;
runTime_KT = 0;
runTime_TMR = 0;

%================
% OPT 
opt.a = 1;
opt.b = 1;
opt.lambda = 1;
opt.alpha = 0;
opt.c = 1;
opt.x_0 = 'r'; % root --> w(r) = a; [w(x) = d(r, x) + a]

TM_ALL = cell(nTS, 1);
% REPEAT for each tree slice
for idSS = 1:nTS

    disp(['.........Tree: #' num2str(idSS)]);
    
    %%%%%%%%
    disp(['...compute tree metric']);
    tic
    [TM, XX_VertexID] = BuildTreeMetric_HighDim_V2(XX, TM_L, TM_KC);
    runTime_TM_ii = toc;
    % accumulate
    runTime_TM = runTime_TM + runTime_TM_ii;
    
    TM_ALL{idSS} = TM;

    disp(['...preprocessing -- building look-up tables']);

    massXX = zeros(1, N);
    hXX = zeros(TM.nVertices - 1, N);

    % TM.nVertices - 1
    % general simplex vector 
    tic
    for ii = 1:N
        massXX(ii) = sum(WW{ii});
        hXX(:, ii) = TreeMapping_Id2V(XX_VertexID{ii}, WW{ii}, TM);
    end
    runTime_Mapping_ii = toc;
    % accumulate
    runTime_Mapping = runTime_Mapping + runTime_Mapping_ii;

    %%%%%%
    tic
    TMR = zeros(1, TM.nVertices);
    for ii = 1:TM.nVertices
        TMR(ii) = TreeMetricFromRoot(ii, TM);
    end
    runTime_TMR_ii = toc;
    % accumulate
    runTime_TMR = runTime_TMR + runTime_TMR_ii;
    
    disp(['...compute tildeET -- dAlpha']);
    %%%%%%%
    dd_tET = zeros(N, N);
    dd_dAlpha = zeros(N, N);

    tic
    for ii = 1:N
        if mod(ii, 50) == 0
            disp(['......' num2str(ii)]);
        end

        % ii -- (ii:N)
        % tET
        m_ii = massXX(ii);
        MJJ = massXX(ii:N); % row
        MII = repmat(m_ii, 1, (N-ii+1));

        DD1 = (opt.a - opt.alpha)*abs(MII-MJJ) - opt.b*opt.lambda*min(MII, MJJ);

        h_II = hXX(:, ii);
        HJJ = hXX(:, ii:N);
        HII = repmat(h_II, 1, (N-ii+1));

        DD2 = sum(abs(HII - HJJ)); % row

        DD_RII = DD1 + DD2;
        dd_tET(ii, ii:N) = DD_RII;
        dd_tET(ii:N, ii) = DD_RII';

        % d^{\alpha}
        hDD1 = (opt.a + (opt.b*opt.lambda)/2 - opt.alpha)*abs(MII-MJJ);
        hDD_RII = hDD1 + DD2;

        dd_dAlpha(ii, ii:N) = hDD_RII;
        dd_dAlpha(ii:N, ii) = hDD_RII';

    end
    runTime_tET_ii = toc;

    % accumulate
    runTime_tET = runTime_tET + runTime_tET_ii;

    tET_SUM = tET_SUM + dd_tET;
    dAlpha_SUM = dAlpha_SUM + dd_dAlpha;

    %==========================
    disp(['...compute KT']);
    %%%%%%%
    dd_KT = zeros(N, N);
    
    tic
    for ii = 1:N
        if mod(ii, 50) == 0
            disp(['......' num2str(ii)]);
        end
        for jj = ii:N
            dd_KT(ii, jj) = KT_mexEMD_TMR(TMR, XX_VertexID{ii}, WW{ii}, XX_VertexID{jj}, WW{jj}, TM, opt);
        end
    end
    runTime_KT_ii = toc;
    
    % accumulate
    runTime_KT = runTime_KT + runTime_KT_ii;
    
    KT_SUM = KT_SUM + dd_KT;    
end

% Average
tET = tET_SUM/nTS;
dAlpha = dAlpha_SUM/nTS;

KT = KT_SUM/nTS;

save(['twitter_TreeSlice_L' num2str(TM_L) 'K' num2str(TM_KC) 'S' num2str(nTS) '.mat'], ...
    'tET', 'dAlpha', 'KT', ...
    'opt', 'TM_L', 'TM_KC', 'nTS', ...
    'runTime_TM', 'runTime_Mapping', 'runTime_tET', 'runTime_KT', 'runTime_TMR');

disp('FINISH!');

