# Chapter 3: Linear Systems

## Summary

This chapter covers direct methods for solving linear algebraic systems, including Gaussian elimination, pivoting strategies, and specialized algorithms for tridiagonal systems.

### 3.1 Review of Linear Algebra

**Matrix Notation:**
- A = (aᵢⱼ) is n×n matrix, x is n-dimensional column vector
- ℝⁿˣⁿ: set of real n×n matrices
- det(A): determinant, I: identity matrix
- A⁻¹: inverse matrix where AA⁻¹ = A⁻¹A = I

**Theorem 3.1 (Determinant Properties):**
1. det(A) = 0 if a row/column is all zeros
2. det(A) = 0 if two rows/columns are equal
3. det(AB) = det(A)det(B)
4. det(Aᵀ) = det(A)
5. det(A⁻¹) = 1/det(A)
6. Multiplying row by c: det(B) = c·det(A)
7. Swapping rows: det(B) = -det(A)
8. Adding multiple of row to another: det(B) = det(A)
9. Cofactor expansion: det(A) = Σⱼ(-1)ⁱ⁺ʲaᵢⱼdet(Aᵢⱼ)

**Theorem 3.2 (Equivalent Conditions):** For A ∈ ℝⁿˣⁿ, b ∈ ℝⁿ:
- det(A) ≠ 0 ⟺ A invertible ⟺ Ax = b has unique solution

**Theorem 3.8 (Diagonally Dominant):** If |aᵢᵢ| > Σⱼ≠ᵢ|aᵢⱼ| for all i, then A is invertible.

**Triangular Matrices:**
- Upper triangular: aᵢⱼ = 0 for i > j
- Lower triangular: aᵢⱼ = 0 for i < j
- det(triangular) = product of diagonal elements
- Product/inverse of triangular matrices is triangular

**Permutation Matrix:** Obtained from I by row/column interchange. Each row/column has exactly one 1.

### 3.2 Triangular Systems

**Forward Substitution** (Lower triangular Lx = b):
```
x₁ = b₁/l₁₁
xᵢ = (bᵢ - Σⱼ₌₁ⁱ⁻¹ lᵢⱼxⱼ)/lᵢᵢ, i = 2,...,n
```

**Backward Substitution** (Upper triangular Ux = b):
```
xₙ = bₙ/uₙₙ
xᵢ = (bᵢ - Σⱼ₌ᵢ₊₁ⁿ uᵢⱼxⱼ)/uᵢᵢ, i = n-1,...,1
```

**Operation Count:** n²/2 + O(n) multiplications/divisions

### 3.3 Gaussian Elimination

**Algorithm:** Transform Ax = b to upper triangular form Ux = y.

**Elimination Step k:**
- Multiplier: lᵢₖ = aᵢₖ⁽ᵏ⁻¹⁾/aₖₖ⁽ᵏ⁻¹⁾
- Update: aᵢⱼ⁽ᵏ⁾ = aᵢⱼ⁽ᵏ⁻¹⁾ - lᵢₖ·aₖⱼ⁽ᵏ⁻¹⁾

**Operation Count:**
- Elimination: n³/3 + O(n²) multiplications/divisions
- Backward substitution: n²/2 + O(n)
- **Total: n³/3 + O(n²)**

**Pivot Elements:** Diagonal elements a₁₁⁽¹⁾, a₂₂⁽²⁾, ..., aₙₙ⁽ⁿ⁻¹⁾

#### Pivoting Strategies

**1. No Pivoting:**
- Simplest but may fail if pivot = 0
- Only works for certain matrix classes

**2. Partial Pivoting (Maximal Column):**
- Select largest |aᵢₖ| in column k (rows k to n)
- Swap rows k and l
- Guarantees |lᵢₖ| ≤ 1, reduces rounding errors

**3. Complete Pivoting:**
- Select largest |aᵢⱼ| in remaining submatrix
- Swap rows AND columns
- Most stable but expensive O(n²) search per step

**4. Scaled Partial Pivoting:**
- Scale factor: sᵢ = maxⱼ|aᵢⱼ|
- Select row maximizing |aᵢₖ|/sᵢ
- Good for rows with vastly different scales

**Theorem 3.26:** Gaussian elimination with partial pivoting works ⟺ det(A) ≠ 0.

**Theorem 3.32:** If A is diagonally dominant:
- Gaussian elimination works without pivoting
- Method is stable w.r.t. rounding errors

**Theorem 3.33:** For symmetric A:
- A is positive definite ⟺ Gaussian elimination works without pivoting AND all pivots are positive
- Method is stable

