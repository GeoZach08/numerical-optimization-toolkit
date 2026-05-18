function [x_opt, f_hist, iter] = steepest_descent_fixed(f, grad_f, x0, gamma, epsilon)
    max_iter = 100; % Βάζουμε όριο για να μην κολλήσει στα ερωτήματα που αποκλίνουν
    
    x = x0;
    f_hist = []; 
    iter = 0;
    
    while iter < max_iter
        % 1. Υπολογισμός τιμής και κλίσης
        val = f(x);
        g = grad_f(x);
        f_hist = [f_hist, val];
        
        % 2. Έλεγχος τερματισμού (αν η κλίση είναι μικρή)
        if norm(g) < epsilon
            break;
        end
        
        % 3. Έλεγχος απόκλισης (αν η τιμή γίνει τεράστια, σταματάμε)
        if val > 1e10
            fprintf('  -> Προειδοποίηση: Ο αλγόριθμος αποκλίνει (f -> Inf)\n');
            break; 
        end
        
        % 4. Βήμα (Update)
        x = x - gamma * g;
        iter = iter + 1;
    end
    x_opt = x;
end