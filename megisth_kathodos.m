function [x_opt, f_opt, iter, path] = megisth_kathodos(f, grad_f, x0, epsilon, step_method)
% Inputs:
%   f:           Handle της συνάρτησης f
%   grad_f:      Handle της κλίσης (gradient)
%   x0:          Αρχικό σημείο [x; y]
%   epsilon:     Ανοχή τερματισμού (π.χ. 1e-3)
%   step_method: 'constant', 'min', ή 'armijo'

    x_curr = x0(:); 
    iter = 0;
    max_iter = 1000; 
    path = x_curr;   
    
    while iter < max_iter
        g = grad_f(x_curr(1), x_curr(2));
        if norm(g) < epsilon
            break;
        end
        d = -g;
        
        %  Επιλογή Βήματος γ_k (gamma)
        switch step_method
            case 'constant'
                gamma = 0.1;
                
            case 'min'
                %  g(gamma) = f(xk + gamma*dk)
                func_gamma = @(gam) f(x_curr(1) + gam*d(1), x_curr(2) + gam*d(2));
                a_search = 0;
                b_search = 2;
                l_search = 1e-3;
                
                % Καλούμε τη Golden Section από την Εργασία 1
                [a_res, b_res] = golden_section(func_gamma, a_search, b_search, l_search);
                
                % Το βέλτιστο βήμα είναι το μέσο του τελικού διαστήματος
                gamma = (a_res + b_res) / 2;
                
            case 'armijo'
                % Κανόνας Armijo 
                s = 1;       
                alpha = 1e-3; 
                beta = 0.5;   
                mk = 0;
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