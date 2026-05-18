clc;
clear;
close all;

f = @(x,y) (x.^3) .* exp(-x.^2 - y.^4);

[X, Y] = meshgrid(-2.5 : 0.1 : 2.5);

Z = f(X, Y);

figure(1);
surf(X, Y, Z);
title('3D Γραφική Παράσταση της f(x,y) = x^3 e^{-x^2 - y^4}');
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
colorbar;       
colormap jet;  
shading interp; 

figure(2);
contourf(X, Y, Z, 20); 
title('Ισοϋψείς Καμπύλες (Χάρτης)');
xlabel('x');
ylabel('y');
colorbar;
colormap jet;
grid on;