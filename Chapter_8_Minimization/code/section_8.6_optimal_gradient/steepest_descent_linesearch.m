%% Chapter 8: Minimization
%  Section 8.6: Steepest Descent with Optimal Line Search
%  Algorithm: Steepest Descent with 1D Minimization
%
%  Minimizes a function using the steepest descent (gradient) method
%  where the stepsize is optimized via 1D golden section search.
%  Uses a 1D simplex method to find the optimal step along each gradient direction.

% Use row vectors in the iteration
x0 = [-1, 4];                % Starting point (2D row vector)
tolerance = 0.005;           % Convergence tolerance on point displacement

% Draw level curves of the function
levelvalues = [0.08, 0.2, 0.5, 1.2, 2.0, 3.5, 5.0, 7., 9.0, 11., 14., ...
    18, 22, 26, 30., 34., 38., 43, 53., 60., 70, 80., 90, 100, 120, 140., ...
    170., 220., 270., 400., 550., 810.];
xinterval = [-2.5, 2.5];
yinterval = [-1., 4.5];
intx1 = xinterval(1):0.05:xinterval(2);
inty1 = yinterval(1):0.05:yinterval(2);
[xx, yy] = meshgrid(intx1, inty1);
zz = fv(xx, yy);
hold on
axis equal
contour(xx, yy, zz, levelvalues, 'b', LineWidth=1.5)

x = x0;         % Current point
y = x0 - 1;     % Artificial previous point
fprintf('Step  0,  x=[% 10.8f, % 10.8f],  f(x)=% 8.6e\n', x, f(x))
k = 0;

%% Main Iteration Loop
% Continue until points are close enough (convergence in parameter)
while norm(x - y, 2) >= tolerance && k < 100
    y = x;

    % Compute normalized gradient direction (steepest descent direction)
    % v = ∇f / ||∇f||_2 is the unit vector in direction of steepest ascent
    v = df(y) / norm(df(y), 2);

    % Find optimal stepsize by minimizing f(x - alpha*v) over alpha >= 0
    % Uses 1D simplex method with initial bracket [0, 1]
    % NOTE: The [0, 1] interval may be too small for some functions
    alpha = simplex1d(y, v, tolerance / 2);

    % Take the steepest descent step
    x = y - alpha * v;

    k = k + 1;
    fprintf('Step %2d,  x=[% 10.8f, % 10.8f],  f(x)=% 8.6e\n', k, x, f(x))
    plot([y(1), x(1)], [y(2), x(2)], '-or', 'MarkerFaceColor', 'r', 'Linewidth', 2)
end

%% Final Result
output = x;
fprintf('minimum point=[% 10.8f,% 10.8f]\n', output)

% Test variables
output;         % Output of the iteration
x0;             % Starting value of the sequence
tolerance;      % Tolerance
f1 = f(x0);     % Function value for testing
f2 = f(x0 - 1); % Function value for testing
f3 = f(x0 + 1); % Function value for testing
df1 = df(x0);   % Gradient for testing
df2 = df(x0 - 1); % Gradient for testing
df3 = df(x0 + 1); % Gradient for testing

%% Test Function
% Minimize: f(x,y) = (x² - 2y)² + 2(x - 1)²
function z = f(u)
    z = (u(1)^2 - 2*u(2))^2 + 2*(u(1) - 1)^2;
end

%% Gradient of Test Function
% ∇f = [∂f/∂x, ∂f/∂y]
function z = df(u)
    z = [4*(u(1)^2 - 2*u(2))*u(1) + 4*(u(1) - 1), -4*(u(1)^2 - 2*u(2))];
end

%% Helper Functions

% Evaluate function on a matrix of points (for contour plotting)
function z = fv(x, y)
    [n, m] = size(x);
    z = zeros(n, m);
    for i = 1:n
        for j = 1:m
            z(i, j) = f([x(i, j), y(i, j)]);
        end
    end
end

% 1D objective function: phi(t) = f(p - t*v) where v is gradient direction
function y = phi(t, p, v)
    y = f(p - t * v);
end

%% 1D Simplex Method for Line Search
% Minimize phi(t) = f(p - t*v) for t >= 0 using 1D golden section search
% Initial simplex bracket: [0, 1] interval
% WARNING: This [0,1] bracket may be too small for some functions - consider widening it
function alpha = simplex1d(p, v, epsilon)
    x = 0;      % Left vertex of the simplex interval
    y = 1;      % Right vertex of the simplex interval
    k = 0;

    % Iterate until interval width is less than epsilon
    while (abs(y - x) >= epsilon) && k < 100
        % Compare function values at the two endpoints
        if phi(x, p, v) < phi(y, p, v)
            % x is the better point, y is worst
            temp = 2.0 * x - y;         % Reflection of y through x
            y = x;
            if phi(temp, p, v) < phi(y, p, v)
                x = temp;               % Accept reflection
            else
                x = (x + temp) / 2.0;   % Contract to midpoint
            end
        else
            % y is better, x is worst
            temp = 2 * y - x;           % Reflection of x through y
            x = y;
            if phi(temp, p, v) < phi(x, p, v)
                y = temp;               % Accept reflection
            else
                y = (y + temp) / 2.0;   % Contract to midpoint
            end
        end
        k = k + 1;
    end

    % Return midpoint of final interval as the optimal stepsize
    alpha = (x + y) / 2;
end
