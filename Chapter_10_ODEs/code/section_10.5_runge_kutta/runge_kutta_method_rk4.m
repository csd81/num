%% Chapter 10: Ordinary Differential Equations
%  Section 10.5: Runge-Kutta Methods
%  Algorithm: Classical Runge-Kutta Method of Order 4 (RK4)
%
%  Solves the initial value problem:
%    dy/dt = f(t,y), y(t₀) = y₀
%  using the classical fourth-order Runge-Kutta method (RK4).
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

fprintf('Classical Runge-Kutta Method of Order 4 (RK4)\n')
fprintf('y'' = 2y - 10t² + 2t, y(0) = 1\n')
fprintf('Stepsize h = %6.4f\n\n', h)
fprintf('Step %2d,  t=%4.3f,    z=% 10.8f,    error=%8.6e\n', 0, t(1), z(1), abs(z(1) - exact_solution(t(1))))

%% Main Iteration Loop
% Classical RK4 method with four stages:
%
% w1 = f(t_i, z_i)                                    [slope at beginning]
% w2 = f(t_i + h/2, z_i + (h/2)*w1)                  [slope at midpoint, using w1]
% w3 = f(t_i + h/2, z_i + (h/2)*w2)                  [slope at midpoint, using w2]
% w4 = f(t_i + h, z_i + h*w3)                        [slope at endpoint]
%
% z_{i+1} = z_i + (h/6)*[w1 + 2*w2 + 2*w3 + w4]     [weighted average]
%
% Weights (1/6, 2/6, 2/6, 1/6) emphasize the midpoint evaluations.

for i = 1:n
    t(i + 1) = i * h;

    % Stage 1: Initial slope
    w1 = f(t(i), z(i));

    % Stage 2: Slope at midpoint using initial slope
    w2 = f(t(i) + h / 2, z(i) + (h / 2) * w1);

    % Stage 3: Slope at midpoint using slope from stage 2
    w3 = f(t(i) + h / 2, z(i) + (h / 2) * w2);

    % Stage 4: Slope at endpoint using stage 3 slope
    w4 = f(t(i + 1), z(i) + h * w3);

    % Weighted average of four slopes with weights (1/6, 2/6, 2/6, 1/6)
    z(i + 1) = z(i) + (h / 6) * (w1 + 2 * w2 + 2 * w3 + w4);

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
plot(t, z, '-r', 'Marker', 'o', 'MarkerFaceColor', 'r', 'Linewidth', 2, 'DisplayName', 'RK4')

grid on
xlabel('t (time)', 'FontSize', 12)
ylabel('y(t)', 'FontSize', 12)
legend('Location', 'northwest', 'FontSize', 11)
title('Runge-Kutta 4th Order Method: dy/dt = 2y - 10t^2 + 2t', 'FontSize', 14)

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

%% NOTES ON RK4 METHOD:
%  1. Classical RK4 is fourth-order accurate.
%     Local truncation error: O(h⁵)
%     Global error: O(h⁴)
%
%  2. Requires 4 function evaluations per step.
%     Excellent balance between accuracy and computational cost.
%
%  3. The four stages represent:
%     - Stage 1 (w1): slope at beginning of interval
%     - Stage 2 (w2): slope at midpoint using stage 1 information
%     - Stage 3 (w3): slope at midpoint using stage 2 information
%     - Stage 4 (w4): slope at endpoint using stage 3 information
%
%  4. Weights (1/6, 2/6, 2/6, 1/6) come from Simpson's rule,
%     which is optimal for weighting function values.
%
%  5. The method is explicit (each stage depends only on earlier stages)
%     and self-starting (needs only the initial condition).
%
%  6. RK4 is the de facto standard for non-stiff ODEs.
%     For stiff problems, implicit methods (backward Euler, etc.) are preferred.
%
%  7. For higher accuracy on large intervals, use smaller stepsizes or
%     adaptive step-size control (RK45, RK78, etc.).
%
%  8. Stability constraint: for dy/dt = λy, requires |λh| < 2.8285
%     for stability (better than RK2 or Taylor methods).
