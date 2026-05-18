
clc;        
clear;     
close all;  


fprintf('--- Εκτέλεση Θέματος 3 (Μέθοδος Fibonacci) ---\n');

f1 = @(x) 5.^x + (2 - cos(x)).^2;
f2 = @(x) (x-1).^2 + exp(x-5).*sin(x+3);
f3 = @(x) exp(-3*x) - (sin(x-2)-2).^2;

functions = {f1, f2, f3};
function_names = {'f_1(x)', 'f_2(x)', 'f_3(x)'};

a_init = -1;
b_init = 3;

epsilon_const = 0.001; 

fprintf('Εκτελείται η Μελέτη 1 (μεταβαλλόμενο l)...\n');

l_vector = [0.5, 0.2, 0.1, 0.05, 0.01, 0.005, 0.001];
eval_results_l = zeros(length(functions), length(l_vector));

for i = 1:length(functions) 
    for j = 1:length(l_vector) 
        
        current_f = functions{i};
        current_l = l_vector(j);
        
        [~, ~, ~, evals] = fibonacci_method(current_f, a_init, b_init, current_l, epsilon_const);
        eval_results_l(i, j) = evals;
    end
end

figure('Name', 'Μελέτη 1 (Θέμα 3): Υπολογισμοί vs l');
hold on;
plot(l_vector, eval_results_l(1,:), 'r-o', 'LineWidth', 1.5, 'DisplayName', function_names{1});
plot(l_vector, eval_results_l(2,:), 'g-s', 'LineWidth', 1.5, 'DisplayName', function_names{2});
plot(l_vector, eval_results_l(3,:), 'b-d', 'LineWidth', 1.5, 'DisplayName', function_names{3});
hold off;
title('Υπολογισμοί f(x) συναρτήσει του l (Μέθοδος Fibonacci)');
xlabel('Τελικό Εύρος l');
ylabel('Συνολικοί Υπολογισμοί f(x)');
legend('show', 'Location', 'northwest');
grid on;
set(gca, 'XDir', 'reverse'); 



fprintf('Εκτελείται η Μελέτη 2 (γραφήματα σύγκλισης a_k, b_k)...\n');

l_demo_values = [0.1, 0.01];
colors = {'b', 'r'; 'c', 'm'}; 

for i = 1:length(functions) 
    
    current_f = functions{i};
    figure('Name', ['Μελέτη 2 (Θέμα 3): Σύγκλιση [a_k, b_k] για ' function_names{i}]);
    hold on;
    
    for j = 1:length(l_demo_values) 
        current_l = l_demo_values(j);
        
        [~, ~, iters, ~, a_hist, b_hist] = ...
            fibonacci_method(current_f, a_init, b_init, current_l, epsilon_const);
        
        k_values = 1:(iters+1); 
        
        plot(k_values, a_hist, 'o-', 'Color', colors{j,1}, ...
             'DisplayName', sprintf('a_k (l=%0.2f)', current_l));
        plot(k_values, b_hist, 's-', 'Color', colors{j,2}, ...
             'DisplayName', sprintf('b_k (l=%0.2f)', current_l));
    end
    
    hold off;
    title(['Σύγκλιση [a_k, b_k] για ' function_names{i} ' (Fibonacci)']);
    xlabel('Δείκτης Επανάληψης (k)');
    ylabel('Τιμές άκρων διαστήματος');
    legend('show', 'Location', 'best');
    grid on;
end

fprintf('--- Ολοκληρώθηκε το Θέμα 3 ---\n');