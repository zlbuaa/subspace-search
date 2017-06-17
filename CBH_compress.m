function B = CBH_compress(W_r, a, n, X, hashbits)

r = hashbits;
B = zeros(n,r);
for i = 1:n
    for j = 1:r
    B(i,j) = sgn((trace(W_r{j}'*X{i}) + a(1,j)));
    end
end
B = (B+1)/2;
end
