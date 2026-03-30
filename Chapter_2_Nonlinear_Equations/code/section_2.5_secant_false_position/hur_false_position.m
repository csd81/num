% =========================================================
% Chapter 2, Section 2.5 - Method of False Position (Hungarian: "hur")
% =========================================================
% Purpose: Legacy Hungarian educational implementation of the method of false
% position (regula falsi) for finding roots of scalar functions.
% This file is part of the historical Hungarian language educational materials.
%
% This function implements the false position method, which combines bracketing
% (like bisection) with linear interpolation (like the secant method).
% =========================================================

function hur(f, a, b, t)
    % Hungarian function for false position method (regula falsi)
    % Parameters:
    %   f: function handle for the target function
    %   a: left endpoint of bracketing interval
    %   b: right endpoint of bracketing interval
    %   t: tolerance for convergence

    % Check if f(a) and f(b) have opposite signs
    if f(a) * f(b) > 0
        fprintf('Nem ellentétes előjelű az intervallum!\n');  % "Interval doesn't have opposite signs"
        return
    end

    % Check if left endpoint is exact solution
    if f(a) == 0
        fprintf('Az intervallum első végpontja megoldás! (%6f)\n', a);  % "Left endpoint is the solution"
        return
    end

    % Check if right endpoint is exact solution
    if f(b) == 0
        fprintf('Az intervallum második végpontja megoldás! (%6f)\n', b);  % "Right endpoint is the solution"
        return
    end

    l = 0;  % Iteration counter

    % Compute initial false position root using secant line formula
    % c = a - f(a)*(a-b)/(f(a)-f(b))
    c = a - f(a) * (a - b) / (f(a) - f(b));

    if f(c) == 0
        fprintf('%d lépésben a pontos gyök: %6f\n', l, c);  % "Exact root in %d steps"
        return
    end

    % Main iteration loop until convergence or max iterations
    while abs(f(c)) > t && l < 100
        % Compute new false position root
        c = a - f(a) * (a - b) / (f(a) - f(b));

        % Update bracketing interval based on sign of f(c)
        if f(a) * f(c) < 0
            % Root is in [a, c], so set b = c
            b = c;
        elseif f(b) * f(c) < 0
            % Root is in [c, b], so set a = c
            a = c;
        else
            % Rare case: c is the exact solution
            fprintf('%d lépésben a pontos gyök: %6f\n', l, c);  % "Exact root in %d steps"
            return
        end

        l = l + 1;
        fprintf('%d lépésben a közelítő gyök: %6f\n', l, c);  % "Approximate root at step %d: %6f"
    end
end
