%% Chapter 9: Least Squares
%  Section 9.3: Nonlinear Fitting - Power Function
%  Algorithm: Log-Linearization for Power Law Fitting
%
%  Fits a power function f(x) = b*x^a to data points using
%  log-linearization. The power form is converted to a linear form
%  ln(y) = a*ln(x) + ln(b) for least squares solving, then transformed
%  back to get power law coefficients.

% Data points
x = [0.5, 1, 1.5, 2.5, 3];         % x-coordinates
y = [0.7, 1.1, 1.6, 2.1, 2.3];     % y-coordinates

% Guard: Check that x and y values are positive
if any(x <= 0) || any(y <= 0)
    error('All x and y values must be positive for power function fitting');
end

n = length(x);

%% Build Linearized Normal Equations
% For power function fit f(x) = b*x^a, we linearize:
% ln(y) = a*ln(x) + ln(b)
% Let X = ln(x), Y = ln(y), then: Y = a*X + ln(b)
%
% Normal equations for linear fit Y = A*X + B:
% Σ(X²)*A + Σ(X)*B = Σ(X*ln(y))
% Σ(X)*A  + n*B    = Σ(ln(y))

A = zeros(2, 2);  % Coefficient matrix
d = [0; 0];       % Right-hand side vector

% Accumulate sums
for i = 1:n
    logx = log(x(i));
    A(1, 1) = A(1, 1) + logx^2;
    A(1, 2) = A(1, 2) + logx;
    d(1) = d(1) + logx * log(y(i));
    d(2) = d(2) + log(y(i));
end

% Fill in symmetric element
A(2, 1) = A(1, 2);
A(2, 2) = n;

%% Display Linearized Normal Equations
fprintf('Linearized normal equations (log-log form): A*u = d\n')
fprintf('%7.5f*A %+7.5f*B = %7.5f\n', A(1, 1), A(1, 2), d(1))
fprintf('%7.5f*A %+7.5f*B = %7.5f\n', A(2, 1), A(2, 2), d(2))

%% Solve Linearized System
u = A \ d;  % Solve for linearized coefficients
AA = u(1);  % Slope: equals 'a' in original power function
BB = u(2);  % Intercept: equals ln(b) in original power function

fprintf('\nLinearized solution:\n')
fprintf('Slope A (exponent a)   = %10.8f\n', AA)
fprintf('Intercept B (ln(b))    = %10.8f\n\n', BB)

%% Transform Back to Power Law Coefficients
a = AA;        % Exponent parameter: directly from linear fit
b = exp(BB);   % Coefficient parameter: exponentiate intercept

fprintf('Power function coefficients:\n')
fprintf('a (exponent)           = %10.8f\n', a)
fprintf('b (coefficient)        = %10.8f\n\n', b)
fprintf('Fitted function: f(x) = %10.8f * x^(%10.8f)\n\n', b, a)

%% Compute Both Linear and Nonlinear Errors
% Linear error: measure fit quality in log-log space
% Nonlinear error: measure fit quality in original space

err_nonlinear = 0;    % Sum of squared residuals in original space
err_linearized = 0;   % Sum of squared residuals in log-log space

for i = 1:n
    % Nonlinear error: difference in original space
    fit_val = powf(x(i), a, b);
    err_nonlinear = err_nonlinear + (fit_val - y(i))^2;

    % Linearized error: difference in log-log space
    logx = log(x(i));
    err_linearized = err_linearized + (AA * logx + BB - log(y(i)))^2;
end

fprintf('Error analysis:\n')
fprintf('Nonlinear least squares error:   %10.8f\n', err_nonlinear)
fprintf('Linearized least squares error:  %10.8f\n', err_linearized)
fprintf('RMSE (nonlinear):                %10.8f\n\n', sqrt(err_nonlinear / n))

%% Visualization
% Plot data points and fitted power function
t = x(1):0.05:x(n);  % Dense sampling for smooth curve
z = powf(t, a, b);

hold on
plot(x, y, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r', 'DisplayName', 'Data points')
plot(t, z, 'b-', 'LineWidth', 3, 'DisplayName', 'Power fit')

% Add grid and labels
grid on
xlabel('x', 'FontSize', 12)
ylabel('y', 'FontSize', 12)
legend('FontSize', 11)

% Create title with power function equation
ttl = sprintf('Power Function Fit: f(x) = %.6f * x^(%.6f)', b, a);
title(ttl, 'FontSize', 14)

%% Helper Function
% Evaluate power function at one or more points
% f(x) = b*x^a
function z = powf(t, a, b)
    z = b * t.^a;
end
