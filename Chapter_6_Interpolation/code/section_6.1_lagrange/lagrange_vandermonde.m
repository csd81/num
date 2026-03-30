function a = lagrange_vandermonde(x, y)
    % LAGRANGE_VANDERMONDE Computes Lagrange polynomial coefficients via Vandermonde system
    %
    % Given n points (x_i, y_i), constructs the polynomial p(x) of degree n-1
    % passing through all points using the Vandermonde matrix system.
    %
    % Mathematical approach:
    %   The Lagrange polynomial is: p(x) = sum_{i=0}^{n-1} a_i * x^i
    %   The Vandermonde system is:
    %     [1    x_1   x_1^2  ... x_1^(n-1) ] [a_1]   [y_1 ]
    %     [1    x_2   x_2^2  ... x_2^(n-1) ] [a_2] = [y_2 ]
    %     [...  ...   ...    ... ...       ] [...] = [...  ]
    %     [1    x_n   x_n^2  ... x_n^(n-1) ] [a_n]   [y_n ]
    %
    %   The condition number of Vandermonde matrices grows exponentially with n,
    %   so this method is suitable only for small n (< 10).
    %
    % Usage: a = lagrange_vandermonde(x, y)
    %
    % Input:
    %   x - vector of x coordinates (column or row vector)
    %   y - vector of y values (column or row vector)
    %
    % Output:
    %   a - vector of polynomial coefficients [a_1, a_2, ..., a_n]
    %       where p(x) = a_1 + a_2*x + a_3*x^2 + ... + a_n*x^(n-1)

    % Ensure column vectors
    x = x(:);
    y = y(:);

    % Check dimensions
    if length(x) ~= length(y)
        error('Dimension mismatch: x and y must have same length')
    end

    n = length(x);

    % Construct Vandermonde matrix
    % V(i,j) = x(i)^(j-1)
    V = zeros(n, n);
    for i = 1:n
        for j = 1:n
            V(i, j) = x(i)^(j-1);
        end
    end

    fprintf('========================================\n');
    fprintf('Lagrange Polynomial via Vandermonde System\n');
    fprintf('========================================\n');
    fprintf('Data points:\n');
    fprintf('  x = '); disp(x');
    fprintf('  y = '); disp(y');

    fprintf('\nVandermonde matrix V:\n');
    disp(V)

    % Check matrix condition: use reciprocal condition number instead of determinant
    % rcond(V) < eps indicates singular or ill-conditioned matrix
    cond_number = rcond(V);
    fprintf('Reciprocal condition number of V: %.6e\n', cond_number);

    if cond_number < eps
        error('Vandermonde matrix is singular or ill-conditioned. Two or more x values may be identical.')
    end

    % Solve system: V * a = y
    % Use backslash for better numerical stability than inv(V)*y
    a = V \ y;

    fprintf('\nPolynomial coefficients a (for p(x) = a_1 + a_2*x + ... + a_n*x^(n-1)):\n');
    disp(a)

    % Verification: evaluate polynomial at input points
    fprintf('Verification (p(x_i) should equal y_i):\n');
    y_computed = V * a;
    fprintf('  Original y: '); disp(y');
    fprintf('  Computed p(x): '); disp(y_computed');
    fprintf('  Max error: %.6e\n', max(abs(y - y_computed)));
end
