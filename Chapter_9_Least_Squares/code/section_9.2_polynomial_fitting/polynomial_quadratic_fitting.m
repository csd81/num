%% Chapter 9: Least Squares
%  Section 9.2: Polynomial Fitting
%  Algorithm: Quadratic Least Squares Fitting via Normal Equations
%
%  Fits a quadratic polynomial p(x) = a₂x² + a₁x + a₀ to data points
%  using the method of least squares. Solves the normal equations
%  arising from minimizing the sum of squared errors.

% Data points
x = [-1, 0, 0.5, 1, 2, 2.5, 3];          % x-coordinates
y = [1.4, 1.9, 1.6, 1.7, 0.2, -0.1, -2]; % y-coordinates

n = length(x);

% Guard: Check for empty data
if n < 3
    error('At least 3 data points needed for quadratic fitting');
end

%% Build Normal Equations
% For quadratic fit p(x) = a₂x² + a₁x + a₀, the normal equations are:
% Σ(x^4)*a₂ + Σ(x^3)*a₁ + Σ(x^2)*a₀ = Σ(x²*y)
% Σ(x^3)*a₂ + Σ(x^2)*a₁ + Σ(x)*a₀   = Σ(x*y)
% Σ(x^2)*a₂ + Σ(x)*a₁   + n*a₀     = Σ(y)

A = zeros(3, 3);  % Coefficient matrix for normal equations
b = [0; 0; 0];    % Right-hand side vector

% Accumulate sums
for i = 1:n
    A(1, 1) = A(1, 1) + x(i)^4;
    A(1, 2) = A(1, 2) + x(i)^3;
    A(1, 3) = A(1, 3) + x(i)^2;
    A(2, 3) = A(2, 3) + x(i);
    b(1) = b(1) + x(i)^2 * y(i);
    b(2) = b(2) + x(i) * y(i);
    b(3) = b(3) + y(i);
end

% Fill in symmetric elements
A(2, 1) = A(1, 2);
A(2, 2) = A(1, 3);
A(3, 1) = A(1, 3);
A(3, 2) = A(2, 3);
A(3, 3) = n;

%% Display Normal Equations
fprintf('Normal equations: A*u = b\n')
fprintf('%9.5f*a2 %+9.5f*a1 %+9.5f*a0 = %9.5f\n', A(1, 1), A(1, 2), A(1, 3), b(1))
fprintf('%9.5f*a2 %+9.5f*a1 %+9.5f*a0 = %9.5f\n', A(2, 1), A(2, 2), A(2, 3), b(2))
fprintf('%9.5f*a2 %+9.5f*a1 %+9.5f*a0 = %9.5f\n', A(3, 1), A(3, 2), A(3, 3), b(3))

%% Solve Normal Equations
u = A \ b;  % Backslash operator: stable LU decomposition
a2 = u(1);  % Coefficient of x²
a1 = u(2);  % Coefficient of x
a0 = u(3);  % Constant term

fprintf('\nSolution:\n')
fprintf('a2 (x² coefficient) = %10.8f\n', a2)
fprintf('a1 (x  coefficient) = %10.8f\n', a1)
fprintf('a0 (constant term)  = %10.8f\n\n', a0)

%% Compute Least Squares Error
% Error = Σ(p(x_i) - y_i)²
err = 0;
for i = 1:n
    residual = poly_quad(x(i), a2, a1, a0) - y(i);
    err = err + residual^2;
end

fprintf('Least squares error: %10.8f\n', err)
fprintf('RMSE (root mean squared error): %10.8f\n\n', sqrt(err / n))

%% Visualization
% Plot data points and fitted polynomial
t = x(1):0.05:x(n);  % Dense sampling for smooth curve
z = poly_quad(t, a2, a1, a0);

hold on
plot(x, y, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r', 'DisplayName', 'Data points')
plot(t, z, 'b-', 'LineWidth', 3, 'DisplayName', 'Quadratic fit')

% Add grid and labels
grid on
xlabel('x', 'FontSize', 12)
ylabel('y', 'FontSize', 12)
legend('FontSize', 11)

% Create title with polynomial equation
ttl = sprintf('Quadratic Fit: p(x) = %10.8f*x^2 %+10.8f*x %+10.8f', a2, a1, a0);
title(ttl, 'FontSize', 14)

%% Helper Function
% Evaluate quadratic polynomial at one or more points
function z = poly_quad(t, a2, a1, a0)
    z = a2 * t.^2 + a1 * t + a0;
end
