% GAUSSIAN ELIMINATION METHODS FOR LINEAR SYSTEMS
%
% This driver script demonstrates various Gaussian elimination techniques
% for solving linear systems Ax = b.
%
% Methods implemented:
%   1. gaussian_elimination_no_pivoting.m - Basic elimination (no strategy)
%   2. gaussian_partial_pivoting.m - Row pivoting for stability
%   3. gaussian_complete_pivoting.m - Row and column pivoting (most stable)
%   4. gauss_jordan_elimination.m - Gauss-Jordan with partial pivoting
%   5. matrix_inverse.m - Matrix inversion via Gauss-Jordan

% Example 1: Basic Gaussian Elimination (No Pivoting)
% This works well when pivot elements are reasonably sized
fprintf('========================================\n');
fprintf('Example 1: Gaussian Elimination (No Pivoting)\n');
fprintf('========================================\n');

A1 = [1, 1, -1, 1; 2, 1, -1, -1; 1, -2, -2, 3; 1, 1, -1, -2];
b1 = [8; 3; 12; 0];

fprintf('System: Ax = b where\n');
disp('A ='); disp(A1);
disp('b ='); disp(b1);

x1 = gaussian_elimination_no_pivoting(A1, b1);

% Expected solution:
% x1 ≈ [0.3333; 1.5833; -3.4167; 2.6667]

% Example 2: Gaussian Elimination with Partial Pivoting
% More robust when small pivots appear
fprintf('\n========================================\n');
fprintf('Example 2: Gaussian Elimination (Partial Pivoting)\n');
fprintf('========================================\n');

A2 = [3, 1, 2, -3; 2, 0, 3, -3; 1, 1, 1, 0; 1, -4, 1, 3];
b2 = [-2; -4; 0; 3];

fprintf('System: Ax = b where\n');
disp('A ='); disp(A2);
disp('b ='); disp(b2);

x2 = gaussian_partial_pivoting(A2, b2);

% Example 3: Gaussian Elimination with Complete Pivoting
% Most numerically stable; requires tracking column (variable) permutations
fprintf('\n========================================\n');
fprintf('Example 3: Gaussian Elimination (Complete Pivoting)\n');
fprintf('========================================\n');

A3 = [1, 1, 0, 3; 2, 1, -1, 1; 3, -1, -1, 2; -1, 2, 3, -1];
b3 = [4; 1; -3; 4];

fprintf('System: Ax = b where\n');
disp('A ='); disp(A3);
disp('b ='); disp(b3);

[x3, col_perm] = gaussian_complete_pivoting(A3, b3);

% Expected solution:
% x3 = [-1; 2; 0; 1]

% Example 4: Gauss-Jordan Elimination with Partial Pivoting
% Produces solution directly from reduced row echelon form
fprintf('\n========================================\n');
fprintf('Example 4: Gauss-Jordan Elimination (Partial Pivoting)\n');
fprintf('========================================\n');

A4 = [1, 1, 0, 3; 2, 1, -1, 1; 3, -1, -1, 2; -1, 2, 3, -1];
b4 = [4; 1; -3; 4];

fprintf('System: Ax = b where\n');
disp('A ='); disp(A4);
disp('b ='); disp(b4);

x4 = gauss_jordan_elimination(A4, b4);

% Example 5: Matrix Inversion
% Uses Gauss-Jordan on augmented [A | I] to compute A^(-1)
fprintf('\n========================================\n');
fprintf('Example 5: Matrix Inversion\n');
fprintf('========================================\n');

A5 = [1, 1, 0, 3; 2, 1, -1, 1; 3, -1, -1, 2; -1, 2, 3, -1];

fprintf('Computing inverse of matrix A\n');
disp('A ='); disp(A5);

Ainv = matrix_inverse(A5);

% Verify: A * A^(-1) should equal I
fprintf('\nVerification: A * A^(-1) should equal I:\n');
disp(A5 * Ainv)
