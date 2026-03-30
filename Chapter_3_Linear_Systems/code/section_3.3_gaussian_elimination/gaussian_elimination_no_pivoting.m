function x = gaussian_elimination_no_pivoting(A, b)
    % GAUSSIAN_ELIMINATION_NO_PIVOTING Solves linear system Ax = b using Gaussian elimination
    %
    % Uses forward elimination without pivoting strategy. This method is stable only
    % when the pivot elements are not too small.
    %
    % Mathematical formula:
    %   For each row k from 1 to n-1:
    %     l_ik = A(i,k) / A(k,k)  (multiplier)
    %     A(i,:) = A(i,:) - l_ik * A(k,:)  (row elimination)
    %   Then back-substitution: x(i) = (A(i,n+1) - sum(A(i,j)*x(j))) / A(i,i)
    %
    % Usage: x = gaussian_elimination_no_pivoting(A, b)
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

    % Forward elimination
    for k = 1:n-1
        % Zero-pivot check BEFORE inner loop
        if A(k,k) == 0
            error('Zero pivot element at position (%d,%d) - pivoting strategy required', k, k)
        end

        % Elimination: eliminate column k below diagonal
        for i = k+1:n
            l = A(i,k) / A(k,k);  % multiplier
            A(i,:) = A(i,:) - l * A(k,:);
        end
        fprintf('Step %d (after eliminating column %d):\n', k, k);
        disp(A)
    end

    % Check for singular matrix
    if A(n,n) == 0
        error('Singular matrix: zero diagonal element at last position')
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
