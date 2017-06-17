function x = norm_nuc(W)
[U, S, V] = svd(W);
x = sum(diag(S));
end