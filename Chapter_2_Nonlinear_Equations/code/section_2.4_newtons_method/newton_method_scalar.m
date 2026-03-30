% =========================================================
% Chapter 2, Section 2.4 - Newton's Method (Scalar)
% =========================================================
% Purpose: Finds a root of f(x) = 0 using Newton's method (also called
% Newton-Raphson method). This is a 1-dimensional version of Newton's method.
%
% Algorithm: At each step, compute the next iterate using the Newton formula:
%   p_{k+1} = p_k - f(p_k) / f'(p_k)
% The method uses the tangent line to approximate the root.
%   - Initialize p = p0
%   - For k = 0, 1, 2, ... until convergence:
%     * Compute the step: s = f(p) / f'(p)
%     * Update: p_new = p - s
%     * If |p_new - p| <= tolerance, stop (converged)
%     * Otherwise, set p = p_new and continue
%
% Convergence: Quadratic convergence (very fast) when f'(p*) ≠ 0 at the root p*.
% Requires a good initial guess near the root and f'(p) ≠ 0 throughout iteration.
%
% Function(s):
%   f(x) = exp(x) - 2*cos(x) (has a root near x ≈ 0.511)
%   f'(x) = exp(x) + 2*sin(x) (derivative of f)
%
% Parameters:
%   p0 (scalar): Initial guess for the root (should be near the true root)
%   tolerance (scalar): Convergence criterion for |p_new - p_old|
%   max_iterations (int): Maximum number of iterations to prevent infinite loops
%
% Returns: Prints iteration history showing p and ||f(p)|| at each step.
%   output: The computed root approximation
% =========================================================

p0 = 1.5;           % Initial guess for the root (near the actual root)
tolerance = 1e-5;   % Convergence criterion: |p_new - p_old| <= tolerance

p = p0;
q = p - 1;          % Artificial previous value to start the iteration
k = 0;

fprintf('Step %2d,  p=% 12.9f,  f(p)=% 7.5e\n', k, p, f(p));

% Main iteration loop - continues until convergence or max iterations reached
while k < 100
    q = p;                      % Save current p as previous iterate

    % Compute Newton step: s = f(p) / f'(p)
    fp = f(p);                  % Evaluate f at current point
    dfp = df(p);                % Evaluate f' (derivative) at current point

    if abs(dfp) < eps
        warning('Derivative near zero: Newton method may fail');
        break;
    end

    s = fp / dfp;               % Newton step: s = f(p) / f'(p)
    p = p - s;                  % Update: p_new = p - s

    % Check convergence using standard criterion: |p_new - p_old| <= tolerance
    if abs(p - q) <= tolerance
        k = k + 1;
        fprintf('Step %2d,  p=% 12.9f,  f(p)=% 7.5e\n', k, p, f(p));
        fprintf('Converged after %d iterations\n', k);
        break;
    end

    k = k + 1;
    fprintf('Step %2d,  p=% 12.9f,  f(p)=% 7.5e\n', k, p, f(p));
end

% =========================================================
% Test and verification
% =========================================================
output = p;         % The computed root approximation
f1 = f(1.0);        % Function value for testing
f2 = f(0.5);        % Function value for testing
f3 = f(2.0);        % Function value for testing
df1 = df(1.0);      % Derivative value for testing
df2 = df(0.5);      % Derivative value for testing
df3 = df(2.0);      % Derivative value for testing
p0;                 % Initial guess (echo)
tolerance;          % Tolerance value (echo)

% =========================================================
% Function definitions: function and its derivative
% =========================================================
function y = f(x)
    % Target function: f(x) = exp(x) - 2*cos(x)
    % Newton's method finds the root where f(x) = 0
    y = exp(x) - 2 * cos(x);
end

function y = df(x)
    % Derivative of f: f'(x) = exp(x) + 2*sin(x)
    % Newton's method requires this derivative: p_new = p - f(p)/f'(p)
    y = exp(x) + 2 * sin(x);
end
