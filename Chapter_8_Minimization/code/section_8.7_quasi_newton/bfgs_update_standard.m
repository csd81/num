%% Chapter 8: Minimization
%  Section 8.7: Quasi-Newton Method - BFGS Update
%  Algorithm: BFGS (Broyden-Fletcher-Goldfarb-Shanno) Standard Implementation
%
%  Implements BFGS quasi-Newton method with finite difference approximation
%  of the initial Hessian. The Hessian is updated at each step using the
%  standard BFGS formula.

% Use column vectors for matrix-vector multiplication
x0 = [2; 2];              % Starting point (2D column vector)
tolerance = 10^(-3);      % Convergence tolerance
h = 0.05;                 % Stepsize for finite difference approximation
max_iter = 100;           % Maximum iterations

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

%% Initialize Hessian Approximation Using Finite Differences
% Compute initial Hessian approximation A0 using finite difference formula
% Second derivative approximation: ∂²f/∂x_i² ≈ (f(x+2h) - 2f(x) + f(x))/h²
% Mixed derivative approximation: ∂²f/∂x_i∂x_j ≈ (f(x+h*e_i+h*e_j) - f(x+h*e_i) - f(x+h*e_j) + f(x))/h²

e1 = [1; 0];            % Unit vector in x-direction
e2 = [0; 1];            % Unit vector in y-direction

% Diagonal elements: second derivatives
a11 = (f(x0 + 2*h*e1) - 2*f(x0 + h*e1) + f(x0)) / h^2;
a22 = (f(x0 + 2*h*e2) - 2*f(x0 + h*e2) + f(x0)) / h^2;

% Off-diagonal elements: mixed partial derivatives
a12 = (f(x0 + h*e2 + h*e1) - f(x0 + h*e1) - f(x0 + h*e2) + f(x0)) / h^2;

% Construct initial Hessian approximation (symmetric)
A = [a11, a12; a12, a22];

x = x0;         % Current point
y = x0 - 1;     % Artificial previous point
k = 0;

fprintf('Step  0,  x=[% 10.8f; % 10.8f],  f(x)=% 8.6e\n', x, f(x))

%% Main Iteration Loop
% Continue until convergence in parameter space
while norm(x - y, 2) >= tolerance && k < max_iter
    y = x;

    % Compute Newton direction using approximate Hessian
    % Solve A*s = -∇f for s using backslash operator (stable)
    s = -A \ df(y);

    % Take the full Newton step (with unit stepsize for quasi-Newton)
    x = y + s;

    % Compute change in gradient
    yy = df(x) - df(y);  % yy = ∇f(x_new) - ∇f(x_old)

    %% BFGS Update Formula
    % A_{k+1} = A_k + (y*y^T)/(y^T*s) - (A_k*s*s^T*A_k)/(s^T*A_k*s)
    % where: y = ∇f(x_{k+1}) - ∇f(x_k)  (change in gradient)
    %        s = x_{k+1} - x_k            (step taken)

    denom1 = yy.' * s;   % y^T * s (scalar)
    denom2 = s.' * A * s; % s^T * A * s (scalar)

    % Rank-2 BFGS update: first rank-1 term, then rank-1 subtraction
    rank1_pos = yy * yy.' / denom1;           % (y*y^T) / (y^T*s)
    rank1_neg = (A * s * s.' * A) / denom2;   % (A*s*s^T*A) / (s^T*A*s)

    A = A + rank1_pos - rank1_neg;

    k = k + 1;
    fprintf('Step %2d,  x=[% 10.8f; % 10.8f],  f(x)=% 8.6e\n', k, x, f(x))
    plot([y(1), x(1)], [y(2), x(2)], '-or', 'MarkerFaceColor', 'r', 'Linewidth', 2)
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
%  1. The initial Hessian is approximated via finite differences.
%     Use step size h based on the scale of the problem.
%
%  2. The BFGS update formula is rank-2, updating the Hessian
%     with information from gradient changes (no second derivatives needed).
%
%  3. The backslash operator (\) solves A*s = -∇f robustly,
%     avoiding explicit matrix inversion.
%
%  4. BFGS maintains positive definiteness of the Hessian approximation
%     throughout the iteration process.
%
%  5. Superlinear convergence near optimum is achieved with BFGS.
