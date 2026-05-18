clc; clear; close all;


f = @(x) (1/3)*x(1)^2 + 3*x(2)^2;
grad_f = @(x) [(2/3)*x(1); 6*x(2)];


epsilon = 0.001;
gammas = [0.1, 0.3, 3, 5];
titles = {'gamma = 0.1', 'gamma = 0.3', 'gamma = 3', 'gamma = 5'};
x0 = [4; 4]; % Τυχαίο σημείο εκκίνησης διαφορετικό του (0,0)

% Loop για κάθε gamma
figure('Name', 'Θέμα 1: Σύγκλιση Συνάρτησης', 'Position', [100, 100, 1000, 600]);

for i = 1:length(gammas)
    gamma = gammas(i);
    fprintf('Τρέξιμο για gamma = %.1f...\n', gamma);
    
   
    [x_opt, f_hist, iter] = steepest_descent_fixed(f, grad_f, x0, gamma, epsilon);
    
    fprintf('  Iter: %d, Final f: %.4f\n', iter, f_hist(end));
    
    subplot(2, 2, i);
    plot(0:length(f_hist)-1, f_hist, '-o', 'LineWidth', 1.5, 'MarkerSize', 4);
    title(titles{i});
    xlabel('Επαναλήψεις (k)');
    ylabel('f(x_k)');
    grid on;
    
    if gamma >= 3
        set(gca, 'YScale', 'log'); 
        title([titles{i} ' (Log Scale - Απόκλιση)']);
    end
end