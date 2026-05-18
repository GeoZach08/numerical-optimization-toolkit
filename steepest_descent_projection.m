function [x_opt, f_hist, iter, path] = steepest_descent_projection(f, grad_f, proj_func, x0, s, gamma, epsilon)
    % Υλοποίηση Μέγιστης Καθόδου με Προβολή (Gradient Projection)
    % Βάσει των τύπων (6.1.8) και (6.1.9) του βιβλίου
    
    max_iter = 500; 
    x = x0;
    f_hist = [];
    path = x;
    iter = 0;
    
    while iter < max_iter
        g = grad_f(x);
        f_val = f(x);
        f_hist = [f_hist, f_val];
    
        x_temp_unconstrained = x - s * g;
        
        x_bar = proj_func(x_temp_unconstrained);
        
        x_new = x + gamma * (x_bar - x);
   
        if norm(x_new - x) < epsilon
            break;
        end
    
        x = x_new;
        path = [path, x];
        iter = iter + 1;
    end
    
    x_opt = x;

    f_hist = [f_hist, f(x_opt)];
end