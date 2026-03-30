function [x, col_perm] = gaussian_complete_pivoting(A, b)
    % GAUSSIAN_COMPLETE_PIVOTING Solves linear system Ax = b with complete pivoting
    %
    % Uses complete pivoting strategy: searches entire remaining submatrix for the
    % largest element in absolute value. Both row and column swaps are performed.
    % Columns swaps require tracking variable permutations.
    % This is the most numerically stable form of Gaussian elimination.
    %
    % Mathematical formula:
    %   For each step k from 1 to n-1:
    %     Select pivot: find (i,j) such that |A(i,j)| is maximum in A(k:n, k:n)
    %     Swap rows i and k, swap columns j and k
    %     For rows i = k+1 to n:
    %       l_ik = A(i,k) / A(k,k)  (multiplier)
    %       A(i,:) = A(i,:) - l_ik * A(k,:)
    %   Back-substitution with permutation correction
    %
    % Usage: [x, col_perm] = gaussian_complete_pivoting(A, b)
    %
    % Input:
    %   A - coefficient matrix (n x n)
    %   b - right-hand side vector (n x 1)
    %
    % Output:
    %   x - solution vector (n x 1)
    %   col_perm - column permutation vector for tracking variable reordering

    sA = size(A);
    sb = size(b);

    % Check dimensions
    if sA(1) ~= sA(2) || sA(1) ~= sb(1) || sb(2) ~= 1
        error('Invalid dimensions: A must be square, b must be column vector matching A size')
    end

    n = sA(1);
    A = [A, b];  % Augmented matrix
    col_perm = 1:n;  % Track column permutations

    fprintf('Step 0 (initial augmented matrix):\n');
    disp(A)

    % Forward elimination with complete pivoting
    for k = 1:n-1
        % Complete pivoting: find largest absolute value in A(k:n, k:n)
        [maxek, maxok] = max(abs(A(k:n, k:n)));  % Max in each column
        [maxe, maxo] = max(maxek);  % Max across all columns

        % Convert indices from submatrix to full matrix
        pivot_col = maxo + k - 1;
        pivot_row = maxok(maxo) + k - 1;

        % Swap rows if necessary
        if pivot_row ~= k
            temp = A(k, :);
            A(k, :) = A(pivot_row, :);
            A(pivot_row, :) = temp;
            fprintf('Step %d: Swapped rows %d and %d (row pivoting)\n', k, k, pivot_row);
        end

        % Swap columns if necessary
        if pivot_col ~= k
            temp_col = A(:, k);
            A(:, k) = A(:, pivot_col);
            A(:, pivot_col) = temp_col;

            % Update column permutation tracking
            temp_perm = col_perm(k);
            col_perm(k) = col_perm(pivot_col);
            col_perm(pivot_col) = temp_perm;

            fprintf('Step %d: Swapped columns %d and %d (column pivoting)\n', k, k, pivot_col);
        end

        if pivot_row ~= k || pivot_col ~= k
            disp(A)
        end

        % Check for zero pivot
        if A(k,k) == 0
            error('Zero pivot at step %d: matrix is singular or underdetermined', k)
        end

        % Elimination: eliminate column k below diagonal
        for i = k+1:n
            l = A(i,k) / A(k,k);  % multiplier
            A(i,:) = A(i,:) - l * A(k,:);
        end
        fprintf('Step %d (after eliminating column %d with complete pivoting):\n', k, k);
        disp(A)
    end

    % Check for singular matrix at last position
    if A(n,n) == 0
        error('Singular matrix: zero diagonal element at last position')
    end

    % Back-substitution (gives solution in permuted variable order)
    x_perm = zeros(n, 1);
    x_perm(n) = A(n, n+1) / A(n,n);

    for i = n-1:-1:1
        x_perm(i) = A(i, n+1);
        for j = i+1:n
            x_perm(i) = x_perm(i) - A(i,j) * x_perm(j);
        end
        x_perm(i) = x_perm(i) / A(i,i);
    end

    % Undo column permutations to get correct variable order
    x = zeros(n, 1);
    for i = 1:n
        x(col_perm(i)) = x_perm(i);
    end

    fprintf('\nVariable permutation order:\n')
    disp(col_perm)
    fprintf('Solution vector (original variable order):\n')
    disp(x)
end
