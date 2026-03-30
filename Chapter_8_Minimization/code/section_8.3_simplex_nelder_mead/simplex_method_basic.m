%% Chapter 8: Minimization
%  Section 8.3: Simplex Method (Nelder-Mead Variants)
%  Algorithm: Basic Simplex Method - Simplified Nelder-Mead
%
%  Minimizes a 2D function using a basic simplex method with only
%  reflection and shrinking operations (no expansion or contraction).

% Specify the vertices in the same order as in the problem definition
x0 = [-2, 4];                           % First vertex of starting simplex
x1 = [-1, 4];                           % Second vertex of starting simplex
x2 = [-1.5, 5];                         % Third vertex of starting simplex
tolerance = 10^(-2);                    % Tolerance for simplex size

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
    fprintf('step %2d:  simplex=[% 10.8f, % 10.8f],  [% 10.8f,% 10.8f],  [% 10.8f,% 10.8f],  % 6.4e, % 6.4e, % 6.4e\n', ...
        k, simplex{1}, simplex{2}, simplex{3}, f(simplex{1}), f(simplex{2}), f(simplex{3}))

    %% Reflection Step
    % Compute centroid of the two best vertices
    xc = (simplex{1} + simplex{2}) / 2;
    % Reflect worst vertex through centroid: x_r = 2*x_c - x_worst
    xr = 2 * xc - simplex{3};

    %% Check if reflection improves worst point
    % If f(x_r) >= f(x_worst), shrink simplex; otherwise accept reflection
    if f(xr) >= f(simplex{3})
        % Shrinking operation: bring vertices 2 and 3 toward best vertex
        simplex{2} = simplex{1} + 0.5 * (simplex{2} - simplex{1});
        simplex{3} = simplex{1} + 0.5 * (simplex{3} - simplex{1});
    else
        % Accept the reflection
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
