%% Chapter 10: Ordinary Differential Equations
%  Section 10.4: Taylor Series Methods
%  Algorithm: Second-Order Taylor Method for ODEs
%
%  Solves the initial value problem:
%    dy/dt = f(t,y), y(t₀) = y₀
%  using a second-order Taylor series expansion.
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
z = t;               % Approximation array

t(1) = t0;
z(1) = y0;

fprintf('Second-Order Taylor Method\n')
fprintf('y'' = 2y - 10t² + 2t, y(0) = 1\n')
fprintf('Stepsize h = %6.4f\n\n', h)
fprintf('Step %2d,  t=%4.3f,    z=% 10.8f,    error=% 10.8f\n', 0, t(1), z(1), abs(z(1) - exact_solution(t(1))))

%% Main Iteration Loop
% Second-order Taylor expansion:
% y(t_{i+1}) ≈ y(t_i) + h*y'(t_i) + (h²/2)*y''(t_i) + O(h³)
%            = y(t_i) + h*f(t_i, y_i) + (h²/2)*f'(t_i, y_i)
%
% Since y'' = ∂f/∂t + ∂f/∂y * ∂y/∂t = ∂f/∂t + ∂f/∂y * f
%         f'(t,y) = ∂f/∂t + (∂f/∂y)*f
%
% For this specific ODE: f(t,y) = 2y - 10t² + 2t
%                       f'(t,y) = -20t + 2 + 2*(2y - 10t² + 2t)
%                               = 4y - 20t² - 16t + 2

for i = 1:n
    % First derivative (ODE RHS)
    f_val = f(t(i), z(i));

    % Second derivative (using Duhamel expansion or chain rule)
    % df/dt = ∂f/∂t + ∂f/∂y * dy/dt
    f1_val = f1(t(i), z(i));

    % Taylor step: z_{i+1} = z_i + h*f + (h²/2)*f'
    z(i + 1) = z(i) + h * f_val + (h^2 / 2) * f1_val;
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
plot(t, z, '-r', 'Marker', 'o', 'MarkerFaceColor', 'r', 'Linewidth', 2, 'DisplayName', 'Taylor order 2')

grid on
xlabel('t (time)', 'FontSize', 12)
ylabel('y(t)', 'FontSize', 12)
legend('Location', 'northwest', 'FontSize', 11)
title('Second-Order Taylor Method: dy/dt = 2y - 10t^2 + 2t', 'FontSize', 14)

% Test variables
output;             % Last value of the sequence
y0;                 % Initial value
t0;                 % Initial time
T;                  % End time
h;                  % Stepsize

%% Right-Hand Side of the ODE
% f(t, y) represents dy/dt
function w = f(t, y)
    w = 2 * y - 10 * t.^2 + 2 * t;
end

%% First Derivative for Taylor Expansion
% f'(t,y) = df/dt + (df/dy)*f
% For f(t,y) = 2y - 10t² + 2t:
%   ∂f/∂t = -20t + 2
%   ∂f/∂y = 2
%   f'(t,y) = -20t + 2 + 2*f(t,y)
%           = -20t + 2 + 2*(2y - 10t² + 2t)
%           = 4y - 20t² - 16t + 2
function w = f1(t, y)
    w = 4 * y - 20 * t.^2 - 16 * t + 2;
end

%% Exact Solution
function y = exact_solution(t)
    y = 5 * t.^2 + 4 * t + 2 - exp(2 * t);
end

%% NOTES ON TAYLOR METHOD:
%  1. Order-2 Taylor method has local truncation error O(h³) and
%     global error O(h²), one order better than Euler's method.
%
%  2. The method uses explicit computation of first derivatives.
%     Second derivatives come from the chain rule applied to f.
%
%  3. For higher order accuracy, higher derivatives must be computed.
%     This can become complicated for complex ODEs.
%
%  4. Method is explicit and easy to implement but requires
%     explicit computation of derivatives.
%
%  5. Runge-Kutta methods (section 10.5) achieve higher order
%     without explicit derivative calculations.
