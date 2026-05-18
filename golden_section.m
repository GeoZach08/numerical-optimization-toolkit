function [ak, bk, iterations, func_evals, a_history, b_history] = golden_section(f, a, b, l)

% Έξοδοι:
%   ak           - Το τελικό κάτω όριο
%   bk           - Το τελικό άνω όριο
%   iterations   - Ο συνολικός αριθμός επαναλήψεων
%   func_evals   - Ο συνολικός αριθμός υπολογισμών της f(x)
%   a_history    - Ιστορικό τιμών 'a' για σχεδίαση
%   b_history    - Ιστορικό τιμών 'b' για σχεδίαση

gamma = 0.618;

ak = a; 
bk = b; 
x1k = ak + (1-gamma)*(bk-ak); 
x2k = ak + gamma*(bk-ak);     

f_x1k = f(x1k); 
f_x2k = f(x2k); 

func_evals = 2; 
iterations = 0; 
k_index = 1;    

a_history(k_index) = ak;
b_history(k_index) = bk;

while (bk - ak) >= l 
   
   if f_x1k < f_x2k
        
        bk = x2k;
        x2k = x1k;     
        f_x2k = f_x1k; 
        
        x1k = ak + (1-gamma)*(bk-ak); 
        f_x1k = f(x1k);              
        
   else
        ak = x1k; 
        
        x1k = x2k;     
        f_x1k = f_x2k; 
        
        x2k = ak + gamma*(bk-ak); 
        f_x2k = f(x2k);          
    end
    
    func_evals = func_evals + 1; 
    iterations = iterations + 1;  
    k_index = k_index + 1;
   
    a_history(k_index) = ak;
    b_history(k_index) = bk;
    
end 
end