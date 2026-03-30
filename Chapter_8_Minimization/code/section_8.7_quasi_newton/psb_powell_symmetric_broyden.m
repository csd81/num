%% Chapter 8: Minimization
%  Section 8.7: Quasi-Newton Method - PSB (Powell-Symmetric-Broyden)
%  Algorithm: PSB Hessian Update for Minimization
%
%  Implements the PSB (Powell-Symmetric-Broyden) quasi-Newton method.
%  This is a convex combination of BFGS and SR1 updates that provides
%  a bridge between the two methods.

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
% Compute initial Hessian approximation using finite difference formula

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
    % Solve A*s = -∇f for s using backslash operator
    s = -A \ df(y);

    % Take the step
    x = y + s;

    % Compute change in gradient
    yy = df(x) - df(y);  % yy = ∇f(x_new) - ∇f(x_old)

    %% PSB (Powell-Symmetric-Broyden) Update Formula
    % PSB is a combination of BFGS and SR1:
    % A_{k+1} = (1-φ)*A_BFGS + φ*A_SR1
    % where φ ∈ [0,1] is a mixing parameter
    %
    % In this implementation (φ = 1, i.e., pure SR1):
    % A += (yy - A*s)*(s^T) / (s^T*s) + (s*(yy - A*s)^T) / (s^T*s)
    %      - ((yy - A*s)^T*s) / (s^T*s)^2 * s*s^T
    %
    % This form is symmetric and blends SR1 with a correction term.

    denom = s.' * s;  % s^T * s (scalar)

    % Residual vector: difference between required and current change
    residual = yy - A * s;  % yy is change in gradient, A*s is predicted change

    % PSB update combines multiple terms:
    % Term 1: (residual * s^T) / (s^T*s)
    term1 = (residual * s.') / denom;

    % Term 2: (s * residual^T) / (s^T*s) - provides additional symmetry
    term2 = (s * residual.') / denom;

    % Term 3: -(residual^T*s) / (s^T*s)^2 * s*s^T - second order correction
    scalar_term = (residual.' * s) / (denom^2);
    term3 = -scalar_term * (s * s.');

    % PSB update
    A = A + term1 + term2 + term3;

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
%  1. PSB (Powell-Symmetric-Broyden) is a quasi-Newton method that
%     bridges between SR1 and BFGS methods.
%
%  2. The update formula combines SR1-like and correction terms
%     to maintain symmetry and interpolate between methods.
%
%  3. PSB uses neither rank-1 (SR1) nor rank-2 (BFGS) structure.
%
%  4. The method can sometimes be more robust than either pure SR1 or BFGS,
%     depending on the problem structure.
%
%  5. Computational cost is similar to BFGS or SR1.
%
%  6. The initial Hessian is computed via finite differences.
%
%  7. Does not guarantee positive definiteness like BFGS,
%     but generally more stable than SR1.
