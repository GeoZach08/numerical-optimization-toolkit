clc; clear; close all;

f = @(x) (1/3)*x(1)^2 + 3*x(2)^2;
grad_f = @(x) [(2/3)*x(1); 6*x(2)];

lb = [-10; -8];
ub = [ 5;  12];
proj_func = @(x) min(max(x, lb), ub);

x0 = [8; -10];  
s_k = 0.1;      
gamma_k = 0.2;
epsilon = 0.01;
[x_opt, f_hist, iter, path] = steepest_descent_projection(f, grad_f, proj_func, x0, s_k, gamma_k, epsilon);

fprintf('ΘΕΜΑ 4: Μέγιστη Κάθοδος με Προβολή (Infeasible Start)\n');
fprintf('Αρχικό Σημείο: (%.1f, %.1f) -> ΕΚΤΟΣ ΟΡΙΩΝ\n', x0(1), x0(2));
fprintf('Τερματισμός σε %d επαναλήψεις.\n', iter);
fprintf('Βέλτιστο x: (%.4f, %.4f)\n', x_opt(1), x_opt(2));
fprintf('Ελάχιστη τιμή f: %.4f\n', f_hist(end));

figure('Name', 'Θέμα 4: Διαδρομή από Μη Εφικτό Σημείο');
[X, Y] = meshgrid(-12:0.5:10, -12:0.5:14);
Z = (1/3)*X.^2 + 3*Y.^2;
contour(X, Y, Z, 30); hold on;

rectangle('Position', [-10, -8, 15, 20], 'EdgeColor', 'r', 'LineWidth', 2, 'LineStyle', '--');

plot(path(1,:), path(2,:), 'b.-', 'LineWidth', 1.5, 'MarkerSize', 12);
plot(x0(1), x0(2), 'go', 'MarkerSize', 10, 'LineWidth', 2, 'DisplayName', 'Start (Infeasible)');
plot(x_opt(1), x_opt(2), 'rx', 'MarkerSize', 10, 'LineWidth', 2, 'DisplayName', 'End');

title('Θέμα 4: Σύγκλιση από Μη Εφικτό Σημείο');
xlabel('x_1'); ylabel('x_2');
legend('Ισοϋψείς', 'Περιορισμοί', 'Διαδρομή', 'Start', 'End');
grid on; axis equal;

figure('Name', 'Θέμα 4: Σύγκλιση');
plot(0:length(f_hist)-1, f_hist, 'b-o', 'LineWidth', 1.5);
title('Σύγκλιση Τιμής Συνάρτησης (Θέμα 4)');
xlabel('Επαναλήψεις (k)');
ylabel('f(x_k)');
grid on;