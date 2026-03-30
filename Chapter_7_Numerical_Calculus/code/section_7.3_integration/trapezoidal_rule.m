function I = trapezoidal_rule(f, a, b)
    % TRAPEZOIDAL_RULE Computes approximate integral using composite trapezoidal rule
    %
    % Trapezoidal rule approximates the integral of f over [a,b] using linear
    % interpolation over subintervals. Simple and robust, though less accurate
    % than Simpson's rule for smooth functions.
    %
    % Mathematical formula:
    %   Composite trapezoidal rule with n subintervals:
    %     I ≈ (h/2) * [f(x_0) + 2*f(x_1) + 2*f(x_2) + ... + 2*f(x_{n-1}) + f(x_n)]
    %   where h = (b-a)/n and weights are: 1, 2, 2, ..., 2, 1
    %
    %   Each trapezoid has area = (h/2) * (f(x_i) + f(x_{i+1}))
    %   Total integral approximation sums all trapezoids
    %
    %   Error: |I - integral| <= (b-a)^3 / (12*n^2) * max|f''|
    %   Error decreases as O(n^-2), making it less accurate than Simpson (O(n^-4))
    %
    % Usage: I = trapezoidal_rule(f, a, b)
    %
    % Input:
    %   f - function handle (must be vectorizable)
    %   a - lower integration limit
    %   b - upper integration limit
    %
    % Output:
    %   I - approximate integral value

    % Prompt for number of subintervals
    n = input('Into how many parts divide the interval? ');

    if n < 1 || floor(n) ~= n
        error('Number of subintervals must be positive integer')
    end

    % Compute step size
    h = (b - a) / n;

    % Generate integration points
    x = a:h:b;

    % Initialize sum with boundary terms
    % m = f(a) + f(b) with weights 1 each
    m = f(a) + f(b);

    fprintf('========================================\n');
    fprintf('Trapezoidal Rule Integration\n');
    fprintf('========================================\n');
    fprintf('Integrand: f(x)\n');
    fprintf('Interval: [%.6f, %.6f]\n', a, b);
    fprintf('Number of subintervals: %d\n', n);
    fprintf('Step size h: %.10f\n\n', h);

    % Add interior points with weight 2
    fprintf('Integration points and weights:\n');
    fprintf('i  x_i         f(x_i)         weight  contribution\n');
    fprintf('-  --------   -----------      -----  -----------\n');

    fprintf('%d  %.8f  %12.8f       1    %12.8f\n', 0, a, f(a), f(a));

    for i = 2:n
        f_val = f(x(i));
        m = m + 2*f_val;

        if i <= 5 || i > n-3  % Print first and last few
            fprintf('%d  %.8f  %12.8f       2    %12.8f\n', i-1, x(i), f_val, 2*f_val);
        elseif i == 6
            fprintf('...  (...interior points omitted...)\n');
        end
    end

    fprintf('%d  %.8f  %12.8f       1    %12.8f\n', n, b, f(b), f(b));

    % Multiply by h/2
    m = h/2 * m;

    fprintf('\nApproximate integral: I ≈ %.10f\n', m);
    fprintf('(h/2) * [sum of weighted function values]\n');
    fprintf('= (%.10f/2) * [sum] = %.10f\n', h, m);

    I = m;
end
