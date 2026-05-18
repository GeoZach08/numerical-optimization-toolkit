function [x_opt, f_opt, iter, path] = levenberg_marquardt(f, grad_f, hess_f, x0, epsilon, step_method)

    x_curr = x0(:);
    iter = 0;
    max_iter = 1000;
    path = x_curr;
    
    while iter < max_iter
        g = grad_f(x_curr(1), x_curr(2));
        
        if norm(g) < epsilon
            break;
        end
  
        H = hess_f(x_curr(1), x_curr(2));
        
        %  Βήμα 2: Υπολογισμός του μ_k 
        % Βρίσκουμε τις ιδιοτιμές του H
        eigenvalues = eig(H);
        min_eig = min(eigenvalues);
        
        if min_eig > 0
            % Ο πίνακας είναι ήδη θετικά ορισμένος -> μ_k = 0 (καθαρή Newton)
            mu = 0;
        else
            % Ο πίνακας δεν είναι θετικός. Θέτουμε μ_k λίγο μεγαλύτερο από την |min_eig|
            % ώστε όλες οι ιδιοτιμές να γίνουν θετικές.
            mu = abs(min_eig) + 0.5; % Το 0.5 είναι μια αυθαίρετη μικρή τιμή ασφαλείας
        end
        
        % Τροποποιημένος Εσσιανός
        H_mod = H + mu * eye(2);
       
        d = -H_mod \ g;
        
        switch step_method
            case 'constant'
                gamma = 1; 
                
            case 'min'
                func_gamma = @(gam) f(x_curr(1) + gam*d(1), x_curr(2) + gam*d(2));
                [a_res, b_res] = golden_section(func_gamma, 0, 2, 1e-3);
                gamma = (a_res + b_res) / 2;
                
            case 'armijo'
                s = 1; alpha = 1e-3; beta = 0.5; mk = 0;
                current_f_val = f(x_curr(1), x_curr(2));
                while true
                    gamma_try = s * (beta^mk);
                    x_next_try = x_curr + gamma_try * d;
                    f_next = f(x_next_try(1), x_next_try(2));
                    diff = current_f_val - f_next;
                    target = -alpha * (beta^mk) * s * (d' * g);
                    if diff >= target
                        gamma = gamma_try;
                        break;
                    end
                    mk = mk + 1;
                    if mk > 20, gamma = 1e-5; break; end
                end
        end
        
       
        x_curr = x_curr + gamma * d;
        iter = iter + 1;
        path = [path, x_curr];
    end
    
    x_opt = x_curr;
    f_opt = f(x_opt(1), x_opt(2));
end