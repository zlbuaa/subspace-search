close all;
clc;
clear;

load ('youtube100');

%% TrainLSH
numTrain = size(subspaceTrain,2);
for i = 1:numTrain
    X = subspaceTrain{1,i};
    X = X*X';
    A(:,i) = vech(X); %subspace转向量
end

nbits = 80; %编码位数
dim = size(A,1);

for i = 1:nbits
    q = normrnd(0, 1 , dim, 1);
    W(:,i) = q;
end

D = W'*A;
%D = D - sum(D(:))/(nbits*numTrain);
B = sgn(D);
B = compactbit(B);

%% Test
numTest = size(subspaceTest,2);
s = 0;
for i = 1:numTest
    Y = subspaceTest{1,i};
    Y = Y*Y';
    a = vech(Y);
    
    D = W'*a;
    %D = D - sum(D(:))/nbits;
    
    B1 = sgn(D);
    B1 = compactbit(B1);
    Dh = hammingDist(B1',B');
    
    %k = find(Dh==min(Dh));
    [~,k] = min(Dh);
    if  k == i
        s = s+1;
    end
end
acc = s/numTest;
