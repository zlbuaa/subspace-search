function A = sgn(B)
n = size(B,1);
m = size(B,2);
A = zeros(n,m);

for i = 1:n
    for j = 1:m
        if B(i,j)<0
            A(i,j) = 0;
        else
            A(i,j) = 1;
        end
    end
end
end