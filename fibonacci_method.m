function [ak, bk, iterations, func_evals, a_history, b_history] = fibonacci_method(f, a, b, l, epsilon)

L1 = b - a;
[n, F] = get_fibonacci_n(L1, l); 

ak = a; 
bk = b; 

% 3. Υπολογισμός αρχικών σημείων x1, x2
x1k = ak + (F(n-2) / F(n)) * (bk - ak);
x2k = ak + (F(n-1) / F(n)) * (bk - ak);

f_x1k = f(x1k);
f_x2k = f(x2k);

func_evals = 2;
iterations = 0; 
k_index = 1;    

a_history(k_index) = ak;
b_history(k_index) = bk;


% Ο βρόγχος εκτελείται n-2 φορές (για k=1, 2, ..., n-2)
% Η λογική ακολουθεί τα Βήματα 1, 2, 3, 4, 5
for k = 1 : n-2 
    
    iterations = iterations + 1;
    k_index = k_index + 1;

    if k == n-2
        
        x1n = x1k;
        x2n = x1k + epsilon; 
        
        f_x1n = f_x1k;
        f_x2n = f(x2n);
        func_evals = func_evals + 1;
        
        if f_x1n > f_x2n 
            ak = x1n; 
        else
            bk = x2n; 
        end
        
    else
        
        if f_x1k <= f_x2k % (Πάμε στο Βήμα 2)
            bk = x2k;
            x2k = x1k;
            f_x2k = f_x1k;
            
            x1k = ak + (F(n-k-2) / F(n-k)) * (bk - ak);
            f_x1k = f(x1k);
            
        else % (f_x1k > f_x2k, Πάμε στο Βήμα 3)
            ak = x1k;
            x1k = x2k;
            f_x1k = f_x2k;
         
            x2k = ak + (F(n-k-1) / F(n-k)) * (bk - ak);
            f_x2k = f(x2k);
        end
        
        func_evals = func_evals + 1;
    end
    
    a_history(k_index) = ak;
    b_history(k_index) = bk;
    
end 

end

function [n, F] = get_fibonacci_n(L1, l)
    % Βρίσκει τον ελάχιστο 'n' ώστε F(n) > L1 / l
    
    target_ratio = L1 / l;
    
    F = [1, 1]; % F(1), F(2)
    n = 2;
    
    while F(end) <= target_ratio
        next_F = F(end) + F(end-1);
        F(end+1) = next_F;
        n = n + 1;
    end
end