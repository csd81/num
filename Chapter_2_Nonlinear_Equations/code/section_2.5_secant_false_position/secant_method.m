% =========================================================
% Chapter 2, Section 2.5 - Secant Method
% =========================================================
% Purpose: Finds a root of f(x) = 0 using the secant method.
% This method does not require computing the derivative, making it useful
% when f'(x) is difficult or expensive to compute.
%
% Algorithm: At each step, use two previous points q and p to approximate
% the derivative with a finite difference, then compute the next iterate:
%   p_new = p - f(p) * (p - q) / (f(p) - f(q))
%   q = p
%   p = p_new
% This uses the secant line through (q, f(q)) and (p, f(p)) to estimate
% where the root is. The method requires two starting values p0 and p1.
%   - Initialize q = p0, p = p1
%   - For k = 1, 2, 3, ... until convergence:
%     * Compute secant line root: p_new = p - f(p)*(p - q)/(f(p) - f(q))
%     * If |p_new - p| <= tolerance, stop (converged)
%     * Set q = p, p = p_new and continue
%
% Convergence: Superlinear convergence with rate ≈ 1.618 (golden ratio).
% Slower than Newton's method but faster than bisection, and doesn't require
% computing the derivative.
%
% Function(s):
%   f(x) = x^3 + x^2 - 8*x - 12 (has a root at x = 3)
%
% Parameters:
%   p0 (scalar): First initial guess for the root
%   p1 (scalar): Second initial guess for the root (should be different from p0)
%   tolerance (scalar): Convergence criterion for |p_new - p_old|
%   max_iterations (int): Maximum number of iterations to prevent infinite loops
%
% Returns: Prints iteration history showing p and f(p) at each step.
%   output: The computed root approximation
% =========================================================

p0 = 0.0;           % First initial guess for the root
p1 = 0.5;           % Second initial guess for the root
tolerance = 1e-5;   % Convergence criterion: |p_new - p_old| <= tolerance

q = p0;             % q is the older point
p = p1;             % p is the newer point
fprintf('Step %2d,  p=% 10.8f,  f(p)=% 9.4e\n', 0, q, f(q));
fprintf('Step %2d,  p=% 10.8f,  f(p)=% 9.4e\n', 1, p, f(p));

k = 1;

% Main iteration loop - continues until convergence or max iterations reached
while k < 100
    % Check for division-by-zero before computing secant line root
    % Guard: if |f(p) - f(q)| is very small, the secant line is nearly horizontal
    if abs(f(p) - f(q)) < eps
        fprintf('Division by zero: secant line is nearly horizontal\n');
        break;
    end

    % Compute new iterate using secant formula: p_new = p - f(p)*(p-q)/(f(p)-f(q))
    x = p - f(p) * (p - q) / (f(p) - f(q));

    q = p;              % Shift: q becomes the previous p
    p = x;              % p becomes the new iterate

    k = k + 1;
    fprintf('Step %2d,  p=% 10.8f,  f(p)=% 9.4e\n', k, p, f(p));

    % Check for exact solution
    if f(p) == 0
        fprintf('exact solution=%9.7f\n', p);
        output = p;
        break;
    end

    % Check convergence: |p_new - p_old| <= tolerance
    if abs(p - q) <= tolerance
        fprintf('Converged after %d iterations\n', k);
        output = p;
        break;
    end
end

% =========================================================
% Test and verification
% =========================================================
output = p;         % The computed root approximation
f1 = f(p0);         % Function value at first initial guess
f2 = f((p0+p1)/2);  % Function value at midpoint
f3 = f(p1);         % Function value at second initial guess
p0;                 % First initial guess (echo)
p1;                 % Second initial guess (echo)
tolerance;          % Tolerance value (echo)

% =========================================================
% Function definition: test function with known root
% =========================================================
function y = f(x)
    % Test function: f(x) = x^3 + x^2 - 8*x - 12
    % Has roots at x = 3, x = -2
    y = x^3 + x^2 - 8*x - 12;
end
