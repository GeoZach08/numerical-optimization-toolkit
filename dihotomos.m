function [ak, bk, iterations, func_evals, a_history, b_history] = dihotomos(f, a, b, l, epsilon)


% Έξοδοι:
%   ak           - Το τελικό κάτω όριο
%   bk           - Το τελικό άνω όριο
%   iterations   - Ο συνολικός αριθμός επαναλήψεων
%   func_evals   - Ο συνολικός αριθμός υπολογισμών της f(x)
%   a_history    - Ιστορικό τιμών 'a' για σχεδίαση
%   b_history    - Ιστορικό τιμών 'b' για σχεδίαση

k_index = 1;     
ak = a;
bk = b;

func_evals = 0;  
iterations = 0;  

a_history(k_index) = ak;
b_history(k_index) = bk;

while (bk - ak) > l 
    x1k = (ak + bk) / 2 - epsilon;
    x2k = (ak + bk) / 2 + epsilon;
    f_x1k = f(x1k);
    f_x2k = f(x2k);
    func_evals = func_evals + 2; % 2 νέοι υπολογισμοί ανά επανάληψη

    if f_x1k < f_x2k
        bk = x2k;
    else
        % Διαφορετικά, θέσε a_k+1 = x1k και b_k+1 = b_k (από την εικόνα)
        ak = x1k;
    end
    iterations = iterations + 1;
    k_index = k_index + 1; 
    
    % Αποθήκευση ιστορικού για γραφικές
    a_history(k_index) = ak;
    b_history(k_index) = bk;
end

end