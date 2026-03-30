%% Chapter 10: Ordinary Differential Equations
%  Section 10.2: Euler's Method
%  Algorithm: Forward Euler Method for Initial Value Problems
%
%  Solves the initial value problem:
%    dy/dt = f(t,y), y(t₀) = y₀
%  using the forward Euler method (first-order explicit method).
%
%  Test IVP: y' = 2y - 10t² + 2t, y(0) = 1
%  Exact solution: y(t) = 5t² + 4t + 2 - exp(2t)

% Parameters
y0 = 1;         % Initial value: y(t₀)
t0 = 0;         % Initial time
T = 1;          % End time of interval
h = 0.2;        % Stepsize

% Setup
n = floor(T / h);  % Number of steps
t = zeros(1, n + 1);  % Time array
z = t;               % Approximation array (reuse allocation)

t(1) = t0;
z(1) = y0;

fprintf('Forward Euler Method\n')
fprintf('y'' = 2y - 10t² + 2t, y(0) = 1\n')
fprintf('Stepsize h = %6.4f\n\n', h)
fprintf('Step %2d,  t=%4.3f,    z=% 10.8f,    error=% 10.8f\n', 0, t(1), z(1), abs(z(1) - exact_solution(t(1))))

%% Main Iteration Loop
% Euler step: z_{i+1} = z_i + h*f(t_i, z_i)
% where: z_i ≈ y(t_i)    (numerical approximation)
%        f(t_i, z_i) ≈ dy/dt|_{t_i,y_i}  (slope at current point)
%        h = t_{i+1} - t_i              (stepsize)

for i = 1:n
    % Euler step: move from (t_i, z_i) to (t_{i+1}, z_{i+1})
    z(i + 1) = z(i) + h * f(t(i), z(i));
    t(i + 1) = i * h;

    % Compare with exact solution
    exact_val = exact_solution(t(i + 1));
    error = abs(z(i + 1) - exact_val);

    fprintf('Step %2d,  t=%4.3f,    z=% 10.8f,    error=% 10.8f\n', i, t(i + 1), z(i + 1), error)
end

output = z(n + 1);

%% Visualization
% Plot both exact and approximate solutions
hold on
tt = t0:0.01:T;  % Dense time sampling for smooth exact solution
y_exact = exact_solution(tt);
plot(tt, y_exact, '-b', 'Linewidth', 1.5, 'DisplayName', 'Exact solution')
plot(t, z, '-r', 'Marker', 'o', 'MarkerFaceColor', 'r', 'Linewidth', 2, 'DisplayName', 'Euler approximation')

grid on
xlabel('t (time)', 'FontSize', 12)
ylabel('y(t)', 'FontSize', 12)
legend('Location', 'northwest', 'FontSize', 11)
title('Forward Euler Method: dy/dt = 2y - 10t^2 + 2t', 'FontSize', 14)

% Test variables
output;             % Last value of the Euler sequence
y0;                 % Initial value
t0;                 % Initial time
T;                  % End time
h;                  % Stepsize

%% Right-Hand Side of the ODE
% f(t, y) represents dy/dt
% For test IVP: dy/dt = 2y - 10t² + 2t
function w = f(t, y)
    w = 2 * y - 10 * t.^2 + 2 * t;
end

%% Exact Solution
% Analytical solution to the IVP for comparison and error analysis
% y(t) = 5t² + 4t + 2 - exp(2t)
function y = exact_solution(t)
    y = 5 * t.^2 + 4 * t + 2 - exp(2 * t);
end

%% ERROR ANALYSIS NOTES:
%  1. Euler's method is first-order (O(h)) in global error.
%     This means if we halve the stepsize, the error approximately halves.
%
%  2. Local truncation error at each step is O(h²), from the Taylor series:
%     y(t_{i+1}) - z_{i+1} = -(h²/2)*y''(ξ) + O(h³)
%
%  3. The method is explicit: z_{i+1} depends only on z_i and earlier values,
%     not on future values, making it easy to compute.
%
%  4. Stability constraint exists: for dy/dt = λy, requires |λh| ≤ 2
%     for stability (conditional stability).
%
%  5. Better methods (RK4, multistep) provide higher-order accuracy.
