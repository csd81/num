% =========================================================
% Chapter 2, Section 2.7 - Newton's Method (n-dimensional)
% =========================================================
% Purpose: Finds a root of f: R^n -> R^n using Newton's method in n dimensions.
% This solves a system of n nonlinear equations in n unknowns using the
% n-dimensional Newton-Raphson method.
%
% Algorithm: At each step, solve the linear system and compute the next iterate:
%   - Compute the Jacobian matrix J_f(p) (n x n matrix of partial derivatives)
%   - Solve the linear system: J_f(p) * s = f(p) for s
%   - Update: p_new = p - s
%   - If ||p_new - p|| <= tolerance, stop (converged)
%   - Otherwise continue with p = p_new
%
% The Jacobian matrix J_f(x) = [∂f_i/∂x_j] contains all partial derivatives.
% For efficiency, solve J_f(p)*s = f(p) using backslash: s = J_f(p) \ f(p)
% instead of computing the inverse explicitly.
%
% Convergence: Quadratic convergence when J_f(p*) is non-singular at the root p*.
% Requires a good initial guess near the root and J_f(p) invertible throughout.
%
% Function(s):
%   f(x) = [f_1(x); f_2(x)] where:
%     f_1(x,y) = 4*x - exp(x*y) - 3
%     f_2(x,y) = x - y^2 - 3*y - 1
%
%   J_f(x,y) = [∂f_1/∂x,  ∂f_1/∂y;
%               ∂f_2/∂x,  ∂f_2/∂y]
%             = [4 - y*exp(x*y),  -x*exp(x*y);
%                1,               -2*y - 3]
%
% Parameters:
%   p0 (column vector, 2 x 1): Initial guess for the root
%   tolerance (scalar): Convergence criterion for ||p_new - p_old||_inf
%   max_iterations (int): Maximum number of iterations (100 in this code)
%
% Returns: Prints iteration history showing p and ||f(p)||_inf at each step.
%   output: The computed root approximation (column vector)
% =========================================================

p0 = [-1.5; -1.5];  % Initial guess as a column vector (near the root)
tolerance = 1e-5;   % Convergence criterion: ||p_new - p_old||_inf <= tolerance

p = p0;
q = p - 1;          % Artificial previous value to ensure first iteration runs
k = 0;

fprintf('Step %2d,  p=[% 12.9f; % 12.9f], ||f(p)||=% 7.5e\n', k, p(1), p(2), norm(f(p), Inf));

% Main iteration loop - continues until convergence or max iterations reached
while k < 100
    q = p;                          % Save current p as previous iterate

    % Compute the Newton step by solving the linear system
    % J_f(p) * s = f(p)  =>  s = J_f(p) \ f(p)
    % Using backslash avoids computing the inverse explicitly
    s = df(p) \ f(p);               % Solve linear system: Jacobian * s = f(p)

    % Update: p_new = p - s
    p = p - s;

    k = k + 1;
    fprintf('Step %2d,  p=[% 12.9f; % 12.9f], ||f(p)||=% 7.5e\n', k, p(1), p(2), norm(f(p), Inf));

    % Check convergence: ||p_new - p_old||_inf <= tolerance
    if norm(p - q, Inf) <= tolerance
        fprintf('Converged after %d iterations\n', k);
        break;
    end
end

% =========================================================
% Test and verification
% =========================================================
output = p;         % The computed root approximation
f1 = f([1.0; 0.0]); % Function value for testing
f2 = f([0.0; 2.0]); % Function value for testing
f3 = f([2.0; 3.0]); % Function value for testing
df1 = df([1.0; 0.0]);  % Jacobian value for testing
df2 = df([0.0; 2.0]);  % Jacobian value for testing
df3 = df([2.0; 3.0]);  % Jacobian value for testing
p0;                 % Initial guess (echo)
tolerance;          % Tolerance value (echo)

% =========================================================
% Function definitions: system of equations and Jacobian
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

function y = df(x)
    % Jacobian matrix of f(x) (2 x 2 matrix):
    % J_f = [∂f_1/∂x,  ∂f_1/∂y;
    %        ∂f_2/∂x,  ∂f_2/∂y]
    %
    % ∂f_1/∂x = 4 - y*exp(x*y)   (partial of f_1 w.r.t. x)
    % ∂f_1/∂y = -x*exp(x*y)      (partial of f_1 w.r.t. y)
    % ∂f_2/∂x = 1                (partial of f_2 w.r.t. x)
    % ∂f_2/∂y = -2*y - 3         (partial of f_2 w.r.t. y)
    y = [4 - x(2)*exp(x(1)*x(2)), -x(1)*exp(x(1)*x(2));
         1, -2*x(2) - 3];
end
