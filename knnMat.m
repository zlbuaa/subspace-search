function M = knnMat(n,D,k)
%knnMat Create the k-nearest-neighbours matrix based on the distance matrix
%   n:  numTrain
%   D:  the subspaceTrain distance matrix
%   k:  the threshold of nearest neighbours

M = eye(n);

for i = 1:n
    for j = i:n
     if D(i,j)>k
         M(i,j) = D(i,j);
     else
         M(i,j) = 0;
     end
    end
end

for i = 2:n
    for j = 1:i-1
        M(i,j) = M(j,i);
    end
end
end