%% LEGACY CODE - Hungarian Implementation
%  Golden Section Search Method (Aranymetszés)
%  Original name: aranymetszes (Hungarian language)
%
%  This is a legacy implementation of the golden section search algorithm
%  written in Hungarian. See golden_section_search.m for the modernized version.
%  This file is retained for reference and historical purposes.

function aranymetszes(f, a, b, t)
    %% Golden Section Search
    %  Parameters:
    %    f - Function handle to minimize
    %    a - Left endpoint of interval
    %    b - Right endpoint of interval
    %    t - Tolerance/convergence criterion

    % Golden ratio constant: r = (sqrt(5) - 1) / 2 ≈ 0.618
    r = (sqrt(5.0) - 1) / 2;

    % Initialize interior points based on golden ratio
    x = a + r * (b - a);
    y = a + (1 - r) * (b - a);

    fx = f(x);
    fy = f(y);

    l = 0;  % Iteration counter

    %% Main iteration loop
    % Continue until interval width is less than tolerance
    while b - a > t
        % Compare function values and shrink interval
        if fx > fy
            % f(y) is smaller, minimum is in [a, x]
            b = x;
            x = y;
            fx = fy;
            y = a + (1 - r) * (b - a);
            fy = f(y);
        else
            % f(x) is smaller, minimum is in [y, b]
            a = y;
            y = x;
            fy = fx;
            x = a + r * (b - a);
            fx = f(x);
        end
        l = l + 1;
    end

    %% Results
    % Final approximation of minimum
    x = (a + b) / 2;
    y = f(x);

    % Display results (original Hungarian format preserved)
    fprintf('Minimumhely = %6f\n', x);
    fprintf('Minimális függvényérték = %6f\n', y);
    fprintf('Lépésszám = %d\n', l);
end
