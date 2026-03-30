%% Chapter 8: Minimization
%  Section 8.4: Gradient Method with Constant Stepsize
%  Algorithm: Normalized Gradient Descent with Fixed Stepsize
%
%  Minimizes a function using gradient descent with normalized gradient
%  and constant stepsize. Step size is adjusted based on gradient magnitude
%  to achieve normalized gradient descent behavior.

% Use row vectors in the iteration
x0 = [-1, 4];              % Starting point (2D row vector)
h = 0.3;                   % Stepsize parameter
n = 21;                    % Fixed number of iteration steps
                           % Note: Uses fixed iterations, not convergence criterion

% Draw level curves of the function
levelvalues = [0.08, 0.2, 0.5, 1.2, 2.0, 3.5, 5.0, 7., 9.0, 11., 14., ...
    18, 22, 26, 30., 34., 38., 43, 53., 60., 70, 80., 90, 100, 120, 140., ...
    170., 220., 270., 400., 550., 810.];
xinterval = [-2.5, 2.5];
yinterval = [-1.5, 4.5];
intx1 = xinterval(1):0.05:xinterval(2);
inty1 = yinterval(1):0.05:yinterval(2);
[xx, yy] = meshgrid(intx1, inty1);
zz = fv(xx, yy);
hold on
contour(xx, yy, zz, levelvalues, 'b', LineWidth=1.5)

x = x0;         % Current point
y = x0 - 1;     % Artificial previous point for display purposes
fprintf('Step  0,  x=[% 10.8f, % 10.8f],  f(x)=% 8.6e\n', x, f(x))

%% Main Iteration Loop
% Perform fixed number of gradient steps with normalized stepsize
for k = 1:n
    y = x;
    % Normalize stepsize by gradient magnitude
    % alpha = h / ||∇f(x)||_2 produces normalized gradient descent
    alpha = h / norm(df(y), 2);

    % Gradient step: x_{k+1} = x_k - alpha * ∇f(x_k)
    x = y - alpha * df(y);

    fprintf('Step %2d,  x=[% 10.8f, % 10.8f],  f(x)=% 8.6e\n', k, x, f(x))
    plot([y(1), x(1)], [y(2), x(2)], '-or', 'MarkerFaceColor', 'r', 'Linewidth', 2)
end

%% Final Result
output = x;
fprintf('minimum point=[% 10.8f,% 10.8f]\n', output)

% Test variables
output;         % Output of the iteration
x0;             % Starting value of the sequence
h;              % Stepsize parameter
n;              % Number of iterations
f1 = f(x0);     % Function value for testing
f2 = f(x0 - 1); % Function value for testing
f3 = f(x0 + 1); % Function value for testing
df1 = df(x0);   % Gradient value for testing
df2 = df(x0 - 1); % Gradient value for testing
df3 = df(x0 + 1); % Gradient value for testing

%% Test Function
% Minimize: f(x,y) = (x² - 2y)² + 2(x - 1)²
function z = f(u)
    z = (u(1)^2 - 2*u(2))^2 + 2*(u(1) - 1)^2;
end

%% Gradient of Test Function
% ∇f = [∂f/∂x, ∂f/∂y]
% ∂f/∂x = 4(x² - 2y)*x + 4(x - 1)
% ∂f/∂y = -4(x² - 2y)
function z = df(u)
    z = [4*(u(1)^2 - 2*u(2))*u(1) + 4*(u(1) - 1), -4*(u(1)^2 - 2*u(2))];
end

%% Helper Function
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
