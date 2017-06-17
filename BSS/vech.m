function x = vech(A)
    n = size(A,1);
    M = tril(ones(n)) + diag(diag(ones(n)));
    idx = find(M(:));
    A = A- diag(diag(A)) + diag(diag(A)/sqrt(2));
    x = A(idx);%A的上三角矩阵拉成的向量
end