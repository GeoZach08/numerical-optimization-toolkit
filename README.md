# Numerical Optimization Algorithms Toolkit

A comprehensive mathematical toolkit implementing and analyzing various 1D and multi-variable numerical optimization algorithms from scratch. Developed as part of the Optimization Techniques course at the Aristotle University of Thessaloniki (AUTH).

## ✨ Features
- **Multi-Variable Optimization:** Custom implementations of Steepest Descent (Gradient Descent), Newton's Method, and the Levenberg-Marquardt algorithm.
- **Constrained Optimization:** Implementation of the Projected Gradient Descent method to ensure algorithm convergence within strict boundary constraints.
- **Stability & Convergence Analysis:** Analytical stability studies based on the eigenvalues of the Hessian matrix to evaluate local minimum convergence rates and system stability.
- **Advanced Data Visualization:** Generation of 3D surface plots and 2D contour maps to visually track the optimization path, step sizes, and convergence behavior of each algorithm.

## 🛠️ Tools & Technologies
- **Environment:** MATLAB
- **Mathematical Concepts:** Multivariable Calculus, Linear Algebra (Hessian and Jacobian matrices, Eigenvalue analysis), Constrained & Unconstrained Optimization.

## 📊 Project Overview
This project strictly avoids the use of built-in, black-box optimization functions. Instead, it focuses on the raw mathematical implementation of descent directions and line-search step sizes. By comparing the execution time, number of iterations, and stability of the Steepest Descent method versus Newton's and Levenberg-Marquardt, the project demonstrates a deep understanding of algorithmic efficiency and performance in complex, non-convex mathematical landscapes.
