function [a, b, c, d] = cubic_spline_natural(x, y)
    % CUBIC_SPLINE_NATURAL Computes cubic spline interpolation with natural boundary conditions
    %
    % Constructs piecewise cubic polynomials S_i(t) on each interval [x_i, x_{i+1}]
    % with continuous first and second derivatives at interior knots.
    % Natural boundary conditions: S''(x_1) = 0 and S''(x_n) = 0
    %
    % Mathematical approach:
    %   On interval [x_i, x_{i+1}], define:
    %     S_i(t) = a_i + b_i*(t-x_i) + c_i*(t-x_i)^2 + d_i*(t-x_i)^3
    %   where:
    %     a_i = y_i  (polynomial passes through data points)
    %
    %   Continuity of S, S', S'' gives system of equations:
    %     h_i = x_{i+1} - x_i  (interval width)
    %     dx_i = y_{i+1} - y_i  (difference quotient)
    %
    %   Tridiagonal system for c_i (second derivatives):
    %     h_{i-1}*c_{i-1} + 2*(h_{i-1}+h_i)*c_i + h_i*c_{i+1} = 3*(dx_i/h_i - dx_{i-1}/h_{i-1})
    %
    %   Natural boundary: c_1 = 0, c_n = 0
    %
    %   Then: b_i = dx_i/h_i - h_i*(2*c_i + c_{i+1})/3
    %         d_i = (c_{i+1} - c_i)/(3*h_i)
    %
    % Usage: [a, b, c, d] = cubic_spline_natural(x, y)
    %
    % Input:
    %   x - vector of knot x coordinates (n points, strictly increasing)
    %   y - vector of function values (n points)
    %
    % Output:
    %   a - coefficient vector (length n-1), constant terms
    %   b - coefficient vector (length n-1), linear terms
    %   c - coefficient vector (length n-1), quadratic terms
    %   d - coefficient vector (length n-1), cubic terms

    % Ensure column vectors
    x = x(:);
    y = y(:);

    % Check dimensions
    if length(x) ~= length(y)
        error('Dimension mismatch: x and y must have same length')
    end

    n = length(x);
    if n < 2
        error('At least 2 data points required')
    end

    % Check that x is strictly increasing
    if any(diff(x) <= 0)
        error('X coordinates must be strictly increasing')
    end

    fprintf('========================================\n');
    fprintf('Cubic Spline Interpolation (Natural Boundary Conditions)\n');
    fprintf('========================================\n');
    fprintf('Data points:\n');
    fprintf('  x = '); disp(x');
    fprintf('  y = '); disp(y');

    % Compute interval widths and differences
    h = diff(x);      % h_i = x_{i+1} - x_i
    dy = diff(y);     % dy_i = y_{i+1} - y_i

    fprintf('\nInterval widths h:\n');
    disp(h')
    fprintf('Differences dy:\n');
    disp(dy')

    % Build tridiagonal system for c (second derivatives)
    % Natural boundary conditions: c_1 = 0, c_n = 0
    % Interior equations: h_{i-1}*c_{i-1} + 2*(h_{i-1}+h_i)*c_i + h_i*c_{i+1}
    %                     = 3*(dy_i/h_i - dy_{i-1}/h_{i-1})

    % For n points, we have n-2 interior equations (c_2, ..., c_{n-1})
    A = zeros(n-2, n-2);  % Tridiagonal system matrix
    bb = zeros(n-2, 1);    % Right-hand side

    for i = 1:n-2
        % Build equation for c_{i+1} (interior knot i)
        if i == 1
            % First equation: h_1*c_1 + 2*(h_1+h_2)*c_2 + h_2*c_3 = 3*(dy_2/h_2 - dy_1/h_1)
            % But c_1 = 0 (natural BC), so: 2*(h_1+h_2)*c_2 + h_2*c_3 = 3*(dy_2/h_2 - dy_1/h_1)
            A(i, i) = 2 * (h(1) + h(2));
            A(i, i+1) = h(2);
        elseif i == n-2
            % Last equation: h_{n-2}*c_{n-2} + 2*(h_{n-2}+h_{n-1})*c_{n-1} + h_{n-1}*c_n = ...
            % But c_n = 0 (natural BC), so: h_{n-2}*c_{n-2} + 2*(h_{n-2}+h_{n-1})*c_{n-1} = ...
            A(i, i-1) = h(n-2);
            A(i, i) = 2 * (h(n-2) + h(n-1));
        else
            % Interior equations
            A(i, i-1) = h(i);
            A(i, i) = 2 * (h(i) + h(i+1));
            A(i, i+1) = h(i+1);
        end

        bb(i) = 3 * (dy(i+1)/h(i+1) - dy(i)/h(i));
    end

    fprintf('\nTridiagonal system matrix A (for interior c values):\n');
    disp(A)
    fprintf('Right-hand side bb:\n');
    disp(bb')

    % Solve tridiagonal system
    c_interior = A \ bb;

    % Reconstruct full c vector with boundary conditions
    c_full = [0; c_interior; 0];  % Natural boundary: c_1 = 0, c_n = 0

    fprintf('\nSecond derivatives (c values):\n');
    disp(c_full')

    % Compute b and d coefficients
    a = y(1:n-1);          % a_i = y_i
    b = zeros(n-1, 1);
    d = zeros(n-1, 1);

    for i = 1:n-1
        % b_i = dy_i/h_i - h_i*(2*c_i + c_{i+1})/3
        b(i) = dy(i)/h(i) - h(i)*(2*c_full(i) + c_full(i+1))/3;
        % d_i = (c_{i+1} - c_i)/(3*h_i)
        d(i) = (c_full(i+1) - c_full(i))/(3*h(i));
    end

    c = c_full(1:n-1);  % Use interior c values for output

    fprintf('\nSpline coefficients:\n');
    fprintf('a (constant): '); disp(a');
    fprintf('b (linear): '); disp(b');
    fprintf('c (quadratic): '); disp(c');
    fprintf('d (cubic): '); disp(d');

    fprintf('\nSpline formulas for each interval:\n');
    for i = 1:n-1
        fprintf('S_%d(t) = %.6f + %.6f*(t-%.2f) + %.6f*(t-%.2f)^2 + %.6f*(t-%.2f)^3\n', ...
            i, a(i), b(i), x(i), c(i), x(i), d(i), x(i));
    end

    % Verification: evaluate spline at data points
    fprintf('\nVerification (spline at data points should match y):\n');
    for i = 1:n-1
        S_at_start = a(i);  % S_i(x_i) = a_i
        S_at_end = a(i) + b(i)*h(i) + c(i)*h(i)^2 + d(i)*h(i)^3;
        fprintf('Interval [%.2f, %.2f]: S(%.2f) = %.8f (y = %.8f), S(%.2f) = %.8f (y = %.8f)\n', ...
            x(i), x(i+1), x(i), S_at_start, y(i), x(i+1), S_at_end, y(i+1));
    end
end