### 3.4 Gauss-Jordan Elimination

**Algorithm:** Transform augmented matrix (A|b) to (I|x).

**Difference from Gaussian:**
- Eliminate above AND below pivots
- No backward substitution needed
- Direct solution in last column

**Operation Count:**
- n³/2 + O(n²) multiplications/divisions
- n³/2 + O(n²) additions/subtractions
- **More expensive than Gaussian elimination**

**Use Cases:**
- Matrix inversion
- When multiple RHS vectors
- Educational purposes

### 3.5 Tridiagonal Linear Systems

**Tridiagonal Matrix:** aᵢⱼ = 0 for |i-j| > 1

```
⎛ d₁  c₁   0   ...   0  ⎞ ⎛ x₁ ⎞   ⎛ b₁ ⎞
⎜ a₁  d₂  c₂   0   ...  ⎟ ⎜ x₂ ⎟   ⎜ b₂ ⎟
⎜  0  a₂  d₃  c₃  ...  ⎟ ⎜ x₃ ⎟ = ⎜ b₃ ⎟
⎜ ... ... ... ... ...  ⎟ ⎜... ⎟   ⎜... ⎟
⎝  0  ...  aₙ₋₁ dₙ  cₙ₋₁⎠ ⎝ xₙ ⎠   ⎝ bₙ ⎠
```

**Storage:** Only 3n-2 elements needed (vectors a, d, c)

**Algorithm 3.37 (Thomas Algorithm):**

**Elimination:**
```
for i = 2 to n:
    temp = aᵢ₋₁/dᵢ₋₁
    dᵢ = dᵢ - temp·cᵢ₋₁
    bᵢ = bᵢ - temp·bᵢ₋₁
```

**Backward Substitution:**
```
xₙ = bₙ/dₙ
for i = n-1 to 1:
    xᵢ = (bᵢ - cᵢ·xᵢ₊₁)/dᵢ
```

**Operation Count:** 5n - 4 multiplications/divisions = **O(n)**

**Comparison:** O(n) vs O(n³) for general Gaussian elimination!

### 3.6 Simultaneous Linear Systems

**Problem:** Solve Ax⁽ⁱ⁾ = b⁽ⁱ⁾ for i = 1,...,m

**Matrix Form:** AX = B where:
- X = (x⁽¹⁾, ..., x⁽ᵐ⁾) - solution columns
- B = (b⁽¹⁾, ..., b⁽ᵐ⁾) - RHS columns

**Method:** Apply elimination to augmented matrix (A | B) of size n × (n+m)

**Operation Count:**
- Gaussian: n³/3 + mn² - n/3 multiplications/divisions
- Gauss-Jordan: n³/2 + mn² - n/2 multiplications/divisions

**Efficiency:** Much cheaper than solving m separate systems (n³/3 + mn² vs m·n³/3)

### 3.7 Matrix Inversion and Determinants

**Matrix Inversion:**
- Solve AX = I (simultaneous system with n RHS)
- Use Gauss-Jordan on (A | I) → (I | A⁻¹)

**Operation Count:** 2n³/3 + O(n²) multiplications/divisions

**Example:**
```
(A | I) → (I | A⁻¹)
```

**Determinant via Gaussian Elimination:**
- det(A) = (-1)ˢ · a₁₁⁽¹⁾ · a₂₂⁽²⁾ · ... · aₙₙ⁽ⁿ⁻¹⁾
- s = number of row swaps

**Theorem 3.26:** det(A) ≠ 0 ⟺ elimination with pivoting succeeds

---

## Method Comparison

| Method | Operations | Pivoting | Best For |
|--------|------------|----------|----------|
| Gaussian + Back Sub | n³/3 + O(n²) | Partial | General systems |
| Gauss-Jordan | n³/2 + O(n²) | Partial | Matrix inversion |
| Tridiagonal (Thomas) | 5n - 4 | None | Tridiagonal systems |
| Simultaneous (m RHS) | n³/3 + mn² | Partial | Multiple RHS |

---

## Key Takeaways

1. **Gaussian elimination** is the standard direct method (n³/3 operations)
2. **Partial pivoting** should always be used for numerical stability
3. **Diagonally dominant** and **positive definite** matrices don't need pivoting
4. **Tridiagonal systems** can be solved in O(n) time using Thomas algorithm
5. **Gauss-Jordan** is useful for matrix inversion but slower for single RHS
6. **Simultaneous systems** with same A benefit from shared factorization
7. **Determinant** = product of pivots (with sign from row swaps)
8. **Complete pivoting** is most stable but rarely worth the extra cost
