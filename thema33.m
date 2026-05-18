clc; clear; close all;

f = @(x) (1/3)*x(1)^2 + 3*x(2)^2;
grad_f = @(x) [(2/3)*x(1); 6*x(2)];

lb = [-10; -8];
ub = [ 5;  12];
proj_func = @(x) min(max(x, lb), ub);

x0 = [-5; 10];
s_k_bad = 15;      
gamma_k = 0.1;     
epsilon = 0.01;

fprintf('ΘΕΜΑ 3A: Προβληματικό Σενάριο (s_k=15)\n');
[x_bad, f_bad, iter_bad, path_bad] = steepest_descent_projection(f, grad_f, proj_func, x0, s_k_bad, gamma_k, epsilon);

fprintf('Τερματισμός (ή όριο): %d επαναλήψεις\n', iter_bad);
fprintf('Τελικό x: (%.4f, %.4f)\n', x_bad(1), x_bad(2));
fprintf('Τελική τιμή f: %.4f\n', f_bad(end));

%  Η Πρακτική Λύση (Μείωση του s_k) 
s_k_good = 0.5; 
fprintf('\nΘΕΜΑ 3Β: Πρακτική Λύση (s_k=0.5)\n');
[x_good, f_good, iter_good, path_good] = steepest_descent_projection(f, grad_f, proj_func, x0, s_k_good, gamma_k, epsilon);

fprintf('Τερματισμός: %d επαναλήψεις\n', iter_good);
fprintf('Τελικό x: (%.4f, %.4f)\n', x_good(1), x_good(2));


figure('Name', 'Θέμα 3: Σύγκριση Διαδρομών');
[X, Y] = meshgrid(-12:0.5:7, -10:0.5:14);
Z = (1/3)*X.^2 + 3*Y.^2;
contour(X, Y, Z, 30); hold on;
rectangle('Position', [-10, -8, 15, 20], 'EdgeColor', 'r', 'LineWidth', 2, 'LineStyle', '--');


plot(path_bad(1,:), path_bad(2,:), 'm.-', 'LineWidth', 1, 'DisplayName', 's_k=15 (Ταλάντωση)');

plot(path_good(1,:), path_good(2,:), 'b.-', 'LineWidth', 2, 'DisplayName', 's_k=0.5 (Λύση)');

plot(x0(1), x0(2), 'go', 'MarkerSize', 10, 'LineWidth', 2, 'DisplayName', 'Start');
plot(0, 0, 'k*', 'MarkerSize', 10, 'DisplayName', 'Optimum');

title('Θέμα 3: Ταλάντωση vs Σύγκλιση');
xlabel('x_1'); ylabel('x_2');
legend('show');
grid on; axis equal;

figure('Name', 'Θέμα 3: Σύγκλιση');
semilogy(0:length(f_bad)-1, f_bad, 'm-o', 'LineWidth', 1.5, 'DisplayName', 's_k=15');
hold on;
semilogy(0:length(f_good)-1, f_good, 'b-o', 'LineWidth', 1.5, 'DisplayName', 's_k=0.5');
title('Σύγκλιση Τιμής Συνάρτησης (Θέμα 3)');
xlabel('Επαναλήψεις (k)');
ylabel('f(x_k) (Log Scale)');
legend('show');
grid on;