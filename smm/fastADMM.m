function [W_k, b] = fastADMM (X, y, p, q, C, tau, max_iter, inner_iter, eps, rho, eta) 
    if (~exist('max_iter', 'var'))
        max_iter = 500;
    end

    if (~exist('eps', 'var'))
        eps = 1e-8;
    end
    
    if (~exist('rho', 'var'))
        rho = 10;
    end
    
    if (~exist('eta', 'var'))
        eta = 0.999;
    end
    
    K = ((X*X') .* (y*y')) / (rho + 1);
    %t = 1 / norm(K, 2);
    n = size(X, 1);
    d = size(X, 2);
    
    s_km1 = zeros(d, 1);
    s_hatk = s_km1;
    lambda_km1 = ones(d, 1);
    lambda_hatk = lambda_km1;
    t_k = 1;
    c_km1 = 0;

    recent_number = 50;
    recent_idx = 0;
    obj_recent = zeros(recent_number, 1);
    
    for k=1: max_iter
        f = 1 - ((X * (lambda_hatk + rho * s_hatk)) .* y) / (rho + 1);
        %[alpha_1, inten_k_1, ~] = steepestDescentQP(K, -b, C, 100, eps);
        %[alpha, inten_k_2] = nestrovQP(K, -b, C, alpha_1, t, 10000, eps/100000);
        
        opt = struct('TolKKT', eps/100, 'MaxIter', inner_iter, 'verb', 0);
        LB = zeros(n,1);
        UB = C * ones(n,1);
        [alpha,~] = libqp_gsmo(K, -f, y', 0, LB, UB, [], opt);
        w_k = (lambda_hatk + rho * s_hatk + X'*(alpha.*y)) / (rho + 1);
        sel = (alpha > 0) & (alpha < C);
        b = sel' * (y - X * w_k) / sum(sel);

        W_k = reshape(w_k, p, q);
        Lambda_k = reshape(lambda_hatk, p, q);
        S = shrinkage(rho*W_k - Lambda_k, tau) / rho;
        s_k = reshape(S, d, 1);

        lambda_k = lambda_hatk - rho * (w_k - s_k);

        c_k = (lambda_k - lambda_hatk)' * (lambda_k - lambda_hatk) / rho + rho * (s_k - s_hatk)' * (s_k - s_hatk);

        if (c_k < eta * c_km1)
            t_kp1 = 0.5 * (1 + sqrt(1 + 4*t_k*t_k));
            s_hatkp1 = s_k + (t_k-1) / t_kp1 * (s_k - s_km1);
            lambda_hatkp1 = lambda_k + (t_k-1) / t_kp1 * (lambda_k - lambda_km1);
            restart = false;
        else
            t_kp1 = 1;
            s_hatkp1 = s_km1;
            lambda_hatkp1 = lambda_km1;
            c_k = c_km1 / eta;
            restart = true;
        end

        s_hatk = s_hatkp1;
        lambda_hatk = lambda_hatkp1;
        c_km1 = c_k;
        s_km1 = s_k;
        lambda_km1 = lambda_k;
        t_k = t_kp1;

        obj_k = objective_value(w_k, p, q, b, X, y, C, tau);
        recent_idx = recent_idx + 1;
        obj_recent(recent_idx) = obj_k;
        if (recent_idx == recent_number)
            recent_idx = 0;
        end
        if mod(k, 1000) == 0
             rk = sum(svd(reshape(w_k, p, q))>1e-6);
             fprintf('k=%d, obj=%f, restart=%d, rank=%d\n', k, obj_k, restart, rk);
        end
        
        if (abs(obj_k - mean(obj_recent)) / abs(mean(obj_recent)) < eps && k > recent_number)
            break;
        end
    end
    
    stop_iter = k;
    rk = sum(svd(reshape(w_k, p, q))>1e-6);
    function obj = objective_value(w, p, q, b, X, y, C, tau)
        obj = 0.5 * (w') * w + C * sum(max(0, 1 - y .* (X * w + b))) + tau * norm_nuc(reshape(w,p,q));
    end
end