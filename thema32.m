clc; clear; close all;

f = @(x) (1/3)*x(1)^2 + 3*x(2)^2;
grad_f = @(x) [(2/3)*x(1); 6*x(2)];

%  Ορισμός Περιορισμών (Box Constraints)
% -10 <= x1 <= 5
% -8  <= x2 <= 12
lb = [-10; -8]; % Lower bounds (Κάτω όρια)
ub = [ 5;  12]; % Upper bounds (Άνω όρια)

% Συνάρτηση Προβολής (Projection Function)
% Αν το x είναι μικρότερο από το κάτω όριο, γίνεται ίσο με το κάτω όριο.
% Αν είναι μεγαλύτερο από το άνω όριο, γίνεται ίσο με το άνω όριο.
proj_func = @(x) min(max(x, lb), ub);

x0 = [5; -5];    
s_k = 5;        
gamma_k = 0.5; 
epsilon = 0.01; 

[x_opt, f_hist, iter, path] = steepest_descent_projection(f, grad_f, proj_func, x0, s_k, gamma_k, epsilon);

fprintf('ΘΕΜΑ 2: Μέγιστη Κάθοδος με Προβολή\n');
fprintf('Αρχικό Σημείο: (%.1f, %.1f)\n', x0(1), x0(2));
fprintf('Τερματισμός σε %d επαναλήψεις.\n', iter);
fprintf('Βέλτιστο x: (%.4f, %.4f)\n', x_opt(1), x_opt(2));
fprintf('Ελάχιστη τιμή f: %.4f\n', f_hist(end));

figure('Name', 'Θέμα 2: Διαδρομή με Προβολή');
[X, Y] = meshgrid(-12:0.5:7, -10:0.5:14);
Z = (1/3)*X.^2 + 3*Y.^2;
contour(X, Y, Z, 20); hold on;

rectangle('Position', [-10, -8, 15, 20], 'EdgeColor', 'r', 'LineWidth', 2, 'LineStyle', '--');

plot(path(1,:), path(2,:), 'k.-', 'LineWidth', 1.5, 'MarkerSize', 12);
plot(x0(1), x0(2), 'go', 'MarkerSize', 10, 'LineWidth', 2); % Start
plot(x_opt(1), x_opt(2), 'rx', 'MarkerSize', 10, 'LineWidth', 2); % End

title('Διαδρομή Μέγιστης Καθόδου με Προβολή');
xlabel('x_1'); ylabel('x_2');
legend('Ισοϋψείς', 'Περιορισμοί', 'Διαδρομή', 'Start', 'End');
grid on;

figure('Name', 'Θέμα 2: Σύγκλιση');
plot(0:length(f_hist)-1, f_hist, 'b-o', 'LineWidth', 1.5);
title('Σύγκλιση Τιμής Συνάρτησης (Θέμα 2)');
xlabel('Επαναλήψεις (k)');
ylabel('f(x_k)');
grid on;