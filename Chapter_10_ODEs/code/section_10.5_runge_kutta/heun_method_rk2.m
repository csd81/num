%% Chapter 10: Ordinary Differential Equations
%  Section 10.5: Runge-Kutta Methods
%  Algorithm: Heun Method (RK2 Variant with Weights 1/4, 3/4)
%
%  Solves the initial value problem:
%    dy/dt = f(t,y), y(t₀) = y₀
%  using the Heun method, a predictor-corrector Runge-Kutta variant.
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

fprintf('Heun Method (RK2 variant, weights 1/4, 3/4)\n')
fprintf('y'' = 2y - 10t² + 2t, y(0) = 1\n')
fprintf('Stepsize h = %6.4f\n\n', h)
fprintf('Step %2d,  t=%4.3f,    z=% 10.8f,    error=%8.6e\n', 0, t(1), z(1), abs(z(1) - exact_solution(t(1))))

%% Main Iteration Loop
% Heun method (RK2 predictor-corrector):
% Predictor step: w = z_i + (2h/3)*f(t_i, z_i)
% Corrector step: z_{i+1} = z_i + (h/4)*[f(t_i, z_i) + 3*f(t_i + 2h/3, w)]
%
% This is a second-order accurate method with weights (1/4, 3/4) for the RK2 scheme.
% The evaluation uses unequal weights instead of the classical (1/2, 1/2) weights.

for i = 1:n
    t(i + 1) = i * h;

    % Predictor step: estimate y at t_i + 2h/3
    % w ≈ y(t_i + 2h/3) using first-order extrapolation
    w = z(i) + (2 * h / 3) * f(t(i), z(i));

    % Corrector step: combine two function evaluations with weights
    % z_{i+1} = z_i + (h/4)*[f(t_i, z_i) + 3*f(t_i + 2h/3, w)]
    % Weights: 1/4 for initial slope, 3/4 for predicted slope at 2h/3
    z(i + 1) = z(i) + (h / 4) * (f(t(i), z(i)) + 3 * f(t(i) + 2 * h / 3, w));

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
plot(t, z, '-r', 'Marker', 'o', 'MarkerFaceColor', 'r', 'Linewidth', 2, 'DisplayName', 'Heun RK2')

grid on
xlabel('t (time)', 'FontSize', 12)
ylabel('y(t)', 'FontSize', 12)
legend('Location', 'northwest', 'FontSize', 11)
title('Heun Method (RK2): dy/dt = 2y - 10t^2 + 2t', 'FontSize', 14)

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

%% NOTES ON HEUN METHOD:
%  1. Heun method is a second-order Runge-Kutta (RK2) method.
%     Local error O(h³), global error O(h²).
%
%  2. Uses a predictor-corrector structure:
%     - Predictor: advance with slope information
%     - Corrector: refine using two slope evaluations
%
%  3. Weights (1/4, 3/4) are asymmetric, giving more importance
%     to the slope at 2h/3 rather than at the initial point.
%
%  4. Unlike Euler's method, Heun's method evaluates f at intermediate points,
%     similar to classical RK2 (midpoint method) but with different weights.
%
%  5. Requires 2 function evaluations per step, same cost as classical RK2.
%
%  6. RK4 (section 10.5) is more commonly used due to better accuracy
%     (O(h⁴)) with only 4 function evaluations per step.
