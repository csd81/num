function coeff_table = hermite_interpolation(x, y, yd)
    % HERMITE_INTERPOLATION Computes Hermite interpolating polynomial with derivatives
    %
    % Hermite interpolation constructs a polynomial that passes through given points
    % AND matches specified derivative values at those points.
    %
    % Mathematical approach:
    %   Given n points (x_i, y_i) with derivatives y'_i, construct polynomial p(x)
    %   of degree 2n-1 such that:
    %     p(x_i) = y_i  and  p'(x_i) = y'_i
    %
    %   The method uses repeated nodes in the divided difference table:
    %     For each x_i, we place it twice: x_{2i-1} = x_{2i} = x_i
    %     The 0th divided differences are: f[x_{2i-1}] = f[x_{2i}] = y_i
    %     The 1st divided difference at a repeated node becomes the derivative:
    %       f[x_{2i-1}, x_{2i}] = y'_i  (instead of (y_i - y_i)/(x_i - x_i))
    %
    %   Then apply standard divided difference formula to compute higher order differences.
    %
    % Usage: coeff_table = hermite_interpolation(x, y, yd)
    %
    % Input:
    %   x  - vector of x coordinates (n points) (column or row vector)
    %   y  - vector of y values (n points) (column or row vector)
    %   yd - vector of y derivatives (n points) (column or row vector)
    %
    % Output:
    %   coeff_table - divided difference table (2n x 2n matrix)
    %       Contains all divided differences up to order 2n-1

    % Ensure column vectors
    x = x(:);
    y = y(:);
    yd = yd(:);

    % Check dimensions
    if length(x) ~= length(y)
        error('Dimension mismatch: x and y must have same length')
    end
    if length(y) ~= length(yd)
        error('Dimension mismatch: y and yd must have same length')
    end

    n = length(x);
    m = 2 * n;  % Total number of nodes (with repetitions)

    fprintf('========================================\n');
    fprintf('Hermite Interpolation with Derivatives\n');
    fprintf('========================================\n');
    fprintf('Data points (with derivatives):\n');
    fprintf('  x  = '); disp(x');
    fprintf('  y  = '); disp(y');
    fprintf('  y'' = '); disp(yd');

    % Construct extended node list with repeated nodes
    xx = zeros(m, 1);
    fo = zeros(m, m);  % Divided difference table

    % Initialize with repeated nodes
    for i = 1:n
        xx(2*i-1) = x(i);    % First occurrence of x_i
        xx(2*i) = x(i);      % Second occurrence of x_i
        fo(2*i-1, 1) = y(i);  % 0th difference: y_i
        fo(2*i, 1) = y(i);    % 0th difference: y_i (repeated)
        fo(2*i, 2) = yd(i);   % 1st difference: derivative y'_i
    end

    fprintf('\nExtended node list (with repetitions):\n');
    disp(xx')

    fprintf('\nInitial divided difference table:\n');
    fprintf('Column 1 (0th differences):\n');
    disp(fo(:,1)')
    fprintf('Column 2 (1st differences, derivative at repeated nodes):\n');
    disp(fo(:,2)')

    % Compute remaining divided differences
    for j = 3:m
        for i = j:m
            % Standard divided difference formula
            fo(i,j) = (fo(i,j-1) - fo(i-1,j-1)) / (xx(i) - xx(i-j+1));
        end
    end

    fprintf('\nComplete divided difference table:\n');
    disp(fo)

    % Extract Hermite coefficients (diagonal elements give the coefficients)
    fprintf('\nHermite polynomial coefficients:\n');
    for i = 1:m
        fprintf('a_%d = %.10f\n', i-1, fo(i, i));
    end

    % The Hermite polynomial in divided difference form:
    % p(x) = fo(1,1) + fo(2,2)*(x-x_1) + fo(3,3)*(x-x_1)*(x-x_1)
    %        + fo(4,4)*(x-x_1)*(x-x_1)*(x-x_2) + ...

    fprintf('\nHermite polynomial in divided difference form:\n');
    fprintf('p(x) = a_0\n');
    for k = 2:m
        fprintf('     + a_%d * (x', k-1);
        for j = 1:k-2
            if mod(j,2) == 1
                fprintf(' - x_%d', (j+1)/2);
            else
                fprintf(' - x_%d', j/2);
            end
        end
        fprintf(')\n');
    end

    coeff_table = fo;
end
