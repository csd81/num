%% Chapter 8: Minimization
%  Section 8.7: Quasi-Newton Method - BFGS Algorithm
%  Algorithm: BFGS (Broyden-Fletcher-Goldfarb-Shanno) Hessian Approximation
%
%  Minimizes a function by approximating the Hessian matrix using
%  the BFGS update formula. This is a quasi-Newton method that avoids
%  explicit computation of the second derivatives.

% Use column vectors in the iteration for matrix-vector multiplication
x0 = [-1; 4];              % Starting point (2D column vector)
tolerance = 10^(-4);       % Convergence tolerance
max_iter = 100;            % Maximum number of iterations

% Initial Hessian approximation: identity matrix
n = length(x0);
H = eye(n);                % Start with identity Hessian approximation

% Draw level curves of the function
levelvalues = [0.08, 0.2, 0.5, 1.2, 2.0, 3.5, 5.0, 7., 9.0, 11., 14., ...
    18, 22, 26, 30., 34., 38., 43, 53., 60., 70, 80., 90, 100, 120, 140., ...
    170., 220., 270., 400., 550., 810.];
xinterval = [-2.5, 2.5];
yinterval = [-2.5, 4.5];
intx1 = xinterval(1):0.05:xinterval(2);
inty1 = yinterval(1):0.05:yinterval(2);
[xx, yy] = meshgrid(intx1, inty1);
zz = fv(xx, yy);
hold on
contour(xx, yy, zz, levelvalues, 'b', LineWidth=1.5)

x = x0;         % Current point
y = x0 - 1;     % Artificial previous point
k = 0;

fprintf('Step  0,  x=[% 10.8f; % 10.8f],  f(x)=% 8.6e\n', x, f(x))

%% Main Iteration Loop
% Continue until convergence in parameter space
while norm(x - y, 2) >= tolerance && k < max_iter
    y = x;
    g = df(y);  % Current gradient

    % Compute Newton direction using approximate Hessian
    % p = -H * ∇f (steepest descent direction with approximate Hessian weighting)
    p = -H * g;

    % Line search: find step length along direction p
    % For simplicity, use exact line search coefficient
    alpha = (g' * g) / (g' * H * g);

    % Update point
    x = y + alpha * p;

    k = k + 1;
    fprintf('Step %2d,  x=[% 10.8f; % 10.8f],  f(x)=% 8.6e\n', k, x, f(x))
    plot([y(1), x(1)], [y(2), x(2)], '-or', 'MarkerFaceColor', 'r', 'Linewidth', 2)

    % BFGS Hessian Update
    g_new = df(x);  % Gradient at new point
    s = x - y;      % Step: s = x_{k+1} - x_k
    y_vec = g_new - g;  % Change in gradient: y = ∇f(x_{k+1}) - ∇f(x_k)

    % BFGS update formula:
    % H_{k+1} = H_k + (y*y^T)/(y^T*s) - (H_k*s*s^T*H_k)/(s^T*H_k*s)
    denom1 = y_vec' * s;
    denom2 = s' * H * s;

    if abs(denom1) > 1e-8 && abs(denom2) > 1e-8
        term1 = (y_vec * y_vec') / denom1;
        term2 = (H * s * s' * H) / denom2;
        H = H + term1 - term2;
    end
end

%% Final Result
output = x;
fprintf('minimum point=[% 10.8f;% 10.8f]\n', output)

% Test variables
output;         % Output of the iteration
x0;             % Starting value
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
% ∇f = [∂f/∂x; ∂f/∂y] (column vector)
function z = df(u)
    z = [4*(u(1)^2 - 2*u(2))*u(1) + 4*(u(1) - 1); -4*(u(1)^2 - 2*u(2))];
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

%% NOTES:
%  1. BFGS maintains a positive definite Hessian approximation,
%     ensuring descent directions throughout optimization.
%
%  2. The BFGS update ensures the approximate Hessian stays
%     positive definite if it starts positive definite.
%
%  3. Superlinear convergence near the optimum (better than
%     gradient descent, approaching Newton's method rate).
%
%  4. Does not require computation of second derivatives,
%     making it practical for high-dimensional problems.
