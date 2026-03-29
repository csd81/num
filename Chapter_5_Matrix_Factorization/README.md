# Chapter 5: Matrix Factorization

## Summary

This chapter covers matrix factorization techniques, specifically LU factorization (Doolittle's method) and Cholesky factorization for symmetric positive definite matrices.

### 5.1 LU Factorization

**Definition:** For an n×n matrix A, the **LU factorization** (Doolittle's method) is:
$$A = LU$$
where:
- **L** is lower triangular with 1s on the main diagonal (unit lower triangular)
- **U** is upper triangular

**Theorem 5.1 (Uniqueness):** If A is nonsingular and LU factorization exists, it is unique.

**Connection to Gaussian Elimination:**

During Gaussian elimination, we define elimination matrices:
$$L_k = \begin{pmatrix}
1 & & & \\
& \ddots & & \\
& -l_{k+1,k} & \ddots & \\
& \vdots & & 1
\end{pmatrix}$$

where $l_{ik} = a_{ik}^{(k-1)}/a_{kk}^{(k-1)}$ are the elimination multipliers.

**Theorem 5.2:** If Gaussian elimination can be performed on A (without row exchanges), then:
$$A = LU$$
where:
- U = A⁽ⁿ⁻¹⁾ (the upper triangular result of elimination)
- L has the multipliers $l_{ij}$ below the diagonal:
$$L = \begin{pmatrix}
1 & 0 & 0 & \cdots & 0 \\
l_{21} & 1 & 0 & \cdots & 0 \\
l_{31} & l_{32} & 1 & \cdots & 0 \\
\vdots & \vdots & \vdots & \ddots & \vdots \\
l_{n1} & l_{n2} & l_{n3} & \cdots & 1
\end{pmatrix}$$

**Computing LU Factorization:**

The factorization can be computed during Gaussian elimination by storing multipliers in place of eliminated zeros:

```
Original:           After elimination:
⎛ 1  -2  -2  -2 ⎞   ⎛ 1  -2  -2  -2 ⎞
⎜ 2  -1   2   4 ⎟   ⎜ 2   3   6   8 ⎟
⎜-1   2   3  -4 ⎟ ~ ⎜-1   0   1  -6 ⎟
⎝-2   1   4  -2 ⎠   ⎝-2  -1   6  38 ⎠

L = ⎛ 1   0   0   0 ⎞    U = ⎛ 1  -2  -2  -2 ⎞
    ⎜ 2   1   0   0 ⎟        ⎜ 0   3   6   8 ⎟
    ⎜-1   0   1   0 ⎟        ⎜ 0   0   1  -6 ⎟
    ⎝-2  -1   6   1 ⎠        ⎝ 0   0   0  38 ⎠
```

**Existence Theorems:**

**Theorem 5.4:** If all **principal minors** of A are nonzero, then:
- Gaussian elimination can be performed without row changes
- LU factorization exists

**Theorem 5.5:** For any invertible matrix A, there exists a **permutation matrix P** such that:
$$PA = LU$$
(This is LU factorization with partial pivoting)

**Solving Linear Systems with LU:**

Given Ax = b with A = LU:

1. **Forward substitution:** Solve Ly = b for y
2. **Backward substitution:** Solve Ux = y for x

**Operation Count:**
- LU factorization: **n³/3 + O(n²)** multiplications/divisions
- Forward + backward substitution: **n² + O(n)** multiplications/divisions

**Advantage:** Once LU is computed, solving multiple systems with the same A but different b vectors is very efficient (only n² operations per system).

---

### 5.2 Cholesky Factorization

**Definition:** For a symmetric matrix A, the **Cholesky factorization** is:
$$A = LL^T$$
where L is lower triangular.

**Note:** Cholesky factorization is **not unique** in general (signs of diagonal elements can vary).

**Theorem 5.6:** If A is **symmetric positive definite**, then:
- Cholesky factorization A = LLᵀ exists
- L is real
- Diagonal elements of L can be chosen positive (making it unique)

**Proof Strategy (Induction):**

For A partitioned as:
$$A = \begin{pmatrix} X & y \\ y^T & a_{nn} \end{pmatrix}$$

We seek:
$$\begin{pmatrix} X & y \\ y^T & a_{nn} \end{pmatrix} = \begin{pmatrix} \tilde{L} & 0 \\ c^T & d \end{pmatrix} \begin{pmatrix} \tilde{L}^T & c \\ 0^T & d \end{pmatrix}$$

This gives:
1. X = $\tilde{L}\tilde{L}^T$ (solve by induction)
2. $\tilde{L}c = y$ (solve for c by forward substitution)
3. $c^Tc + d^2 = a_{nn}$ (solve for d: $d = \sqrt{a_{nn} - c^Tc}$)

Since A is positive definite, det(A) > 0, ensuring d is real and positive.

---

### Algorithm 5.8: Cholesky Factorization

```
INPUT:  A (symmetric positive definite n×n matrix)
OUTPUT: L (lower triangular, A = LLᵀ)

l₁₁ ← √a₁₁
for i = 2 to n:
    lᵢ₁ ← aᵢ₁ / l₁₁

for j = 2 to n-1:
    lⱼⱼ ← √(aⱼⱼ - Σₖ₌₁ʲ⁻¹ lⱼₖ²)
    for i = j+1 to n:
        lᵢⱼ ← (aᵢⱼ - Σₖ₌₁ʲ⁻¹ lᵢₖlⱼₖ) / lⱼⱼ

lₙₙ ← √(aₙₙ - Σₖ₌₁ⁿ⁻¹ lₙₖ²)
```

**Element-wise Formulas:**

For i ≥ j:
$$l_{ij} = \frac{1}{l_{jj}}\left(a_{ij} - \sum_{k=1}^{j-1} l_{ik}l_{jk}\right)$$

For diagonal (i = j):
$$l_{jj} = \sqrt{a_{jj} - \sum_{k=1}^{j-1} l_{jk}^2}$$

**Operation Count:**
- Multiplications/divisions: **n³/6 + n²/2 - 2n/3**
- Additions/subtractions: **n³/6 - n/6**
- Square roots: **n**

**Comparison with LU:**
| Method | Operations | Requirements |
|--------|------------|--------------|
| LU | n³/3 | Nonsingular |
| Cholesky | n³/6 | Symmetric positive definite |

Cholesky is **~2× faster** than LU for applicable matrices!

---

### Example: Cholesky Factorization

Find Cholesky factorization of:
$$A = \begin{pmatrix} 4 & -8 & 4 \\ -8 & 17 & -11 \\ 4 & -11 & 22 \end{pmatrix}$$

**Step 1:** l₁₁ = √4 = **2**

**Step 2:** First column:
- l₂₁ = -8/2 = **-4**
- l₃₁ = 4/2 = **2**

**Step 3:** l₂₂ = √(17 - (-4)²) = √1 = **1**

**Step 4:** l₃₂ = (-11 - 2×(-4))/1 = **-3**

**Step 5:** l₃₃ = √(22 - 2² - (-3)²) = √9 = **3**

**Result:**
$$L = \begin{pmatrix} 2 & 0 & 0 \\ -4 & 1 & 0 \\ 2 & -3 & 3 \end{pmatrix}$$

**Verification:** LLᵀ = A ✓

---

## Key Takeaways

1. **LU factorization** decomposes A into unit lower triangular L and upper triangular U
2. LU exists if Gaussian elimination works without row exchanges (all principal minors nonzero)
3. For general invertible matrices, **PA = LU** with permutation matrix P
4. Once LU is computed, solving Ax = b requires only **n² operations** (vs n³/3 for factorization)
5. **Cholesky factorization** A = LLᵀ applies to symmetric positive definite matrices
6. Cholesky is **twice as efficient** as LU (n³/6 vs n³/3 operations)
7. Cholesky requires **n square roots** but no pivoting for positive definite matrices
8. Both methods are essential for efficient numerical linear algebra
