function a = newton_divided_differences(x, y)
    % NEWTON_DIVIDED_DIFFERENCES Computes Newton polynomial coefficients via divided differences
    %
    % Given n points (x_i, y_i), constructs the Newton form polynomial using
    % divided differences. More numerically stable than Lagrange/Vandermonde for large n.
    %
    % Mathematical formula:
    %   The Newton polynomial is:
    %     p(x) = f[x_1] + f[x_1,x_2](x-x_1) + f[x_1,x_2,x_3](x-x_1)(x-x_2) + ...
    %   where f[x_i1,...,x_ik] denotes the divided difference:
    %     f[x_i] = y_i  (0th divided difference)
    %     f[x_i,x_j] = (f[x_j] - f[x_i]) / (x_j - x_i)  (1st divided difference)
    %     f[x_i,...,x_k] = (f[x_i+1,...,x_k] - f[x_i,...,x_k-1]) / (x_k - x_i)
    %
    %   The output vector a contains: [f[x_1], f[x_1,x_2], f[x_1,x_2,x_3], ...]
    %
    % Algorithm:
    %   Initialize a(i) = y_i for all i
    %   For j = 2 to n:
    %     For i = n down to j:
    %       a(i) = (a(i) - a(i-1)) / (x(i) - x(i-j+1))
    %
    % Usage: a = newton_divided_differences(x, y)
    %
    % Input:
    %   x - vector of x coordinates (column or row vector)
    %   y - vector of y values (column or row vector)
    %
    % Output:
    %   a - vector of divided difference coefficients
    %       a(i) = f[x_1,...,x_i] (i-th divided difference)

    % Ensure column vectors
    x = x(:);
    y = y(:);

    % Check dimensions
    if length(x) ~= length(y)
        error('Dimension mismatch: x and y must have same length')
    end

    n = length(x);

    fprintf('========================================\n');
    fprintf('Newton Polynomial via Divided Differences\n');
    fprintf('========================================\n');
    fprintf('Data points:\n');
    fprintf('  x = '); disp(x');
    fprintf('  y = '); disp(y');

    % Initialize divided difference table
    % a(i) will store the current divided difference values
    a = y;  % Start with zeroth divided differences (function values)

    fprintf('\nDivided Difference Table:\n');
    fprintf('0th differences: '); disp(a');

    % Build divided difference table
    % Each iteration computes the k-th divided differences
    for j = 2:n
        % For the j-th divided difference level
        for i = n:-1:j
            % Formula: a(i) = f[x_{i-j+1},...,x_i] = (a(i) - a(i-1)) / (x(i) - x(i-j+1))
            a(i) = (a(i) - a(i-1)) / (x(i) - x(i-j+1));
        end

        % Display progress
        fprintf('%dth differences: ', j-1);
        disp(a(j:n)');
    end

    % The coefficients are stored in a(1:n) in order
    % a(1) = f[x_1]
    % a(2) = f[x_1, x_2]
    % a(3) = f[x_1, x_2, x_3]
    % ...

    fprintf('\nNewton polynomial coefficients (divided differences):\n');
    fprintf('a(1) = f[x_1] = %.10f\n', a(1));
    for i = 2:n
        fprintf('a(%d) = f[x_1,...,x_%d] = %.10f\n', i, i, a(i));
    end

    % Construct and display Newton polynomial form
    fprintf('\nNewton polynomial in expanded form:\n');
    fprintf('p(x) = a(1)\n');
    for i = 2:n
        fprintf('     + a(%d) * (x', i);
        for j = 1:i-1
            fprintf(' - x_%d', j);
        end
        fprintf(')\n');
    end

    % Verification: evaluate Newton polynomial at input points
    fprintf('\nVerification (p(x_i) should equal y_i):\n');
    y_computed = zeros(n, 1);
    for i = 1:n
        y_computed(i) = a(1);
        product = 1;
        for j = 1:i-1
            product = product * (x(i) - x(j));
            y_computed(i) = y_computed(i) + a(j+1) * product;
        end
    end

    fprintf('  Original y: '); disp(y');
    fprintf('  Computed p(x): '); disp(y_computed');
    fprintf('  Max error: %.6e\n', max(abs(y - y_computed)));
end
