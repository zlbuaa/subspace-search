function doExperiment(dataset, alg)
% doExperiment: Learning to Hash

load(['testbed/',dataset]);


%codeLen = 4:4:64;
codeLen = 32;
hammRadius = 2;
% hammRadius = 0:3;
% maxbits = codeLen(end);
hashbits = 32;
tic;
[codeTrain,W_r,a] = CBH_learn(numTrain, subspaceTrain, M, hashbits);
timeTrain = toc;

tic;
codeTest = CBH_compress(W_r, a, numTest, subspaceTest, hashbits);
% timeTest = toc;

%disp([timeTrain, timeTest]);

% m = length(codeLen);
% n = length(hammRadius);
%trueP = zeros(m,n);
%trueR = zeros(m,n);
%cateP = zeros(m,n);
%cateR = zeros(m,n);
%cateA = zeros(m,n);
% for i = 1:m
%     nbits = codeLen(i);
%     disp(nbits);
%     cbTrain = compactbit(codeTrain(:,1:nbits));
%     cbTest  = compactbit(codeTest(:,1:nbits));
%     hammTrainTest  = hammingDist(cbTest,cbTrain)';
%     for j = 1:n
%         Ret = (hammTrainTest <= hammRadius(j)+0.00001);
%         [trueP(i,j), trueR(i,j)] = evaluate_macro(trueTrainTest, Ret);
%         %[cateP(i,j), cateR(i,j)] = evaluate_macro(cateTrainTest, Ret);
%         cateA(i,j) = evaluate_classification(gndTrain, gndTest, Ret);
%     end
% end
    nbits = codeLen;
    disp(nbits);
    cbTrain = compactbit(codeTrain(:,1:nbits));
    cbTest  = compactbit(codeTest(:,1:nbits));
    hammTrainTest  = hammingDist(cbTest,cbTrain)';
timeTest = toc;
        Ret = (hammTrainTest <= hammRadius+0.00001);
        [trueP, trueR] = evaluate_macro(trueTrainTest, Ret);
        cateA = evaluate_classification(gndTrain, gndTest, Ret);

disp([timeTrain, timeTest]);
disp(cateA);

% clear feaTrain feaTest;
% clear gndTrain gndTest;
% clear trueTrainTest cateTrainTest;
% clear hammTrainTest Ret;
save(['results/',dataset,'_',alg]);
% clear;

end
