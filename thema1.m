
clc;        
clear;      
close all; 

fprintf('--- Εκτέλεση Θέματος 1 ---\n');

f1 = @(x) 5.^x + (2 - cos(x)).^2;
f2 = @(x) (x-1).^2 + exp(x-5).*sin(x+3);
f3 = @(x) exp(-3*x) - (sin(x-2)-2).^2;

functions = {f1, f2, f3};
function_names = {'f_1(x)', 'f_2(x)', 'f_3(x)'};

a_init = -1;
b_init = 3;


%% --- ΜΕΛΕΤΗ 1: Σταθερό l = 0.01, Μεταβαλλόμενο epsilon ---
%

fprintf('Εκτελείται η Μελέτη 1 (l=0.01, μεταβαλλόμενο epsilon)...\n');

l_const = 0.01; 

% ΣΗΜΑΝΤΙΚΟ: Ο αλγόριθμος 5.1.1 απαιτεί l > 2*epsilon για να τερματίσει.
% Άρα, πρέπει epsilon < l/2 = 0.005.
epsilon_vector = [0.0045, 0.003, 0.002, 0.001, 0.0005, 0.0001];
eval_results_eps = zeros(length(functions), length(epsilon_vector));

for i = 1:length(functions) 
    for j = 1:length(epsilon_vector) 
        
        current_f = functions{i};
        current_eps = epsilon_vector(j);
        
        [~, ~, ~, evals] = dihotomos(current_f, a_init, b_init, l_const, current_eps);
        eval_results_eps(i, j) = evals;
    end
end


figure('Name', 'Μελέτη 1: Υπολογισμοί vs Epsilon');
hold on;
plot(epsilon_vector, eval_results_eps(1,:), 'r-o', 'LineWidth', 1.5, 'DisplayName', function_names{1});
plot(epsilon_vector, eval_results_eps(2,:), 'g-s', 'LineWidth', 1.5, 'DisplayName', function_names{2});
plot(epsilon_vector, eval_results_eps(3,:), 'b-d', 'LineWidth', 1.5, 'DisplayName', function_names{3});
hold off;
title(['Υπολογισμοί f(x) συναρτήσει του \epsilon (σταθερό l = ' num_str_l(l_const) ')']);
xlabel('Σταθερά Epsilon (\epsilon)');
ylabel('Συνολικοί Υπολογισμοί f(x)');
legend('show', 'Location', 'northeast');
grid on;
set(gca, 'XDir', 'reverse'); % Αντιστροφή άξονα Χ για καλύτερη οπτικοποίηση

%% --- ΜΕΛΕΤΗ 2: Σταθερό epsilon = 0.001, Μεταβαλλόμενο l ---
%

fprintf('Εκτελείται η Μελέτη 2 (epsilon=0.001, μεταβαλλόμενο l)...\n');

epsilon_const = 0.001; 

% Απαιτείται l > 2*epsilon, άρα l > 0.002.
l_vector = [0.5, 0.2, 0.1, 0.05, 0.01, 0.005, 0.003];
eval_results_l = zeros(length(functions), length(l_vector));

for i = 1:length(functions)
    for j = 1:length(l_vector)
        
        current_f = functions{i};
        current_l = l_vector(j);
        
      
        [~, ~, ~, evals] = dihotomos(current_f, a_init, b_init, current_l, epsilon_const);
        eval_results_l(i, j) = evals;
    end
end


figure('Name', 'Μελέτη 2: Υπολογισμοί vs l');
hold on;
plot(l_vector, eval_results_l(1,:), 'r-o', 'LineWidth', 1.5, 'DisplayName', function_names{1});
plot(l_vector, eval_results_l(2,:), 'g-s', 'LineWidth', 1.5, 'DisplayName', function_names{2});
plot(l_vector, eval_results_l(3,:), 'b-d', 'LineWidth', 1.5, 'DisplayName', function_names{3});
hold off;
title(['Υπολογισμοί f(x) συναρτήσει του l (σταθερό \epsilon = ' num_str_eps(epsilon_const) ')']);
xlabel('Τελικό Εύρος l');
ylabel('Συνολικοί Υπολογισμοί f(x)');
legend('show', 'Location', 'northwest');
grid on;
set(gca, 'XDir', 'reverse'); % Αντιστροφή άξονα Χ


%% --- ΜΕΛΕΤΗ 3: Γραφήματα σύγκλισης (ak, bk) ---
%

fprintf('Εκτελείται η Μελέτη 3 (γραφήματα σύγκλισης a_k, b_k)...\n');

l_demo_values = [0.1, 0.01];
colors = {'b', 'r'; 'c', 'm'}; 

epsilon_demo = 0.001; 

for i = 1:length(functions)
    
    current_f = functions{i};
    figure('Name', ['Μελέτη 3: Σύγκλιση [a_k, b_k] για ' function_names{i}]);
    hold on;
    
    for j = 1:length(l_demo_values) 
        current_l = l_demo_values(j);
        
      
        if current_l <= 2 * epsilon_demo
            warning('Παράλειψη σχεδίασης για l=%f, epsilon=%f (l <= 2*epsilon)', current_l, epsilon_demo);
            continue;
        end
        
        
         [~, ~, iters, ~, a_hist, b_hist] = ...
            dihotomos(current_f, a_init, b_init, current_l, epsilon_demo);
        
        k_values = 0:iters; 
       
       plot(k_values, a_hist, 'o-', 'Color', colors{j,1}, ...
             'DisplayName', sprintf('a_k (l=%0.2f)', current_l));
        plot(k_values, b_hist, 's-', 'Color', colors{j,2}, ...
             'DisplayName', sprintf('b_k (l=%0.2f)', current_l));
      
    end
    
    hold off;
    title(['Σύγκλιση [a_k, b_k] για ' function_names{i} ' (\epsilon=' num_str_eps(epsilon_demo) ')']);
    xlabel('Αριθμός Επανάληψης (k)');
    ylabel('Τιμές άκρων διαστήματος');
    legend('show', 'Location', 'best');
    grid on;
end

fprintf('--- Ολοκληρώθηκε το Θέμα 1 ---\n');

function s = num_str_l(val)
    s = num2str(val);
end

function s = num_str_eps(val)
    s = num2str(val);
end