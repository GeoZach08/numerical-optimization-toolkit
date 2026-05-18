function [ak, bk, iterations, deriv_evals, a_history, b_history] = derivative_bisection(df, a, b, l)

% Έξοδοι:
%   ak           - Το τελικό κάτω όριο
%   bk           - Το τελικό άνω όριο
%   iterations   - Ο συνολικός αριθμός επαναλήψεων
%   deriv_evals  - Ο συνολικός αριθμός υπολογισμών της f'(x)
%   a_history    - Ιστορικό τιμών 'a' για σχεδίαση
%   b_history    - Ιστορικό τιμών 'b' για σχεδίαση

ak = a; 
bk = b; 

deriv_evals = 0; % 
iterations = 0;  
k_index = 1;     

a_history(k_index) = ak;
b_history(k_index) = bk;

while (bk - ak) >= l 
    
    xk = (ak + bk) / 2; 
    df_xk = df(xk);     
    deriv_evals = deriv_evals + 1;
    
    if df_xk == 0
       
        ak = xk;
        bk = xk;
        break; 
        
    elseif df_xk > 0
        bk = xk; 
        
    else % (df_xk < 0)
        ak = xk; 
    end
    
    iterations = iterations + 1;
    k_index = k_index + 1;
    
    a_history(k_index) = ak;
    b_history(k_index) = bk;
    
end 
end