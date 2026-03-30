function x = gaussian_partial_pivoting(A, b)
    % GAUSSIAN_PARTIAL_PIVOTING Solves linear system Ax = b with partial pivoting
    %
    % Uses partial pivoting strategy: at each elimination step, selects the row
    % with the largest absolute value in the pivot column to minimize rounding errors.
    % This is more numerically stable than naive Gaussian elimination.
    %
    % Mathematical formula:
    %   For each column k from 1 to n-1:
    %     Select pivot: find i >= k such that |A(i,k)| is maximum
    %     Swap rows if necessary
    %     For rows i = k+1 to n:
    %       l_ik = A(i,k) / A(k,k)  (multiplier)
    %       A(i,:) = A(i,:) - l_ik * A(k,:)
    %   Back-substitution with guard for underdetermined systems
    %
    % Usage: x = gaussian_partial_pivoting(A, b)
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

    % Forward elimination with partial pivoting
    for k = 1:n-1
        % Partial pivoting: find largest absolute value in column k from row k onward
        [~, max_idx] = max(abs(A(k:n, k)));
        pivot_row = max_idx + k - 1;

        % Swap rows if necessary
        if pivot_row ~= k
            temp = A(k, :);
            A(k, :) = A(pivot_row, :);
            A(pivot_row, :) = temp;
            fprintf('Step %d: Swapped rows %d and %d (partial pivot selection)\n', k, k, pivot_row);
            disp(A)
        end

        % Check for zero pivot (underdetermined system)
        if A(k,k) == 0
            error('Zero pivot at step %d: system may be underdetermined or singular', k)
        end

        % Elimination: eliminate column k below diagonal
        for i = k+1:n
            l = A(i,k) / A(k,k);  % multiplier
            A(i,:) = A(i,:) - l * A(k,:);
        end
        fprintf('Step %d (after eliminating column %d with partial pivoting):\n', k, k);
        disp(A)
    end

    % Check for singular matrix at last position
    if A(n,n) == 0
        if A(n,n+1) ~= 0
            error('No solution: system is inconsistent (0 = %g)', A(n,n+1))
        else
            error('Infinitely many solutions: underdetermined system')
        end
    end

    % Back-substitution
    x = zeros(n, 1);
    x(n) = A(n, n+1) / A(n,n);

    for i = n-1:-1:1
        x(i) = A(i, n+1);
        for j = i+1:n
            x(i) = x(i) - A(i,j) * x(j);
        end
        x(i) = x(i) / A(i,i);
    end

    fprintf('\nSolution vector:\n')
    disp(x)
end
