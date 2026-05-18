function [x_opt, f_opt, iter, path] = newton_method(f, grad_f, hess_f, x0, epsilon, step_method)
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
        
        %  Υπολογισμός κατεύθυνσης d_k = -inv(H) * g (Βήμα 3)
        % Έλεγχος αν ο H είναι αντιστρέψιμος
        if rcond(H) < 1e-12
            % Αν ο πίνακας είναι σχεδόν ιδιάζων, η μέθοδος αποτυγχάνει ή γυρνάμε σε gradient
            % Εδώ θα σταματήσουμε για να δείξουμε το πρόβλημα
            warning('Ο Εσσιανός πίνακας δεν είναι αντιστρέψιμος στο σημείο (%.2f, %.2f).', x_curr(1), x_curr(2));
            break;
        end
        
        d = -H \ g; 
        
        %  Επιλογή Βήματος γ_k 
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
                    target = -alpha * (beta^mk) * s * (d' * g); % Προσοχή: d'*g εδώ, όχι d'*H*d
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