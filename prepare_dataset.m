function prepare_dataset(dataset,k)

load(['data/',dataset]);

% split = 0.6;   % 60 percent training, 40 percent testing
% randIdx = rand(size(subspace,2),1);
% trainIdx = find(randIdx <= split);
% testIdx  = find(randIdx >  split);
% [subspaceTrain,subspaceTest] = tf_idf(subspace(1,trainIdx),subspace(1,testIdx));
%subspaceTrain = normalize(subspaceTrain);
%subspaceTest  = normalize(subspaceTest);

% clear subspace;
numTrain = size(subspaceTrain,2);
numTest  = size(subspaceTest,2);
% gndTrain = uint8(gnd(trainIdx));
% gndTest  = uint8(gnd(testIdx));

D = disMat(subspaceTrain,numTrain); %Distance Matrix

M = knnMat(numTrain,D,k); %Affinity Matrix

trueTrainTest = zeros(numTrain,numTest);
for i = 1:numTrain
    for j = 1:numTest
        if gndTrain(i) == gndTest(j)
            trueTrainTest(i,j) = 1;
        end
    end
end

%cateTrainTest = (repmat(gndTrain,1,numTest) == repmat(gndTest,1,numTrain)');

save(['testbed/',dataset],'subspaceTrain','subspaceTest','numTrain','numTest','gndTrain','gndTest','D','M','trueTrainTest');
% clear;

end
