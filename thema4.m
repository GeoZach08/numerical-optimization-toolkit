
clc;        
clear;      
close all;  

fprintf('--- Εκτέλεση Θέματος 4 (Διχοτόμος με Παράγωγο) ---\n');

f1 = @(x) 5.^x + (2 - cos(x)).^2;
df1 = @(x) log(5).*5.^x + 2.*(2-cos(x)).*sin(x);

f2 = @(x) (x-1).^2 + exp(x-5).*sin(x+3);
df2 = @(x) 2.*(x-1) + exp(x-5).*(sin(x+3) + cos(x+3));

f3 = @(x) exp(-3*x) - (sin(x-2)-2).^2;
df3 = @(x) -3.*exp(-3*x) - 2.*(sin(x-2)-2).*cos(x-2);

deriv_functions = {df1, df2, df3};
function_names = {'f_1(x)', 'f_2(x)', 'f_3(x)'};

a_init = -1;
b_init = 3;


fprintf('Εκτελείται η Μελέτη 1 (μεταβαλλόμενο l)...\n');

l_vector = [0.5, 0.2, 0.1, 0.05, 0.01, 0.005, 0.001];
eval_results_l = zeros(length(deriv_functions), length(l_vector));

for i = 1:length(deriv_functions) 
    for j = 1:length(l_vector) 
        
        current_df = deriv_functions{i};
        current_l = l_vector(j);
        [~, ~, ~, evals] = derivative_bisection(current_df, a_init, b_init, current_l);
        eval_results_l(i, j) = evals;
    end
end

figure('Name', 'Μελέτη 1 (Θέμα 4): Υπολογισμοί f''(x) vs l');
hold on;
plot(l_vector, eval_results_l(1,:), 'r-o', 'LineWidth', 1.5, 'DisplayName', 'f_1''(x)');
plot(l_vector, eval_results_l(2,:), 'g-s', 'LineWidth', 1.5, 'DisplayName', 'f_2''(x)');
plot(l_vector, eval_results_l(3,:), 'b-d', 'LineWidth', 1.5, 'DisplayName', 'f_3''(x)');
hold off;
title('Υπολογισμοί f''(x) συναρτήσει του l (Διχοτόμος με Παράγωγο)');
xlabel('Τελικό Εύρος l');
ylabel('Συνολικοί Υπολογισμοί f''(x)');
legend('show', 'Location', 'northwest');
grid on;
set(gca, 'XDir', 'reverse'); 

fprintf('Εκτελείται η Μελέτη 2 (γραφήματα σύγκλισης a_k, b_k)...\n');


l_demo_values = [0.1, 0.01];
colors = {'b', 'r'; 'c', 'm'}; 

for i = 1:length(deriv_functions) 
    
    current_df = deriv_functions{i};
    figure('Name', ['Μελέτη 2 (Θέμα 4): Σύγκλιση [a_k, b_k] για ' function_names{i}]);
    hold on;
    
    for j = 1:length(l_demo_values) 
        current_l = l_demo_values(j);
        
        [~, ~, iters, ~, a_hist, b_hist] = ...
            derivative_bisection(current_df, a_init, b_init, current_l);
        
        k_values = 1:(iters+1); 
        
        plot(k_values, a_hist, 'o-', 'Color', colors{j,1}, ...
             'DisplayName', sprintf('a_k (l=%0.2f)', current_l));
        plot(k_values, b_hist, 's-', 'Color', colors{j,2}, ...
             'DisplayName', sprintf('b_k (l=%0.2f)', current_l));
    end
    
    hold off;
    title(['Σύγκλιση [a_k, b_k] για ' function_names{i} ' (Διχοτόμος με Παράγωγο)']);
    xlabel('Δείκτης Επανάληψης (k)');
    ylabel('Τιμές άκρων διαστήματος');
    legend('show', 'Location', 'best');
    grid on;
end

fprintf('--- Ολοκληρώθηκε το Θέμα 4 ---\n');