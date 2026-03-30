%% Chapter 8: Minimization
%  Section 8.3: Simplex Method (Nelder-Mead Variants)
%  Algorithm: Nelder-Mead Method
%
%  Minimizes a 2D function using the Nelder-Mead simplex method.
%  Includes four operations: reflection, expansion, outer contraction,
%  and inner contraction, with shrinking as fallback.

% Specify the vertices in the same order as in the problem definition
x0 = [-2, 4];                           % First vertex of starting simplex
x1 = [-1, 4];                           % Second vertex of starting simplex
x2 = [-1.5, 5];                         % Third vertex of starting simplex
tolerance = 10^(-2);                    % Tolerance for simplex size

% Nelder-Mead parameters
alpha = 1.4;        % Expansion coefficient: how far to expand the reflected point
beta = 0.7;         % Contraction coefficient: how much to contract

% Draw level curves of the function
levelvalues = [0.08, 0.2, 0.5, 1.2, 2.0, 3.5, 5.0, 7., 9.0, 11., 14., ...
    18, 22, 26, 30., 34., 38., 43, 53., 60., 70, 80., 90, 100, 120, 140., ...
    170., 220., 270., 400., 550., 810.];
xinterval = [-3., 2.];
yinterval = [-1.5, 5];
intx1 = xinterval(1):0.05:xinterval(2);
inty1 = yinterval(1):0.05:yinterval(2);
[xx, yy] = meshgrid(intx1, inty1);
zz = fv(xx, yy);
hold on
contour(xx, yy, zz, levelvalues, 'b', LineWidth=1.5)

% Store the three vertices in a cell array
simplex = {x0, x1, x2};
k = 0;

%% Main Iteration Loop
% Continue while simplex size is above tolerance and within iteration limit
while simplex_size(simplex) >= tolerance && k < 100
    draw_simplex(simplex)
    simplex = vertex_sort(simplex);  % Sort vertices by function value
    % simplex{1}: best point (lowest f), simplex{2}: second best, simplex{3}: worst
    fprintf('step %2d:  simplex=[% 10.8f, % 10.8f],  [% 10.8f,% 10.8f],  [% 10.8f,% 10.8f],  % 6.4e, % 6.4e, % 6.4e\n', ...
        k, simplex{1}, simplex{2}, simplex{3}, f(simplex{1}), f(simplex{2}), f(simplex{3}))

    %% Reflection Step
    % Compute centroid of the two best vertices
    xc = (simplex{1} + simplex{2}) / 2;
    % Reflect worst vertex through centroid: x_r = 2*x_c - x_worst
    xr = 2 * xc - simplex{3};

    %% Case (ii): Reflection gave improvement better than best
    % If f(x_r) <= f(x_best), try expansion
    if f(xr) <= f(simplex{1})
        % Expand further: x_e = x_c + alpha * (x_r - x_c)
        xe = xc + alpha * (xr - xc);
        % Accept expansion if it's better than reflection
        if f(xe) < f(simplex{1})
            simplex{3} = xe;
        else
            simplex{3} = xr;
        end

    %% Case (iii): Reflection is worse than second best
    % If f(x_r) >= f(x_second), try contraction
    elseif f(xr) >= f(simplex{2})
        % Determine whether to do outside or inside contraction
        if f(simplex{3}) < f(xr)
            % Inside contraction: x_z = x_c - beta * (x_r - x_c)
            xz = xc - beta * (xr - xc);
        else
            % Outside contraction: x_z = x_c + beta * (x_r - x_c)
            xz = xc + beta * (xr - xc);
        end

        % Accept contraction if it improves the worst point
        if f(xz) < min([f(simplex{3}), f(xr)])
            simplex{3} = xz;
        else
            % Contraction failed, shrink simplex to half size
            simplex{2} = simplex{1} + 0.5 * (simplex{2} - simplex{1});
            simplex{3} = simplex{1} + 0.5 * (simplex{3} - simplex{1});
        end

    %% Case (i): Reflection gave acceptable improvement
    % If f(x_best) < f(x_r) < f(x_second), accept reflection
    else
        simplex{3} = xr;
    end

    k = k + 1;
end

fprintf('step %2d:  simplex=[% 10.8f, % 10.8f],  [% 10.8f,% 10.8f],  [% 10.8f,% 10.8f],  % 6.4e, % 6.4e, % 6.4e\n', ...
    k, simplex{1}, simplex{2}, simplex{3}, f(simplex{1}), f(simplex{2}), f(simplex{3}))

%% Final Result
% Compute minimum as the centroid of the final simplex
output = (simplex{1} + simplex{2} + simplex{3}) / 3;
fprintf('minimum point p=[% 10.8f, % 10.8f],  f(p)=% 6.4e\n', output, f(output))

% Test variables
output;             % Output of the iteration
x0;                 % First vertex of the starting simplex
x1;                 % Second vertex of the starting simplex
x2;                 % Third vertex of the starting simplex
f1 = f(x0);         % Function value at first vertex
f2 = f(x1);         % Function value at second vertex
f3 = f(x2);         % Function value at third vertex
tolerance;          % Tolerance value

%% Test Function
% Minimize: f(x,y) = (x² - 2y)² + 2(x - 1)²
function z = f(u)
    z = (u(1)^2 - 2*u(2))^2 + 2*(u(1) - 1)^2;
end

%% Helper Functions

% Sort simplex vertices by function value (ascending)
function sorted_simplex = vertex_sort(simp)
    fv = [f(simp{1}), f(simp{2}), f(simp{3})];  % Function values at vertices
    [~, ind] = sort(fv);                         % Sort indices
    sorted_simplex = simp(ind);                  % Reorder simplex
end

% Compute the longest edge of the simplex (maximum diameter)
function z = simplex_size(simp)
    z = max([norm(simp{1} - simp{2}, Inf), norm(simp{1} - simp{3}, Inf), ...
        norm(simp{2} - simp{3}, Inf)]);
end

% Evaluate function on a matrix of points (for contour plotting)
function z = fv(x, y)
    [n, m] = size(x);
    z = zeros(n, m);
    for i = 1:n
        for j = 1:m
            z(i, j) = f([x(i, j), y(i, j)]);
        end
    end
end

% Draw simplex vertices and edges
function draw_simplex(simp)
    plot([simp{1}(1), simp{2}(1), simp{3}(1)], [simp{1}(2), simp{2}(2), simp{3}(2)], ...
        'ro', 'linewidth', 2)
    plot([simp{1}(1), simp{2}(1), simp{3}(1), simp{1}(1)], ...
        [simp{1}(2), simp{2}(2), simp{3}(2), simp{1}(2)], 'r-', 'linewidth', 2)
end
