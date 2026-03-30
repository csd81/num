%% Chapter 8: Minimization
%  Section 8.5: Newton's Method for Minimization
%  Algorithm: Newton's Method using Hessian Matrix
%
%  Minimizes a function using Newton's method, which uses both
%  first and second derivatives (gradient and Hessian).
%  Requires the Hessian matrix to be positive definite.

% System matrix (Hessian of the test function)
A = [4, 2, -1;
     2, 5, 0;         % Coefficient matrix (Hessian)
     -1, 0, 3];

% Right-hand side (related to gradient)
b = [0; 8; 1];        % Right-hand side as column vector
tolerance = 0.001;    % Convergence tolerance
p0 = [3; 3; 3];       % Initial point as column vector

k = 0;
p = p0;
r = b - A * p;

fprintf('Step %2d:  p=[% 10.8f; % 10.8f; % 10.8f]\n', k, p)

%% Main Iteration Loop
% Newton's method: p_{k+1} = p_k - H^{-1} * ∇f(p_k)
% Or equivalently: Solve H*s = ∇f, then p_{k+1} = p_k - s
while norm(r, Inf) >= tolerance && k < 100
    % Residual/gradient at current point
    r = b - A * p;

    % Compute Newton direction: solve A*s = r for s
    % Using backslash (\) is more numerically stable than explicit inversion
    % s = A \ r gives s = A^{-1} * r
    s = A \ r;

    % Newton step with line search coefficient
    alpha = (r.' * r) / (r.' * A * r);
    p = p + alpha * s;

    k = k + 1;
    fprintf('Step %2d:  p=[% 10.8f; % 10.8f; % 10.8f]\n', k, p)
end

%% Final Result
output = p;

% Test variables
output;     % Output of the iteration
p0;         % Starting point
A;          % Hessian matrix (coefficient matrix)
b;          % Gradient vector (right-hand side)
tolerance;  % Convergence tolerance

%% NOTES:
%  1. Newton's method requires the Hessian matrix to be positive definite
%     at the solution point for convergence to a minimum.
%
%  2. The stable way to solve H*s = g is s = H \ g (backslash),
%     NOT s = inv(H) * g. The backslash operator uses LU decomposition
%     which is numerically more robust.
%
%  3. For quadratic functions, Newton's method converges in one step
%     (if H is constant and positive definite).
%
%  4. The parameter alpha provides an additional line search for
%     robustness when the method doesn't start close enough to the optimum.
