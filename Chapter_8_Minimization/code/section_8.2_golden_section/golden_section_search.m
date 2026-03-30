%% Chapter 8: Minimization
%  Section 8.2: Golden Section Search
%  Algorithm: Golden Section Search Method
%
%  Finds the minimum of a function on an interval [a,b] using the
%  golden section search method. This method narrows the interval
%  by maintaining specific internal points based on the golden ratio.

a = -1;                          % Left endpoint of interval
b = 2;                           % Right endpoint of interval
tolerance = 10^(-5);             % Convergence tolerance
max_iterations = 100;            % Maximum iteration limit

% Golden ratio constant: r = (sqrt(5)-1)/2 ≈ 0.618
r = (sqrt(5) - 1) / 2;

% Initial interior points: x, y positioned by golden ratio
% x is closer to b, y is closer to a
x = a + r * (b - a);
y = a + (1 - r) * (b - a);

k = 0;
fx = f(x);
fy = f(y);

fprintf('Step %2d,  a=% 10.8f,  y=% 10.8f,  x=% 10.8f,  b=% 10.8f\n', k, a, y, x, b)

%% Golden Section Iteration
% Compare function values at the two interior points and shrink interval
while (b - a) >= tolerance && k < max_iterations
    % If f(x) is larger, minimum is to the left in [a,x]
    if fx > fy
        b = x;           % Right endpoint moves to x
        x = y;           % x becomes the new right interior point
        fx = fy;
        y = a + (1 - r) * (b - a);  % Compute new left interior point
        fy = f(y);
    else
        % If f(x) is smaller, minimum is to the right in [y,b]
        a = y;           % Left endpoint moves to y
        y = x;           % y becomes the new left interior point
        fy = fx;
        x = a + r * (b - a);  % Compute new right interior point
        fx = f(x);
    end

    k = k + 1;
    fprintf('Step %2d,  a=% 10.8f,  y=% 10.8f,  x=% 10.8f,  b=% 10.8f\n', k, a, y, x, b)
end

%% Final Result
% The minimum is approximated as the midpoint of the final interval
output = (a + b) / 2;
fprintf('Minimum point = % 10.8f\n', output)

% For testing purposes
a;          % Left endpoint of final interval
b;          % Right endpoint of final interval
tolerance;  % Tolerance used
f1 = f(a);  % Function value at left endpoint
f2 = f(b);  % Function value at right endpoint
f3 = f((a + b) / 2);  % Function value at midpoint

%% Test Function
% Define the function to minimize: f(x) = x² - 0.8x + 1
function y = f(x)
    y = x^2 - 0.8 * x + 1;
end
