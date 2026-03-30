% =========================================================
% Chapter 2, Section 2.2 - Fixed-Point Iteration (Scalar)
% =========================================================
% Purpose: Finds a fixed point of a function g(x) = x using fixed-point
% iteration. The algorithm iterates x_{k+1} = g(x_k) until convergence.
%
% Algorithm: At each step, compute x_new = g(x_old) and check convergence
% using |x_new - x_old| <= tolerance. Repeat until convergence or max iterations.
%   - Initialize x = p0
%   - For k = 0, 1, 2, ... until convergence:
%     * Compute x_new = g(x)
%     * If |x_new - x_old| <= tolerance, stop (converged)
%     * Otherwise, set x = x_new and continue
%
% Convergence: Linear convergence with rate |g'(p)| at the fixed point p.
% Requires |g'(p)| < 1 for convergence.
%
% Function(s):
%   g(x) = -1/8*x^3 + x + 1 (test function with fixed point)
%
% Parameters:
%   p0 (scalar): Initial guess for the fixed point
%   tolerance (scalar): Convergence threshold for |x_new - x_old|
%   max_iterations (int): Maximum number of iterations to prevent infinite loops
%
% Returns: Prints iteration history showing x value at each step.
%   output: The computed approximation to the fixed point
% =========================================================

p0 = 0.4;           % Initial guess for the fixed point
tolerance = 1e-5;   % Convergence criterion: |x_new - x_old| <= tolerance

x = p0;
k = 0;
fprintf('Step %2d,  x=%7.5f\n', k, x);

% Main iteration loop - continues until convergence or max iterations reached
while k < 100
    x_new = g(x);   % Compute next iterate: x_{k+1} = g(x_k)

    % Check convergence using standard criterion: |x_new - x_old| <= tolerance
    if abs(x_new - x) <= tolerance
        fprintf('Step %2d,  x=%7.5f\n', k+1, x_new);
        fprintf('Converged after %d iterations\n', k+1);
        x = x_new;
        break;
    end

    x = x_new;
    k = k + 1;
    fprintf('Step %2d,  x=%7.5f\n', k, x);
end

% Test variables for code verification
output = x;      % The converged approximation to the fixed point
g1 = g(1.0);     % Test function value at x=1
g2 = g(2.0);     % Test function value at x=2
g3 = g(5.0);     % Test function value at x=5
p0;              % Initial guess (echo)
tolerance;       % Tolerance value (echo)

% =========================================================
% Function definition: test function with known fixed point
% =========================================================
function y = g(x)
    % Fixed-point iteration function g(x)
    % Solves g(x) = x to find the fixed point
    y = -1/8 * x^3 + x + 1;  % Test function
end
