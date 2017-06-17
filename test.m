a=[1/sqrt(14) 2/sqrt(14) 3/sqrt(14); 4/sqrt(77) 5/sqrt(77) 6/sqrt(77); 7/sqrt(194) 8/sqrt(194) 9/sqrt(194)];
c=[1/sqrt(21) 2/sqrt(21) 4/sqrt(21); 4/sqrt(77) 5/sqrt(77) 6/sqrt(77); 7/sqrt(194) 8/sqrt(194) 9/sqrt(194)];
d=[3/sqrt(10) 1/sqrt(10) 0/sqrt(10); 7/sqrt(90) 4/sqrt(90) 5/sqrt(90); 6/sqrt(121) 9/sqrt(121) 2/sqrt(121)];
e=[3/sqrt(11) 1/sqrt(11) 1/sqrt(11); 7/sqrt(81) 4/sqrt(81) 4/sqrt(81); 6/sqrt(121) 9/sqrt(121) 2/sqrt(121)];
X(1,:) = reshape(a,1,9);
X(2,:) = reshape(c,1,9);
X(3,:) = reshape(d,1,9);
X(4,:) = reshape(e,1,9);
% X = [a;c;d;e];
y=[1; 1; -1; -1];
p=3;
q=3;
C=10;
max_iter = 5;
tau = 0.1;
inner_iter = 1;
eps = 1e-8;
rho = 10;
eta = 0.999;
[W_k, b]=fastADMM (X, y, p, q, C, tau, max_iter, inner_iter, eps, rho, eta);
l= sgn((trace(W_k'*a) + b));