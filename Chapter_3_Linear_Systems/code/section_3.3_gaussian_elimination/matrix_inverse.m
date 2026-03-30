function Ainv = matrix_inverse(A)
    % MATRIX_INVERSE Computes matrix inverse using Gauss-Jordan elimination
    %
    % Extended Gauss-Jordan method: augment matrix A with identity matrix,
    % then reduce A to identity to get A^(-1) on the right side.
    % More numerically stable than direct inversion formulas.
    %
    % Mathematical approach:
    %   Create augmented system [A | I]
    %   Apply Gauss-Jordan elimination
    %   Result is [I | A^(-1)]
    %
    % Usage: Ainv = matrix_inverse(A)
    %
    % Input:
    %   A - square matrix (n x n)
    %
    % Output:
    %   Ainv - inverse matrix (n x n)

    sA = size(A);

    % Check that matrix is square
    if sA(1) ~= sA(2)
        error('Matrix must be square for inversion')
    end

    n = sA(1);

    % Check matrix conditioning instead of determinant
    % rcond(A) estimates reciprocal of condition number
    % rcond < eps indicates near-singular matrix
    if rcond(A) < eps
        error('Matrix is singular or ill-conditioned and cannot be inverted')
    end

    % Create augmented matrix [A | I]
    Aug = [A, eye(n)];

    fprintf('Computing matrix inverse using Gauss-Jordan elimination\n');
    fprintf('Augmented matrix [A | I]:\n');
    disp(Aug)

    % Gauss-Jordan elimination
    for i = 1:n
        % Partial pivoting: find largest element in column i from row i onward
        [~, max_idx] = max(abs(Aug(i:n, i)));
        pivot_row = max_idx + i - 1;

        % Swap rows if necessary
        if pivot_row ~= i
            temp = Aug(i, :);
            Aug(i, :) = Aug(pivot_row, :);
            Aug(pivot_row, :) = temp;
        end

        % Check for zero pivot
        if Aug(i,i) == 0
            error('Matrix is singular: zero pivot element at position (%d,%d)', i, i)
        end

        % Eliminate all other rows (both above and below diagonal)
        for j = 1:n
            if i ~= j
                multiplier = Aug(j,i) / Aug(i,i);
                Aug(j,:) = Aug(j,:) - multiplier * Aug(i,:);
            end
        end

        % Normalize pivot row: make diagonal element = 1
        Aug(i,:) = Aug(i,:) / Aug(i,i);
    end

    % Extract inverse matrix from right half of augmented matrix
    Ainv = Aug(:, n+1:2*n);

    fprintf('Inverse matrix:\n');
    disp(Ainv)

    % Verification: A * Ainv should be identity
    fprintf('Verification (A * Ainv should be identity):\n');
    disp(A * Ainv)
end
