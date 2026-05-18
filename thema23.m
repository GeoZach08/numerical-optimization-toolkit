
clc;
clear;
close all;

f = @(x,y) (x.^3) .* exp(-x.^2 - y.^4);

grad_f = @(x,y) [ exp(-x.^2 - y.^4) * (3*x.^2 - 2*x.^4) ; ...
                  -4 * x.^3 .* y.^3 .* exp(-x.^2 - y.^4) ];

hess_f = @(x,y) [ ...
    exp(-x.^2-y.^4)*(6*x - 14*x.^3 + 4*x.^5),   exp(-x.^2-y.^4)*(-12*x.^2.*y.^3 + 8*x.^4.*y.^3); ...
    exp(-x.^2-y.^4)*(-12*x.^2.*y.^3 + 8*x.^4.*y.^3), exp(-x.^2-y.^4)*(-12*x.^3.*y.^2 + 16*x.^3.*y.^6) ...
];

start_points = [0, 0; -1, -1; 1, 1]; 
step_methods = {'constant', 'min', 'armijo'};
method_titles = {'Σταθερό Βήμα (γ=1)', 'Ελαχιστοποίηση', 'Armijo'};
epsilon = 1e-3;

[X, Y] = meshgrid(-2.5 : 0.05 : 2.5);
Z = f(X, Y);

for m = 1:3
    current_method = step_methods{m};
    
    figure('Name', ['Newton - ' method_titles{m}]);
    contourf(X, Y, Z, 20);
    colorbar; colormap jet; hold on;
    title(['Newton: ' method_titles{m}]);
    xlabel('x'); ylabel('y');
  
    colors = {'w', 'm', 'k'}; 
    
    for p = 1:size(start_points, 1)
        x0 = start_points(p, :)'; 
  
        [x_opt, f_opt, iter, path] = newton_method(f, grad_f, hess_f, x0, epsilon, current_method);

        plot(path(1, :), path(2, :), [colors{p} '.-'], 'LineWidth', 1.5, ...
             'DisplayName', sprintf('Start (%.0f, %.0f)', x0(1), x0(2)));
        plot(x0(1), x0(2), [colors{p} 'o'], 'MarkerSize', 8, 'LineWidth', 2); 
        plot(x_opt(1), x_opt(2), [colors{p} 'x'], 'MarkerSize', 10, 'LineWidth', 2); 

        fprintf('Method: %s | Start: (%.0f, %.0f) | Iter: %d | Final: (%.4f, %.4f)\n', ...
            current_method, x0(1), x0(2), iter, x_opt(1), x_opt(2));
    end
    legend('show');
    hold off;
end

figure('Name', 'Newton: Ταχύτητα Σύγκλισης (Start: -1, -1)');
x0_compare = [-1; -1];
styles = {'r-o', 'g-s', 'b-d'};
hold on;

for m = 1:3
    [~, ~, ~, path] = newton_method(f, grad_f, hess_f, x0_compare, epsilon, step_methods{m});
    f_vals = arrayfun(@(i) f(path(1,i), path(2,i)), 1:size(path,2));
    plot(0:length(f_vals)-1, f_vals, styles{m}, 'LineWidth', 1.5, 'DisplayName', method_titles{m});
end

title('Σύγκλιση Newton (Τιμή f(x), Start: -1, -1)');
xlabel('Επαναλήψεις (k)');
ylabel('Τιμή f(x_k)');
legend('show');
grid on;
hold off;