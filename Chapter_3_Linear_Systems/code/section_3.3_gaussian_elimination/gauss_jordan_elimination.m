function x = gauss_jordan_elimination(A, b)
    % GAUSS_JORDAN_ELIMINATION Solves linear system Ax = b using Gauss-Jordan elimination
    %
    % Performs Gaussian elimination with partial pivoting to transform augmented matrix
    % to reduced row echelon form (identity matrix on left side).
    % The solution can be read directly from the last column.
    %
    % Mathematical formula:
    %   For each diagonal position i from 1 to n:
    %     Find pivot: p = max(|A(i:n, i)|)
    %     Swap rows if needed
    %     For all rows j != i:
    %       multiplier = A(j,i) / A(i,i)
    %       A(j,:) = A(j,:) - multiplier * A(i,:)
    %     Normalize row i: A(i,:) = A(i,:) / A(i,i)
    %
    % Usage: x = gauss_jordan_elimination(A, b)
    %
    % Input:
    %   A - coefficient matrix (n x n)
    %   b - right-hand side vector (n x 1)
    %
    % Output:
    %   x - solution vector (n x 1)

    sA = size(A);
    sb = size(b);

    % Check dimensions
    if sA(1) ~= sA(2) || sA(1) ~= sb(1) || sb(2) ~= 1
        error('Invalid dimensions: A must be square, b must be column vector matching A size')
    end

    n = sA(1);
    A = [A, b];  % Augmented matrix

    fprintf('Step 0 (initial augmented matrix):\n');
    disp(A)

    % Gauss-Jordan elimination with partial pivoting
    for i = 1:n
        % Partial pivoting: find largest element in column i from row i onward
        [~, max_idx] = max(abs(A(i:n, i)));
        pivot_row = max_idx + i - 1;

        % Swap rows if necessary
        if pivot_row ~= i
            temp = A(i, :);
            A(i, :) = A(pivot_row, :);
            A(pivot_row, :) = temp;
            fprintf('Step %d: Swapped rows %d and %d (partial pivot selection)\n', i, i, pivot_row);
            disp(A)
        end

        % Check for singular matrix
        if A(i,i) == 0
            error('Singular matrix detected: zero pivot at position (%d,%d)', i, i)
        end

        % Eliminate all other rows (both above and below diagonal)
        for j = 1:n
            if i ~= j
                multiplier = A(j,i) / A(i,i);
                A(j,:) = A(j,:) - multiplier * A(i,:);
            end
        end

        % Normalize pivot row: make diagonal element = 1
        A(i, :) = A(i, :) / A(i,i);

        fprintf('Step %d (after reducing column %d):\n', i, i);
        disp(A)
    end

    % Extract solution from last column
    x = A(:, n+1);

    fprintf('\nSolution vector:\n')
    disp(x)
end
