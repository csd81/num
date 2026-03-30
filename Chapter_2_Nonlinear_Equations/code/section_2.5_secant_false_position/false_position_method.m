% =========================================================
% Chapter 2, Section 2.5 - Method of False Position (Regula Falsi)
% =========================================================
% Purpose: Finds a root of f in the interval [a, b] where f(a)*f(b) < 0.
% The method of false position combines the bracketing guarantee of bisection
% with the faster convergence of the secant method.
%
% Algorithm: Like bisection, it maintains an interval [a, b] that brackets
% the root. But instead of using the midpoint, it uses the secant line
% through (a, f(a)) and (b, f(b)) to find the next approximation:
%   p = a - f(a)*(a - b)/(f(a) - f(b))
% Then it updates the interval like bisection: if f(a)*f(p) < 0, set b = p;
% otherwise set a = p. This preserves the bracketing property.
%   - Initialize a = a0, b = b0, verify f(a)*f(b) < 0
%   - For k = 0, 1, 2, ... until convergence:
%     * Compute secant root: p = a - f(a)*(a - b)/(f(a) - f(b))
%     * If f(a)*f(p) < 0, set b = p (root is in [a, p])
%     * Otherwise, set a = p (root is in [p, b])
%     * If |p - p_old| <= tolerance, stop (converged)
%     * Otherwise continue
%
% Convergence: Superlinear convergence (faster than bisection, slower than secant).
% Guaranteed to bracket the root throughout iteration.
%
% Function(s):
%   f(x) = exp(x) - 2*cos(x) (has a root near x ≈ 0.511)
%
% Parameters:
%   a (scalar): Left endpoint of the initial bracketing interval
%   b (scalar): Right endpoint of the initial bracketing interval
%   tolerance (scalar): Convergence criterion for |p_new - p_old|
%   max_iterations (int): Maximum number of iterations (100 in this code)
%
% Returns: Prints iteration history showing interval endpoints and function values.
%   output: The computed root approximation
% =========================================================

a0 = 0.0;           % Left endpoint of initial bracketing interval
b0 = 1.0;           % Right endpoint of initial bracketing interval
tolerance = 1e-5;   % Convergence criterion: |p_new - p_old| <= tolerance

a = a0;
b = b0;

% Verify the initial interval brackets a root (opposite signs)
if f(a) * f(b) >= 0
    error('The function does not satisfy the opposite sign property: f(a)*f(b) must be < 0');
end

% Compute initial false position (secant root)
p = a - f(a) * (a - b) / (f(a) - f(b));  % p = a - f(a)*(a-b)/(f(a)-f(b))
q = a;                                     % q is the previous value of p
k = 0;

% Display header and initial state
fprintf('Step %2d,  a=%10.8f,  p=%10.8f,  b=%10.8f,  f(a)=% 9.4e,  f(p)=% 9.4e,  f(b)=% 9.4e\n', ...
        k, a, p, b, f(a), f(p), f(b));

% Main iteration loop - continues until convergence or max iterations reached
while k < 100
    if f(p) == 0
        % Exact solution found (rare in practice)
        fprintf('exact solution=%9.7f\n', p);
        output = p;
        break;
    elseif f(a) * f(p) < 0
        % Root is in left half [a, p]: set b = p
        b = p;
    else
        % Root is in right half [p, b]: set a = p
        a = p;
    end

    k = k + 1;

    q = p;  % Save current p as previous

    % Compute new false position (secant root): p = a - f(a)*(a-b)/(f(a)-f(b))
    p = a - f(a) * (a - b) / (f(a) - f(b));

    fprintf('Step %2d,  a=%10.8f,  p=%10.8f,  b=%10.8f,  f(a)=% 9.4e,  f(p)=% 9.4e,  f(b)=% 9.4e\n', ...
            k, a, p, b, f(a), f(p), f(b));

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
f1 = f(a0);         % Function value at left endpoint
f2 = f((a0+b0)/2);  % Function value at initial midpoint
f3 = f(b0);         % Function value at right endpoint
a0;                 % Initial interval [a0, b0] (echo)
b0;                 % Initial interval [a0, b0] (echo)
tolerance;          % Tolerance value (echo)

% =========================================================
% Function definition: test function with known root
% =========================================================
function y = f(x)
    % Test function: f(x) = exp(x) - 2*cos(x)
    % Has a root at approximately x ≈ 0.511
    y = exp(x) - 2 * cos(x);
end
