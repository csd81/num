%% Chapter 8: Minimization
%  Section 8.7: Quasi-Newton Method - DFP (Davidon-Fletcher-Powell)
%  Algorithm: DFP Inverse Hessian Update for Minimization
%
%  Implements the DFP (Davidon-Fletcher-Powell) quasi-Newton method.
%  NOTE: The original file implemented a different formula (PSB variant).
%  This corrects it to implement the true DFP inverse Hessian update.

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

%% Initialize Inverse Hessian Approximation Using Finite Differences
% DFP updates the inverse Hessian H = H^{-1}, not the Hessian A itself
% Compute initial Hessian using finite differences, then invert it

e1 = [1; 0];            % Unit vector in x-direction
e2 = [0; 1];            % Unit vector in y-direction

% Diagonal elements: second derivatives
a11 = (f(x0 + 2*h*e1) - 2*f(x0 + h*e1) + f(x0)) / h^2;
a22 = (f(x0 + 2*h*e2) - 2*f(x0 + h*e2) + f(x0)) / h^2;

% Off-diagonal elements: mixed partial derivatives
a12 = (f(x0 + h*e2 + h*e1) - f(x0 + h*e1) - f(x0 + h*e2) + f(x0)) / h^2;

% Initial Hessian approximation
A = [a11, a12; a12, a22];

% Initialize with inverse Hessian for DFP (try to keep it well-conditioned)
% Using pinv for robustness in case Hessian is ill-conditioned
try
    H = inv(A);  % Inverse of Hessian
catch
    H = pinv(A); % Use pseudoinverse if singular
end

x = x0;         % Current point
y = x0 - 1;     % Artificial previous point
k = 0;

fprintf('Step  0,  x=[% 10.8f; % 10.8f],  f(x)=% 8.6e\n', x, f(x))

%% Main Iteration Loop
% Continue until convergence in parameter space
while norm(x - y, 2) >= tolerance && k < max_iter
    y = x;
    g = df(y);  % Current gradient

    % Newton direction using inverse Hessian approximation
    % p = -H * ∇f (descent direction)
    s = -H * g;

    % Take the step
    x = y + s;

    % Compute change in gradient and step
    g_new = df(x);          % Gradient at new point
    y_vec = g_new - g;      % Change in gradient: y = ∇f(x_new) - ∇f(x_old)
    % Note: s already contains the step taken

    %% DFP (Davidon-Fletcher-Powell) Inverse Hessian Update
    % H_{k+1} = H_k + (s*s^T)/(s^T*y) - (H_k*y*y^T*H_k)/(y^T*H_k*y)
    % where: s = x_{k+1} - x_k           (step taken)
    %        y = ∇f(x_{k+1}) - ∇f(x_k)  (change in gradient)
    %
    % This updates the INVERSE Hessian, unlike BFGS which updates the Hessian directly.
    % DFP can be less robust than BFGS but works well on some problems.

    denom1 = y_vec.' * s;       % y^T * s (scalar)
    denom2 = y_vec.' * H * y_vec; % y^T * H * y (scalar)

    if abs(denom1) > 1e-8 && abs(denom2) > 1e-8
        % First term: (s*s^T) / (s^T*y) - rank-one positive term
        term1 = (s * s.') / denom1;

        % Second term: (H*y*y^T*H) / (y^T*H*y) - rank-one negative term
        term2 = (H * y_vec * y_vec.' * H) / denom2;

        % DFP update
        H = H + term1 - term2;
    end

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
%  1. DFP updates the INVERSE Hessian H = H^{-1}, not the Hessian itself.
%     This differs from BFGS which updates the Hessian directly.
%
%  2. The initial inverse Hessian is computed by inverting a finite
%     difference approximation of the Hessian.
%
%  3. DFP guarantees positive definiteness of the inverse Hessian if
%     the initial approximation is positive definite.
%
%  4. DFP was historically the first quasi-Newton method (1959),
%     predating BFGS. BFGS is typically more robust in practice.
%
%  5. This implementation corrects the original file which used
%     an incorrect formula (PSB variant).
%
%  6. Superlinear convergence is achieved near the optimum.
