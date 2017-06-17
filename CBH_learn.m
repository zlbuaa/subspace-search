function [B,W_r,a] = CBH_learn(n, subspaceTrain, M, hashbits)

W = eye(n);
for i = 1:n
    W(i,i) = sum(M(i,:));
end

r = hashbits;
[V,~] = firstKEigenVector(W-M,r); %W-M的前r位最大特征值和特征向量

Y = V;
Z = repmat(median(Y),size(Y,1),1);
B = double(Y>Z);

B = B.*2-1; %转换成-1,1类标
p = size(subspaceTrain{1},1);
q = size(subspaceTrain{1},2);
X = zeros(n,p*q);
for i = 1:n
    X(i,:) = reshape(subspaceTrain{i},1,p*q);
end

%参数
C=20;
max_iter = 500;
tau = 0.2;
inner_iter = 500;
eps = 1e-8;
rho = 10;
eta = 0.999;
a = zeros(1,r);
for i = 1:r
    y = B(:,i);
    [W_k, b] = fastADMM (X, y, p, q, C, tau, max_iter, inner_iter, eps, rho, eta);
    W_r{i} = W_k;
    a(1,i) = b;
end

B = (B+1)/2; %恢复0,1编码
end