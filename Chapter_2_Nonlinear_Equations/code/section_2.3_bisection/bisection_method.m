% =========================================================
% Chapter 2, Section 2.3 - Bisection Method
% =========================================================
% Purpose: Finds a root of f in the interval [a, b] where f(a)*f(b) < 0.
% The bisection method guarantees convergence when f is continuous and the
% initial interval brackets a root.
%
% Algorithm: At each step, evaluate f at the midpoint c = (a+b)/2.
%   - If f(a)*f(c) < 0, the root is in [a,c], so set b = c
%   - Otherwise, the root is in [c,b], so set a = c
%   - Repeat until the interval width |b - a| <= tolerance
%
% Convergence: Guaranteed linear convergence with rate 0.5 per iteration.
% After n iterations, the interval width is halved n times from the original.
%
% Function(s):
%   f(x) = exp(x) - 2*cos(x) (has a root in [0, 1])
%
% Parameters:
%   a (scalar): Left endpoint of the initial bracketing interval
%   b (scalar): Right endpoint of the initial bracketing interval
%   tolerance (scalar): Convergence criterion for interval width |b - a|
%   max_iterations (int): Maximum number of iterations (100 in this code)
%
% Returns: Prints iteration history showing interval endpoints and function values.
%   output: The computed root approximation (midpoint of final interval)
% =========================================================

a0 = 0.0;           % Left endpoint of initial bracketing interval
b0 = 1.0;           % Right endpoint of initial bracketing interval
tolerance = 1e-5;   % Convergence criterion: |b - a| <= tolerance

a = a0;
b = b0;

% Verify the initial interval brackets a root (opposite signs)
if f(a) * f(b) >= 0
    error('The function does not satisfy the opposite sign property: f(a)*f(b) must be < 0');
end

p = (a + b) / 2;    % Compute initial midpoint
k = 0;

% Display header and initial state
fprintf('Step %2d,  a=%9.7f,  p=%9.7f,  b=%9.7f,  f(a)=% 9.7e,  f(p)=% 9.7e,  f(b)=% 9.7e\n', ...
        k, a, p, b, f(a), f(p), f(b));

% Main iteration loop - continues until interval is small enough or max iterations
while abs(b - a) > tolerance && k < 100
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
    p = (a + b) / 2;  % New midpoint: c = (a+b)/2

    fprintf('Step %2d,  a=%9.7f,  p=%9.7f,  b=%9.7f,  f(a)=% 9.7e,  f(p)=% 9.7e,  f(b)=% 9.7e\n', ...
            k, a, p, b, f(a), f(p), f(b));
end

% =========================================================
% Test and verification
% =========================================================
output = p;         % The computed root approximation
f1 = f(a0);         % Function value at left endpoint
f2 = f((a0 + b0)/2);% Function value at initial midpoint
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
