% =========================================================
% Chapter 2, Section 2.8 - Broyden's Method
% =========================================================
% Purpose: Finds a root of f: R^n -> R^n using Broyden's method.
% Broyden's method is a quasi-Newton method that avoids computing and storing
% the full Jacobian matrix at each iteration by using a rank-1 update.
% This is particularly useful for large systems where computing the Jacobian is expensive.
%
% Algorithm: Maintain an approximate inverse Jacobian A (initialized as A0^{-1}).
% At each iteration, update A using a rank-1 correction (Broyden update):
%   - Compute Newton step: s = -A*f(q)  (instead of solving df(q)\f(q))
%   - Update point: p = q + s
%   - Compute function change: y = f(p) - f(q)
%   - Update approximate inverse Jacobian using Broyden formula:
%     A_new = A - (A*y - s)*s'*A / (s'*A*y)
%   - Check for singular update (when s'*A*y ≈ 0) and skip update if needed
%   - If ||s|| <= tolerance, stop (converged)
%   - Otherwise set q = p and continue
%
% Convergence: Superlinear convergence (between linear and quadratic).
% Avoids computing the Jacobian after the initial approximation A0.
%
% Function(s):
%   f(x) = [f_1(x); f_2(x)] where:
%     f_1(x,y) = 4*x - exp(x*y) - 3
%     f_2(x,y) = x - y^2 - 3*y - 1
%
% Parameters:
%   p0 (column vector, 2 x 1): Initial guess for the root
%   tolerance (scalar): Convergence criterion for ||s||_inf (step norm)
%   max_iterations (int): Maximum number of iterations (100 in this code)
%   h (scalar): Step size for finite-difference approximation of initial Jacobian
%
% Returns: Prints iteration history showing p and ||f(p)||_inf at each step.
%   output: The computed root approximation (column vector)
% =========================================================

p0 = [-1.5; -1.5];  % Initial guess as a column vector
tolerance = 1e-5;   % Convergence criterion: ||s||_inf <= tolerance

% Initial computation of approximate Jacobian A0 using finite differences
h = 0.001;          % Step size for finite-difference approximation
e1 = [1; 0];        % Unit vector in x-direction
e2 = [0; 1];        % Unit vector in y-direction

% Approximate Jacobian using finite differences:
% J ≈ [f(p0+h*e1) - f(p0)]/h, [f(p0+h*e2) - f(p0)]/h]
A0 = [(f(p0+h*e1)-f(p0))/h, (f(p0+h*e2)-f(p0))/h];

% Compute initial approximate inverse Jacobian
A = inv(A0);

q = p0;             % Current iterate
k = 0;

fprintf('Step %2d,  p=[% 12.9f; % 12.9f], ||f(p)||=% 7.5e\n', k, q(1), q(2), norm(f(q), Inf));

% Main iteration loop - continues until convergence or max iterations reached
while k < 100
    % Compute Newton step using approximate inverse Jacobian
    s = -A * f(q);              % s = -A*f(q) (Newton step with approximate Jacobian)

    p = q + s;                  % Update: p = q + s

    % Check convergence: ||s||_inf <= tolerance
    if norm(s, Inf) < tolerance
        k = k + 1;
        fprintf('Step %2d,  p=[% 12.9f; % 12.9f], ||f(p)||=% 7.5e\n', k, p(1), p(2), norm(f(p), Inf));
        fprintf('Converged after %d iterations\n', k);
        break;
    end

    % Compute function change: y = f(p) - f(q)
    y = f(p) - f(q);

    % Broyden rank-1 update formula: A_new = A - (A*y - s)*s'*A / (s'*A*y)
    % This updates the approximate inverse Jacobian
    denominator = s.' * A * y;  % Denominator: s'*A*y

    % Guard against singular update: if |s'*A*y| < eps, skip the update
    if abs(denominator) < eps
        fprintf('Singular update detected: |s''*A*y| = %e < eps. Skipping Broyden update.\n', abs(denominator));
        A = A;  % Keep the current A (skip the update)
    else
        % Perform Broyden update
        numerator = (A*y - s) * s.';  % Numerator: (A*y - s)*s'
        A = A - numerator * A / denominator;  % A_new = A - (A*y-s)*s'*A / (s'*A*y)
    end

    q = p;              % Update current point for next iteration
    k = k + 1;
    fprintf('Step %2d,  p=[% 12.9f; % 12.9f], ||f(p)||=% 7.5e\n', k, p(1), p(2), norm(f(p), Inf));
end

% =========================================================
% Test and verification
% =========================================================
output = p;         % The computed root approximation
f1 = f([1.0; 0.0]); % Function value for testing
f2 = f([0.0; 2.0]); % Function value for testing
f3 = f([2.0; 3.0]); % Function value for testing
p0;                 % Initial guess (echo)
tolerance;          % Tolerance value (echo)

% =========================================================
% Function definition: system of equations
% =========================================================
function y = f(x)
    % System of two nonlinear equations:
    % f_1(x,y) = 4*x - exp(x*y) - 3 = 0
    % f_2(x,y) = x - y^2 - 3*y - 1 = 0
    % Input x is a column vector [x; y]
    % Output y is a column vector [f_1(x,y); f_2(x,y)]
    y = [4*x(1) - exp(x(1)*x(2)) - 3;
         x(1) - x(2)^2 - 3*x(2) - 1];
end
