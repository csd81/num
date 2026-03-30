function [x, residuals, iterations] = gauss_seidel_iteration(A, b, x0, tolerance, max_iter)
    % GAUSS_SEIDEL_ITERATION Solves linear system Ax = b using Gauss-Seidel iteration
    %
    % Gauss-Seidel is a stationary iterative method similar to Jacobi but uses
    % the most recently computed values immediately, typically converging faster.
    %
    % Mathematical formula for component i:
    %   x_i^(k+1) = (b_i - sum_{j<i} a_ij*x_j^(k+1) - sum_{j>i} a_ij*x_j^k) / a_ii
    %   or equivalently:
    %   (D + L)*x^(k+1) = b - U*x^k
    %   where:
    %     D = diag(diag(A))         (diagonal part)
    %     L = -tril(A,-1)           (lower triangular)
    %     U = -triu(A,1)            (upper triangular)
    %
    % Convergence requires: spectral radius of (D+L)^(-1)*U < 1
    % Often converges faster than Jacobi for diagonal-dominant matrices.
    %
    % Usage: [x, residuals, iterations] = gauss_seidel_iteration(A, b, x0, tolerance, max_iter)
    %
    % Input:
    %   A - coefficient matrix (n x n)
    %   b - right-hand side vector (n x 1)
    %   x0 - initial guess (n x 1), default = zero vector
    %   tolerance - stopping tolerance for 2-norm of residual, default = 1e-5
    %   max_iter - maximum iterations allowed, default = 1000
    %
    % Output:
    %   x - solution vector (n x 1)
    %   residuals - vector of residual norms at each iteration
    %   iterations - number of iterations performed

    % Input validation and defaults
    if nargin < 3
        x0 = zeros(size(b));
    end
    if nargin < 4
        tolerance = 1e-5;
    end
    if nargin < 5
        max_iter = 1000;
    end

    % Check dimensions
    [n, m] = size(A);
    if n ~= m
        error('Coefficient matrix must be square')
    end
    if length(b) ~= n
        error('Dimension mismatch: size(A,1) must equal length(b)')
    end
    if length(x0) ~= n
        error('Dimension mismatch: x0 must have same length as b')
    end

    % Check diagonal elements
    if any(diag(A) == 0)
        error('Gauss-Seidel method requires non-zero diagonal elements')
    end

    fprintf('========================================\n');
    fprintf('Gauss-Seidel Iteration Method\n');
    fprintf('========================================\n');
    fprintf('Coefficient matrix A:\n'); disp(A);
    fprintf('Right-hand side b:\n'); disp(b');
    fprintf('Initial guess x0:\n'); disp(x0');
    fprintf('Tolerance: %e\n', tolerance);
    fprintf('========================================\n\n');

    % Initialize
    x = x0;
    residuals = [];
    iterations = 0;

    % Print header for iteration output
    fprintf('Iter     ||r||_2          x_1          x_2          x_3\n');
    fprintf('-----    ----------   -----------  -----------  -----------\n');

    % Gauss-Seidel iteration loop
    for k = 0:max_iter
        % Compute residual: r = b - Ax
        residual = b - A * x;
        residual_norm = norm(residual, 2);  % Use 2-norm
        residuals = [residuals; residual_norm];

        % Print current state
        fprintf('%3d    %12.4e', k, residual_norm);
        for i = 1:min(3, n)
            fprintf('  %12.8f', x(i));
        end
        fprintf('\n');

        % Check convergence
        if residual_norm < tolerance
            fprintf('\nConvergence achieved after %d iterations\n', k);
            iterations = k;
            break
        end

        % Check iteration limit
        if k == max_iter
            fprintf('\nMaximum iterations (%d) reached\n', max_iter);
            iterations = max_iter;
            warning('Solution may not have converged to desired tolerance')
            break
        end

        % Gauss-Seidel update: process each component
        for i = 1:n
            % Sum of lower triangular part (using updated values)
            sum_lower = 0;
            for j = 1:i-1
                sum_lower = sum_lower + A(i,j) * x(j);
            end

            % Sum of upper triangular part (using old values)
            sum_upper = 0;
            for j = i+1:n
                sum_upper = sum_upper + A(i,j) * x(j);
            end

            % Update x(i) with formula: x_i^(k+1) = (b_i - sum_lower - sum_upper) / a_ii
            x(i) = (b(i) - sum_lower - sum_upper) / A(i,i);
        end
    end

    fprintf('\nFinal solution:\n');
    disp(x)

    fprintf('Convergence information:\n');
    fprintf('  Final residual norm: %.6e\n', residuals(end));
    fprintf('  Iterations: %d\n', iterations);
end
