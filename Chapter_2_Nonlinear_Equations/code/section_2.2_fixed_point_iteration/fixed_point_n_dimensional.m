% =========================================================
% Chapter 2, Section 2.2 - Fixed-Point Iteration (n-dimensional)
% =========================================================
% Purpose: Finds a fixed point of a vector function g: R^n -> R^n using
% fixed-point iteration. The algorithm iterates p_{k+1} = g(p_k) until convergence.
%
% Algorithm: At each step, compute p_new = g(p_old) and check convergence
% using ||p_new - p_old||_inf <= tolerance. Continues until convergence or
% max iterations. For linear fixed-point iteration p_{k+1} = A*p_k + b,
% convergence is guaranteed if the spectral radius of A is less than 1
% (i.e., all eigenvalues have magnitude < 1, making A a contractive mapping).
%   - Initialize p = p0
%   - For k = 0, 1, 2, ... until convergence:
%     * Compute p_new = g(p)
%     * If ||p_new - p_old||_inf <= tolerance, stop (converged)
%     * Otherwise, set p = p_new and continue
%
% Convergence: Linear convergence with rate = spectral radius of A.
% For the test system, eigenvalues of A are 0.3 and -0.1, both with
% magnitude < 1, so the system is contractive and converges.
%
% Function(s):
%   g(p) = A*p + b where A = [0.1, 0.2; 0.2, 0.1], b = [0.3; 0.2]
%   Eigenvalues of A: 0.3 and -0.1 (both have magnitude < 1, contractive)
%
% Parameters:
%   p0 (column vector, n x 1): Initial guess for the fixed point
%   tolerance (scalar): Convergence threshold for ||p_new - p_old||_inf
%   max_iterations (int): Maximum number of iterations to prevent infinite loops
%
% Returns: Prints iteration history showing p and ||f(p)|| at each step.
%   output: The computed approximation to the fixed point (column vector)
% =========================================================

% =========================================================
% Setup: Define the linear contractive system
% =========================================================
A = [0.1, 0.2; 0.2, 0.1];  % Coefficient matrix (spectral radius < 1)
b = [0.3; 0.2];             % Constant vector

p0 = [1; 1];                % Initial guess as a column vector
tolerance = 1e-6;           % Convergence criterion: ||p_new - p_old||_inf <= tolerance

% =========================================================
% Verify spectral radius < 1 for convergence guarantee
% =========================================================
eigenvalues_A = eig(A);
spectral_radius = max(abs(eigenvalues_A));
fprintf('Eigenvalues of A: '); disp(eigenvalues_A');
fprintf('Spectral radius: %8.6f\n', spectral_radius);
if spectral_radius >= 1
    warning('Spectral radius >= 1: convergence may not be guaranteed!');
end
fprintf('\n');

% =========================================================
% Fixed-point iteration loop
% =========================================================
p = p0;           % Initialize to p0
q = p - 1;        % Artificial previous value to ensure first iteration runs
k = 0;

fprintf('Step %2d,  p=[% 12.9f; % 12.9f]\n', k, p(1), p(2));

while k < 100
    q = p;              % Save current p as previous
    p = g(p);           % Compute p_new = g(p_old) = A*p_old + b

    % Check convergence: ||p_new - p_old||_inf <= tolerance
    % Using infinity norm (maximum absolute component difference)
    if norm(p - q, Inf) <= tolerance
        k = k + 1;
        fprintf('Step %2d,  p=[% 12.9f; % 12.9f]\n', k, p(1), p(2));
        fprintf('Converged after %d iterations\n', k);
        break;
    end

    k = k + 1;
    fprintf('Step %2d,  p=[% 12.9f; % 12.9f]\n', k, p(1), p(2));
end

% =========================================================
% Test and verification
% =========================================================
output = p;                      % The converged approximation to the fixed point
g1 = g([1.0; 0.0]);             % Test function value
g2 = g([0.5; 1.5]);             % Test function value
g3 = g([2.0; 3.0]);             % Test function value
p0;                              % Initial value (echo)
tolerance;                       % Tolerance value (echo)

% =========================================================
% Function definition: linear contractive mapping
% =========================================================
function p_new = g(p)
    % Vector function for fixed-point iteration
    % g(p) = A*p + b where A is the coefficient matrix and b is the constant
    % The global variables A and b are accessed from the main script
    A = [0.1, 0.2; 0.2, 0.1];
    b = [0.3; 0.2];
    p_new = A * p + b;  % Linear fixed-point iteration: p_{k+1} = A*p_k + b
end
