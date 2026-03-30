%% Chapter 10: Ordinary Differential Equations
%  Section 10.5: Runge-Kutta Methods
%  Algorithm: Modified Euler Method (Predictor-Corrector RK2)
%
%  Solves the initial value problem:
%    dy/dt = f(t,y), y(t₀) = y₀
%  using the modified Euler method, another RK2 variant.
%
%  Test IVP: y' = 2y - 10t² + 2t, y(0) = 1
%  Exact solution: y(t) = 5t² + 4t + 2 - exp(2t)

% Parameters
y0 = 1;         % Initial value: y(t₀)
t0 = 0;         % Initial time
T = 1;          % End time of interval
h = 0.1;        % Stepsize

% Setup
n = floor(T / h);  % Number of steps
t = zeros(1, n + 1);  % Time array
z = t;               % Approximation array

t(1) = t0;
z(1) = y0;

fprintf('Modified Euler Method (Predictor-Corrector)\n')
fprintf('y'' = 2y - 10t² + 2t, y(0) = 1\n')
fprintf('Stepsize h = %6.4f\n\n', h)
fprintf('Step %2d,  t=%4.3f,    z=% 10.8f,    error=%8.6e\n', 0, t(1), z(1), abs(z(1) - exact_solution(t(1))))

%% Main Iteration Loop
% Modified Euler method (predictor-corrector):
% Predictor step: z* = z_i + h*f(t_i, z_i)
%                 (Euler step to predict y at t_{i+1})
%
% Corrector step: z_{i+1} = z_i + (h/2)*[f(t_i, z_i) + f(t_{i+1}, z*)]
%                 (Average of slopes at start and predicted endpoint)
%
% This is second-order accurate: O(h³) local error, O(h²) global error.

for i = 1:n
    t(i + 1) = i * h;

    % Predictor step: estimate y at t_{i+1} using Euler's method
    % z* ≈ y(t_{i+1})
    z_pred = z(i) + h * f(t(i), z(i));

    % Corrector step: use trapezoid rule with the predicted point
    % z_{i+1} = z_i + (h/2)*[f(t_i, z_i) + f(t_{i+1}, z*)]
    % This averages the slopes at the initial and predicted final points.
    z(i + 1) = z(i) + (h / 2) * (f(t(i), z(i)) + f(t(i + 1), z_pred));

    % Compare with exact solution
    exact_val = exact_solution(t(i + 1));
    error = abs(z(i + 1) - exact_val);

    fprintf('Step %2d,  t=%4.3f,    z=% 10.8f,    error=%8.6e\n', i, t(i + 1), z(i + 1), error)
end

output = z(n + 1);

%% Visualization
% Plot both exact and approximate solutions
hold on
tt = t0:0.01:T;  % Dense time sampling for smooth exact solution
y_exact = exact_solution(tt);
plot(tt, y_exact, '-b', 'Linewidth', 1.5, 'DisplayName', 'Exact solution')
plot(t, z, '-r', 'Marker', 'o', 'MarkerFaceColor', 'r', 'Linewidth', 2, 'DisplayName', 'Modified Euler')

grid on
xlabel('t (time)', 'FontSize', 12)
ylabel('y(t)', 'FontSize', 12)
legend('Location', 'northwest', 'FontSize', 11)
title('Modified Euler Method: dy/dt = 2y - 10t^2 + 2t', 'FontSize', 14)

% Test variables
output;             % Last value of the sequence
y0;                 % Initial value
t0;                 % Initial time
T;                  % End time
h;                  % Stepsize

%% Right-Hand Side of the ODE
function w = f(t, y)
    w = 2 * y - 10 * t.^2 + 2 * t;
end

%% Exact Solution
function y = exact_solution(t)
    y = 5 * t.^2 + 4 * t + 2 - exp(2 * t);
end

%% NOTES ON MODIFIED EULER METHOD:
%  1. Modified Euler is a second-order Runge-Kutta method.
%     Local error O(h³), global error O(h²).
%
%  2. Also called the "improved Euler method" or "Heun's method" (classical RK2).
%     Uses predictor-corrector structure similar to trapezoidal rule integration.
%
%  3. Predictor step: Euler's method gives a rough estimate z*
%     Corrector step: trapezoid rule uses average slope
%
%  4. Formula can be viewed as:
%     z_{i+1} = z_i + (h/2)*[f(t_i, z_i) + f(t_{i+1}, z_i + h*f(t_i, z_i))]
%     which is the implicit trapezoid rule applied explicitly via the predictor.
%
%  5. Requires 2 function evaluations per step.
%
%  6. More accurate than Euler's method but less expensive than RK4.
%     Good balance between accuracy and computational cost for many problems.
%
%  7. RK4 (section 10.5) provides O(h⁴) accuracy with 4 function evaluations.
