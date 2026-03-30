%% Chapter 9: Least Squares
%  Section 9.3: Nonlinear Fitting - Exponential Function
%  Algorithm: Log-Linearization for Exponential Fitting
%
%  Fits an exponential function f(x) = b*exp(a*x) to data points
%  using log-linearization. The exponential form is converted to
%  a linear form ln(y) = a*x + ln(b) for least squares solving,
%  then transformed back to get exponential coefficients.

% Data points
x = [0, 1, 1.5, 2, 3, 4];              % x-coordinates
y = [0.3, 0.7, 0.9, 1.2, 1.8, 2.7];   % y-coordinates

% Guard: Check that y values are positive
if any(y <= 0)
    error('All y values must be positive for log linearization');
end

n = length(x);

%% Build Linearized Normal Equations
% For exponential fit f(x) = b*exp(a*x), we linearize:
% ln(y) = a*x + ln(b)
% Let ln(y) = Y, then: Y = a*x + ln(b)
%
% Normal equations for linear fit Y = A*x + B:
% Σ(x²)*A + Σ(x)*B = Σ(x*ln(y))
% Σ(x)*A  + n*B    = Σ(ln(y))

A = zeros(2, 2);  % Coefficient matrix
d = [0; 0];       % Right-hand side vector

% Accumulate sums
for i = 1:n
    A(1, 1) = A(1, 1) + x(i)^2;
    A(1, 2) = A(1, 2) + x(i);
    d(1) = d(1) + x(i) * log(y(i));
    d(2) = d(2) + log(y(i));
end

% Fill in symmetric element
A(2, 1) = A(1, 2);
A(2, 2) = n;

%% Display Linearized Normal Equations
fprintf('Linearized normal equations: A*u = d\n')
fprintf('%7.5f*A %+7.5f*B = %7.5f\n', A(1, 1), A(1, 2), d(1))
fprintf('%7.5f*A %+7.5f*B = %7.5f\n', A(2, 1), A(2, 2), d(2))

%% Solve Linearized System
u = A \ d;  % Solve for linearized coefficients
AA = u(1);  % Slope: equals 'a' in original exponential
BB = u(2);  % Intercept: equals ln(b) in original exponential

fprintf('\nLinearized solution:\n')
fprintf('Slope A (rate a)       = %10.8f\n', AA)
fprintf('Intercept B (ln(b))    = %10.8f\n\n', BB)

%% Transform Back to Exponential Coefficients
a = AA;        % Rate parameter: directly from linear fit
b = exp(BB);   % Amplitude parameter: exponentiate intercept

fprintf('Exponential coefficients:\n')
fprintf('a (rate parameter)     = %10.8f\n', a)
fprintf('b (amplitude)          = %10.8f\n\n', b)
fprintf('Fitted function: f(x) = %10.8f * exp(%10.8f * x)\n\n', b, a)

%% Compute Both Linear and Nonlinear Errors
% Linear error: measure fit quality in log space
% Nonlinear error: measure fit quality in original space

err_nonlinear = 0;    % Sum of squared residuals in original space
err_linearized = 0;   % Sum of squared residuals in log space

for i = 1:n
    % Nonlinear error: difference in original space
    fit_val = expf(x(i), a, b);
    err_nonlinear = err_nonlinear + (fit_val - y(i))^2;

    % Linearized error: difference in log space
    err_linearized = err_linearized + (AA * x(i) + BB - log(y(i)))^2;
end

fprintf('Error analysis:\n')
fprintf('Nonlinear least squares error:   %10.8f\n', err_nonlinear)
fprintf('Linearized least squares error:  %10.8f\n', err_linearized)
fprintf('RMSE (nonlinear):                %10.8f\n\n', sqrt(err_nonlinear / n))

%% Visualization
% Plot data points and fitted exponential function
t = x(1):0.05:x(n);  % Dense sampling for smooth curve
z = expf(t, a, b);

hold on
plot(x, y, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r', 'DisplayName', 'Data points')
plot(t, z, 'b-', 'LineWidth', 3, 'DisplayName', 'Exponential fit')

% Add grid and labels
grid on
xlabel('x', 'FontSize', 12)
ylabel('y', 'FontSize', 12)
legend('FontSize', 11)

% Create title with exponential equation
ttl = sprintf('Exponential Fit: f(x) = %.6f * exp(%.6f * x)', b, a);
title(ttl, 'FontSize', 14)

%% Helper Function
% Evaluate exponential function at one or more points
% f(x) = b*exp(a*x)
function z = expf(t, a, b)
    z = b * exp(a * t);
end
