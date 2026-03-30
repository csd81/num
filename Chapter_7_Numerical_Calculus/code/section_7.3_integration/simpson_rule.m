function I = simpson_rule(f, a, b)
    % SIMPSON_RULE Computes approximate integral using composite Simpson's rule
    %
    % Simpson's rule approximates the integral of f over [a,b] using parabolic
    % polynomial interpolation over subintervals. Extremely accurate for smooth functions.
    %
    % Mathematical formula:
    %   Composite Simpson's rule with n subintervals (n even):
    %     I ≈ (h/3) * [f(x_0) + 4*f(x_1) + 2*f(x_2) + 4*f(x_3) + 2*f(x_4) + ... + 4*f(x_{n-1}) + f(x_n)]
    %   where h = (b-a)/(2*n) and weights follow pattern: 1, 4, 2, 4, 2, ..., 4, 1
    %
    %   The weight 4 applies to odd-indexed points (use current iterate)
    %   The weight 2 applies to even-indexed interior points (use previous iterate)
    %
    %   Error: |I - integral| <= (b-a)^5 / (180*n^4) * max|f''''|
    %   Error decreases as O(n^-4), making it very accurate
    %
    % Usage: I = simpson_rule(f, a, b)
    %
    % Input:
    %   f - function handle (must be vectorizable)
    %   a - lower integration limit
    %   b - upper integration limit
    %
    % Output:
    %   I - approximate integral value

    % Prompt for number of applications of elementary Simpson rule
    n = input('How many times apply elementary Simpson rule (number of subintervals)? ');

    if n < 1 || floor(n) ~= n
        error('Number of subintervals must be positive integer')
    end

    % Compute step size
    h = (b - a) / (2*n);

    % Initialize sum with boundary terms
    m = f(a) + f(b);  % Boundary terms have weight 1

    fprintf('========================================\n');
    fprintf('Simpson Rule Integration\n');
    fprintf('========================================\n');
    fprintf('Integrand: f(x)\n');
    fprintf('Interval: [%.6f, %.6f]\n', a, b);
    fprintf('Number of subintervals: %d\n', 2*n);
    fprintf('Step size h: %.10f\n\n', h);

    % Sum with weights 4 and 2
    % Weight 4: odd-indexed points (interior endpoints of subrules)
    % Weight 2: even-indexed interior points
    fprintf('Integration points and weights:\n');
    fprintf('i  x_i         f(x_i)         weight  contribution\n');
    fprintf('-  --------   -----------      -----  -----------\n');

    fprintf('%d  %.8f  %12.8f       1    %12.8f\n', 0, a, f(a), f(a));

    for i = 1:2*n-1
        x = a + i*h;
        f_val = f(x);

        if mod(i, 2) == 1  % Odd index: weight 4
            weight = 4;
            m = m + 4 * f_val;
        else  % Even index: weight 2
            weight = 2;
            m = m + 2 * f_val;
        end

        if i <= 10 || i > 2*n-5  % Print first and last few
            fprintf('%d  %.8f  %12.8f       %d    %12.8f\n', i, x, f_val, weight, weight*f_val);
        elseif i == 11
            fprintf('...  (...points omitted...)\n');
        end
    end

    fprintf('%d  %.8f  %12.8f       1    %12.8f\n', 2*n, b, f(b), f(b));

    % Multiply by h/3
    m = h/3 * m;

    fprintf('\nApproximate integral: I ≈ %.10f\n', m);
    fprintf('(h/3) * [sum of weighted function values]\n');
    fprintf('= (%.10f/3) * [sum] = %.10f\n', h, m);

    I = m;
end
