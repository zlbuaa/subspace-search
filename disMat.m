function D = disMat(subspaceTrain,n)

D = eye(n);

for i = 1:n
    for j = i:n
     D(i,j) = subspace_dist(subspaceTrain{i},subspaceTrain{j});
     end
end

for i = 2:n
    for j = 1:i-1
        D(i,j) = D(j,i);
    end
end
end