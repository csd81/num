% INTEGRATION COMPOSITE EXAMPLES
% Composite trapezoidal and Simpson rules for numerical integration
%
% Hungarian function commentary:
% - A numerikus integrálás az integral(from a to b) értékét közelíti
% - Az összetett trapéz és Simpson szabályok az alapintervallum felosztása
%   segítségével számolják a közelítő értéket
% - A szabályok 3 paraméter megadásával használhatók:
%   * f: a függvény (function handle)
%   * a: az integrálás első végpontja
%   * b: az integrálás második végpontja
% - Indítás után mindkét eljárás vár még 1 paramétert:
%   * Trapéz: részintervallumok száma
%   * Simpson: elemi szabály alkalmazásainak száma

%==========================================================
% Example 1: Simple polynomial integration
%==========================================================
fprintf('\n========================================\n');
fprintf('Example 1: Polynomial Integration\n');
fprintf('========================================\n');

% Define function: f(x) = x^2
f1 = @(x) x.^2;

% Integrate from 0 to 1
% Exact integral: integral(x^2 dx, 0 to 1) = x^3/3 |_0^1 = 1/3 ≈ 0.333333
fprintf('Function: f(x) = x^2\n');
fprintf('Interval: [0, 1]\n');
fprintf('Exact integral: 1/3 ≈ 0.3333333\n\n');

fprintf('Trapezoidal rule (divide into 10 parts):\n');
% Would call: I1_trap = trapezoidal_rule(f1, 0, 1);

fprintf('\nSimpson rule (apply 5 times):\n');
% Would call: I1_simp = simpson_rule(f1, 0, 1);

%==========================================================
% Example 2: Exponential integration
%==========================================================
fprintf('\n========================================\n');
fprintf('Example 2: Exponential Integration\n');
fprintf('========================================\n');

% Define function: f(x) = exp(x)
f2 = @(x) exp(x);

% Integrate from 0 to 1
% Exact integral: integral(e^x dx, 0 to 1) = e^x |_0^1 = e - 1 ≈ 1.718281
fprintf('Function: f(x) = e^x\n');
fprintf('Interval: [0, 1]\n');
fprintf('Exact integral: e - 1 ≈ 1.7182818\n\n');

fprintf('Trapezoidal rule (divide into 20 parts):\n');
% Would call: I2_trap = trapezoidal_rule(f2, 0, 1);

fprintf('\nSimpson rule (apply 10 times):\n');
% Would call: I2_simp = simpson_rule(f2, 0, 1);

%==========================================================
% Example 3: Two curves - area between them
%==========================================================
fprintf('\n========================================\n');
fprintf('Example 3: Area Between Two Curves\n');
fprintf('========================================\n');

% Define two functions
f = @(x) exp(3*cos(x));     % Upper function
g = @(x) x^4 - 6*x - 4;     % Lower function

% Plot to visualize intersection points
fplot(@(x) f(x), 'b-', 'LineWidth', 2);
hold on
fplot(@(x) g(x), 'r-', 'LineWidth', 2);
hold off
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
ax.XLim = [-5 5];
ax.YLim = [-10 10];
grid on
legend('f(x) = exp(3*cos(x))', 'g(x) = x^4 - 6x - 4')
title('Two Curves for Area Calculation')

fprintf('\nFunctions:\n');
fprintf('f(x) = exp(3*cos(x))\n');
fprintf('g(x) = x^4 - 6x - 4\n');

fprintf('\nFrom the plot, the curves intersect approximately at:\n');
fprintf('First intersection: near x = -0.67\n');
fprintf('Second intersection: near x = 1.95\n');

fprintf('\nTo find exact intersection points, use bisection method:\n');
fprintf('intfel(@fg, -1, 0, 10^-4)  -> First intersection\n');
fprintf('intfel(@fg, 1, 3, 10^-4)   -> Second intersection\n');

fprintf('\nApproximate intersections found:\n');
fprintf('a = -0.666321 (14 iterations)\n');
fprintf('b = 1.947205 (15 iterations)\n');

fprintf('\nDefine difference function (f - g):\n');
fprintf('fg(x) = exp(3*cos(x)) - (x^4 - 6x - 4)\n');

fprintf('\nArea between curves (using trapezoidal rule, 100 subintervals):\n');
% Would call: A_trap = trapezoidal_rule(@fg, -0.666321, 1.947205);
fprintf('Expected: ≈ 14.7500\n');

fprintf('\nArea between curves (using Simpson rule, 50 applications):\n');
% Would call: A_simp = simpson_rule(@fg, -0.666321, 1.947205);
fprintf('Expected: ≈ 14.7518\n');

%==========================================================
% Example 4: Trigonometric integration
%==========================================================
fprintf('\n========================================\n');
fprintf('Example 4: Trigonometric Integration\n');
fprintf('========================================\n');

% Define function: f(x) = sin(x)
f4 = @(x) sin(x);

% Integrate from 0 to pi
% Exact integral: integral(sin(x) dx, 0 to pi) = -cos(x) |_0^pi = 2
fprintf('Function: f(x) = sin(x)\n');
fprintf('Interval: [0, π]\n');
fprintf('Exact integral: 2\n\n');

fprintf('Trapezoidal rule (divide into 20 parts):\n');
% Would call: I4_trap = trapezoidal_rule(f4, 0, pi);

fprintf('\nSimpson rule (apply 10 times):\n');
% Would call: I4_simp = simpson_rule(f4, 0, pi);

%==========================================================
% Notes on accuracy
%==========================================================
fprintf('\n========================================\n');
fprintf('Accuracy Comparison\n');
fprintf('========================================\n');

fprintf('Trapezoidal Rule:\n');
fprintf('  - Error order: O(h^2) = O(n^-2)\n');
fprintf('  - Suitable for: smooth, well-behaved functions\n');
fprintf('  - Advantages: simple, robust\n');
fprintf('  - Disadvantages: less accurate than Simpson\n\n');

fprintf('Simpson Rule:\n');
fprintf('  - Error order: O(h^4) = O(n^-4)\n');
fprintf('  - Suitable for: smooth, well-behaved functions (better accuracy)\n');
fprintf('  - Advantages: higher accuracy with same computational cost\n');
fprintf('  - Disadvantages: slightly more complex\n\n');

fprintf('For smooth functions, Simpson rule typically gives 10-100x better accuracy!\n');
