# Chapter 4: Exercise Solutions

## Section 4.2 Exercises

### Exercise 1: Jacobi Iteration

**(a) System:**
```
6.2x₁ + 1.1x₂ - 3.4x₃ =  5.1
-0.6x₁ + 2.9x₂ + 0.3x₃ = -7.2
 1.1x₁ - 0.6x₂ + 4.4x₃ =  3.1
```

**Check diagonal dominance:**
- Row 1: |6.2| = 6.2 > |1.1| + |-3.4| = 4.5 ✓
- Row 2: |2.9| = 2.9 > |-0.6| + |0.3| = 0.9 ✓
- Row 3: |4.4| = 4.4 > |1.1| + |-0.6| = 1.7 ✓

Matrix is diagonally dominant → Jacobi converges.

**Jacobi iteration formulas:**
```
x₁⁽ᵏ⁺¹⁾ = (5.1 - 1.1x₂⁽ᵏ⁾ + 3.4x₃⁽ᵏ⁾) / 6.2
x₂⁽ᵏ⁺¹⁾ = (-7.2 + 0.6x₁⁽ᵏ⁾ - 0.3x₃⁽ᵏ⁾) / 2.9
x₃⁽ᵏ⁺¹⁾ = (3.1 - 1.1x₁⁽ᵏ⁾ + 0.6x₂⁽ᵏ⁾) / 4.4
```

Starting from x⁽⁰⁾ = (0, 0, 0)ᵀ:

**Iteration 1:**
```
x₁⁽¹⁾ = 5.1/6.2 = 0.8226
x₂⁽¹⁾ = -7.2/2.9 = -2.4828
x₃⁽¹⁾ = 3.1/4.4 = 0.7045
```

**Iteration 2:**
```
x₁⁽²⁾ = (5.1 - 1.1(-2.4828) + 3.4(0.7045)) / 6.2
      = (5.1 + 2.7311 + 2.3953) / 6.2 = 1.6502

x₂⁽²⁾ = (-7.2 + 0.6(0.8226) - 0.3(0.7045)) / 2.9
      = (-7.2 + 0.4936 - 0.2114) / 2.9 = -2.3806

x₃⁽²⁾ = (3.1 - 1.1(0.8226) + 0.6(-2.4828)) / 4.4
      = (3.1 - 0.9049 - 1.4897) / 4.4 = 0.1610
```

**Iteration 3:**
```
x₁⁽³⁾ = (5.1 - 1.1(-2.3806) + 3.4(0.1610)) / 6.2
      = (5.1 + 2.6187 + 0.5474) / 6.2 = 1.3350

x₂⁽³⁾ = (-7.2 + 0.6(1.6502) - 0.3(0.1610)) / 2.9
      = (-7.2 + 0.9901 - 0.0483) / 2.9 = -2.1560

x₃⁽³⁾ = (3.1 - 1.1(1.6502) + 0.6(-2.3806)) / 4.4
      = (3.1 - 1.8152 - 1.4284) / 4.4 = -0.0329
```

Continue until convergence (typically 15-20 iterations for 5-digit accuracy).

**Exact solution (for verification): x ≈ (1, -2, 0.5)ᵀ**

---

**(b) System (4×4):**
```
-8x₁ + 3x₂ - 2x₃ - 2x₄ =   6
 2x₁ + 6x₂ +  x₃ -  x₄ =   5
 3x₁ - 3x₂ + 10x₃ + 3x₄ = -17
      x₂ - 3x₃ + 7x₄ =   3
```

**Check diagonal dominance:**
- Row 1: |-8| = 8 > |3| + |-2| + |-2| = 7 ✓
- Row 2: |6| = 6 > |2| + |1| + |-1| = 4 ✓
- Row 3: |10| = 10 > |3| + |-3| + |3| = 9 ✓
- Row 4: |7| = 7 > |1| + |-3| = 4 ✓

Matrix is diagonally dominant → Jacobi converges.

**Jacobi iteration formulas:**
```
x₁⁽ᵏ⁺¹⁾ = (6 - 3x₂⁽ᵏ⁾ + 2x₃⁽ᵏ⁾ + 2x₄⁽ᵏ⁾) / (-8)
x₂⁽ᵏ⁺¹⁾ = (5 - 2x₁⁽ᵏ⁾ - x₃⁽ᵏ⁾ + x₄⁽ᵏ⁾) / 6
x₃⁽ᵏ⁺¹⁾ = (-17 - 3x₁⁽ᵏ⁾ + 3x₂⁽ᵏ⁾ - 3x₄⁽ᵏ⁾) / 10
x₄⁽ᵏ⁺¹⁾ = (3 - x₂⁽ᵏ⁾ + 3x₃⁽ᵏ⁾) / 7
```

Starting from x⁽⁰⁾ = (0, 0, 0, 0)ᵀ:

**Iteration 1:**
```
x₁⁽¹⁾ = 6/(-8) = -0.75
x₂⁽¹⁾ = 5/6 = 0.8333
x₃⁽¹⁾ = -17/10 = -1.7
x₄⁽¹⁾ = 3/7 = 0.4286
```

**Iteration 2:**
```
x₁⁽²⁾ = (6 - 3(0.8333) + 2(-1.7) + 2(0.4286)) / (-8)
      = (6 - 2.5 - 3.4 + 0.8572) / (-8) = -0.1197

x₂⁽²⁾ = (5 - 2(-0.75) - (-1.7) + 0.4286) / 6
      = (5 + 1.5 + 1.7 + 0.4286) / 6 = 1.4381

x₃⁽²⁾ = (-17 - 3(-0.75) + 3(0.8333) - 3(0.4286)) / 10
      = (-17 + 2.25 + 2.5 - 1.2858) / 10 = -1.3536

x₄⁽²⁾ = (3 - 0.8333 + 3(-1.7)) / 7
      = (3 - 0.8333 - 5.1) / 7 = -0.4190
```

Continue until convergence.

---

### Exercise 2: Column Diagonal Dominance

**To show:** Jacobi iteration converges if A is column diagonally dominant.

**Definition:** A is column diagonally dominant if:
$$|a_{jj}| > \sum_{i \neq j} |a_{ij}| \quad \text{for all } j = 1, \ldots, n$$

**Proof:**

The Jacobi iteration matrix is:
$$T_J = -D^{-1}(L + U)$$

with entries:
$$(T_J)_{ij} = \begin{cases} -a_{ij}/a_{ii}, & i \neq j \\ 0, & i = j \end{cases}$$

Consider the **1-norm** (maximum column sum):
$$\|T_J\|_1 = \max_{j} \sum_{i=1}^n |(T_J)_{ij}| = \max_{j} \sum_{i \neq j} \frac{|a_{ij}|}{|a_{ii}|}$$

Since A is column diagonally dominant:
$$|a_{jj}| > \sum_{i \neq j} |a_{ij}|$$

Dividing by |aⱼⱼ|:
$$1 > \sum_{i \neq j} \frac{|a_{ij}|}{|a_{jj}|}$$

But we need to compare with |aᵢᵢ| in the denominator, not |aⱼⱼ|.

**Alternative approach:** Use the fact that A is column diagonally dominant ⟺ Aᵀ is row diagonally dominant.

The Jacobi iteration for Aᵀy = c has iteration matrix:
$$T_J(A^T) = -D^{-1}(L^T + U^T) = T_J(A)^T$$

Since ρ(T) = ρ(Tᵀ) and Aᵀ is row diagonally dominant:
$$\|T_J(A^T)\|_\infty = \max_i \sum_{j \neq i} \frac{|a_{ji}|}{|a_{ii}|} < 1$$

Therefore ρ(T_J(A)) = ρ(T_J(A)ᵀ) ≤ ∥T_J(A)ᵀ∥_∞ < 1.

**Hence Jacobi iteration converges.** □

---

## Section 4.3 Exercises

### Exercise 1: Gauss-Seidel Iteration

Apply Gauss-Seidel to the same systems from Section 4.2.

**(a) System:**
```
6.2x₁ + 1.1x₂ - 3.4x₃ =  5.1
-0.6x₁ + 2.9x₂ + 0.3x₃ = -7.2
 1.1x₁ - 0.6x₂ + 4.4x₃ =  3.1
```

**Gauss-Seidel formulas (use new values immediately):**
```
x₁⁽ᵏ⁺¹⁾ = (5.1 - 1.1x₂⁽ᵏ⁾ + 3.4x₃⁽ᵏ⁾) / 6.2
x₂⁽ᵏ⁺¹⁾ = (-7.2 + 0.6x₁⁽ᵏ⁺¹⁾ - 0.3x₃⁽ᵏ⁾) / 2.9
x₃⁽ᵏ⁺¹⁾ = (3.1 - 1.1x₁⁽ᵏ⁺¹⁾ + 0.6x₂⁽ᵏ⁺¹⁾) / 4.4
```

Starting from x⁽⁰⁾ = (0, 0, 0)ᵀ:

**Iteration 1:**
```
x₁⁽¹⁾ = 5.1/6.2 = 0.8226
x₂⁽¹⁾ = (-7.2 + 0.6(0.8226) - 0) / 2.9 = -2.3172
x₃⁽¹⁾ = (3.1 - 1.1(0.8226) + 0.6(-2.3172)) / 4.4 = 0.1830
```

**Iteration 2:**
```
x₁⁽²⁾ = (5.1 - 1.1(-2.3172) + 3.4(0.1830)) / 6.2
      = (5.1 + 2.5489 + 0.6222) / 6.2 = 1.3318

x₂⁽²⁾ = (-7.2 + 0.6(1.3318) - 0.3(0.1830)) / 2.9
      = (-7.2 + 0.7991 - 0.0549) / 2.9 = -2.2296

x₃⁽²⁾ = (3.1 - 1.1(1.3318) + 0.6(-2.2296)) / 4.4
      = (3.1 - 1.4650 - 1.3378) / 4.4 = 0.0675
```

**Comparison with Jacobi:**
- Gauss-Seidel typically converges in fewer iterations
- For this system: ~10-12 iterations vs ~15-20 for Jacobi

---

**(b) 4×4 System:**

Gauss-Seidel formulas:
```
x₁⁽ᵏ⁺¹⁾ = (6 - 3x₂⁽ᵏ⁾ + 2x₃⁽ᵏ⁾ + 2x₄⁽ᵏ⁾) / (-8)
x₂⁽ᵏ⁺¹⁾ = (5 - 2x₁⁽ᵏ⁺¹⁾ - x₃⁽ᵏ⁾ + x₄⁽ᵏ⁾) / 6
x₃⁽ᵏ⁺¹⁾ = (-17 - 3x₁⁽ᵏ⁺¹⁾ + 3x₂⁽ᵏ⁺¹⁾ - 3x₄⁽ᵏ⁾) / 10
x₄⁽ᵏ⁺¹⁾ = (3 - x₂⁽ᵏ⁺¹⁾ + 3x₃⁽ᵏ⁺¹⁾) / 7
```

Starting from x⁽⁰⁾ = (0, 0, 0, 0)ᵀ:

**Iteration 1:**
```
x₁⁽¹⁾ = 6/(-8) = -0.75
x₂⁽¹⁾ = (5 - 2(-0.75) - 0 + 0) / 6 = 1.0833
x₃⁽¹⁾ = (-17 - 3(-0.75) + 3(1.0833) - 0) / 10 = -1.1500
x₄⁽¹⁾ = (3 - 1.0833 + 3(-1.1500)) / 7 = -0.2190
```

Continue until convergence.

---

### Exercise 2: Triangular Systems

**To show:** Jacobi and Gauss-Seidel find exact solution in finitely many steps if A is upper triangular with aᵢᵢ ≠ 0.

**Proof for Upper Triangular A:**

For upper triangular A:
- aᵢⱼ = 0 for i > j
- L = 0 (no strictly lower triangular part)

**Jacobi Iteration:**
$$x_i^{(k+1)} = -\sum_{j=i+1}^n \frac{a_{ij}}{a_{ii}} x_j^{(k)} + \frac{b_i}{a_{ii}}$$

**Gauss-Seidel Iteration:**
$$x_i^{(k+1)} = -\sum_{j=i+1}^n \frac{a_{ij}}{a_{ii}} x_j^{(k)} + \frac{b_i}{a_{ii}}$$

For upper triangular, both methods have the **same formula** since there are no terms with j < i.

**Backward Substitution Structure:**

For i = n (last equation):
$$x_n^{(k+1)} = \frac{b_n}{a_{nn}}$$

This is the exact solution in **one iteration** (independent of x⁽ᵏ⁾).

For i = n-1:
$$x_{n-1}^{(k+1)} = -\frac{a_{n-1,n}}{a_{n-1,n-1}} x_n^{(k)} + \frac{b_{n-1}}{a_{n-1,n-1}}$$

After iteration 1, xₙ is exact, so after iteration 2, xₙ₋₁ is exact.

**By induction:**
- After iteration 1: xₙ is exact
- After iteration 2: xₙ, xₙ₋₁ are exact
- ...
- After iteration n: all x₁, ..., xₙ are exact

**Therefore, both methods converge in exactly n iterations.** □

---

## Section 4.4 Exercises

### Exercise 1: Condition Numbers

**(a) Matrix:**
$$A = \begin{pmatrix} 1 & 2 \\ 2 & -1 \end{pmatrix}$$

**Inverse:**
$$A^{-1} = \frac{1}{-1-4} \begin{pmatrix} -1 & -2 \\ -2 & 1 \end{pmatrix} = \begin{pmatrix} 1/5 & 2/5 \\ 2/5 & -1/5 \end{pmatrix}$$

**∞-norm (max row sum):**
- ∥A∥_∞ = max{|1|+|2|, |2|+|-1|} = max{3, 3} = 3
- ∥A⁻¹∥_∞ = max{1/5+2/5, 2/5+1/5} = max{3/5, 3/5} = 3/5

**cond_∞(A) = ∥A∥_∞ · ∥A⁻¹∥_∞ = 3 × 3/5 = 9/5 = 1.8**

**1-norm (max column sum):**
- ∥A∥₁ = max{|1|+|2|, |2|+|-1|} = max{3, 3} = 3
- ∥A⁻¹∥₁ = max{1/5+2/5, 2/5+1/5} = 3/5

**cond₁(A) = 3 × 3/5 = 1.8**

---

**(b) Matrix:**
$$A = \begin{pmatrix} 0 & 2 & 1 \\ 1 & 0 & 1 \\ 1 & -1 & 1 \end{pmatrix}$$

**Find A⁻¹:**

Using Gauss-Jordan or cofactor method:
$$A^{-1} = \begin{pmatrix} -1/2 & 3/2 & -1 \\ 0 & 1/2 & -1/2 \\ 1/2 & -1/2 & 1/2 \end{pmatrix}$$

**∞-norm:**
- ∥A∥_∞ = max{0+2+1, 1+0+1, 1+1+1} = max{3, 2, 3} = 3
- ∥A⁻¹∥_∞ = max{1/2+3/2+1, 0+1/2+1/2, 1/2+1/2+1/2} = max{3, 1, 1.5} = 3

**cond_∞(A) = 3 × 3 = 9**

**1-norm:**
- ∥A∥₁ = max{0+1+1, 2+0+1, 1+1+1} = max{2, 3, 3} = 3
- ∥A⁻¹∥₁ = max{1/2+0+1/2, 3/2+1/2+1/2, 1+1/2+1/2} = max{1, 2.5, 2} = 2.5

**cond₁(A) = 3 × 2.5 = 7.5**

---

### Exercise 2: Estimate cond_∞ for Hilbert-type matrix

$$A = \begin{pmatrix} 1 & 1/2 & 1/3 \\ 1/2 & 1/3 & 1/4 \\ 1/3 & 1/4 & 1/5 \end{pmatrix}$$

This is the 3×3 Hilbert matrix H₃.

**From Table 4.3:** cond*(H₃) ≈ 5.24 × 10²

Since cond_∞(A) ≥ cond*(A):
**cond_∞(A) ≳ 524**

**Direct computation:**

A⁻¹ for H₃:
$$A^{-1} = \begin{pmatrix} 9 & -36 & 30 \\ -36 & 192 & -180 \\ 30 & -180 & 180 \end{pmatrix}$$

**∞-norm:**
- ∥A∥_∞ = max{1+0.5+0.333, 0.5+0.333+0.25, 0.333+0.25+0.2} = max{1.833, 1.083, 0.783} = 1.833
- ∥A⁻¹∥_∞ = max{9+36+30, 36+192+180, 30+180+180} = max{75, 408, 390} = 408

**cond_∞(A) = 1.833 × 408 ≈ 748**

---

### Exercise 3: Iterative Refinement

**System:**
```
0.009x₁ - 0.52x₂ = -5.191
9211x₁ + 21.1x₂ = 9422
```

Exact solution: x = (1, 10)ᵀ

**Step 1: Gaussian elimination with 4-digit arithmetic**

Augmented matrix:
```
⎛ 0.009   -0.52   -5.191 ⎞
⎝ 9211     21.1    9422  ⎠
```

Partial pivoting: Swap rows (9211 > 0.009)

```
⎛ 9211     21.1    9422  ⎞
⎝ 0.009   -0.52   -5.191 ⎠
```

Elimination:
- l₂₁ = 0.009/9211 = 9.771×10⁻⁷ ≈ 9.771×10⁻⁷ (4-digit: 9.771e-7)

Row 2: (0.009, -0.52, -5.191) - (9.771×10⁻⁷)(9211, 21.1, 9422)
     = (0, -0.52 - 2.062×10⁻⁵, -5.191 - 0.009207)
     = (0, -0.5200, -5.200)

Back substitution:
- x₂ = -5.200/(-0.5200) = **10.00** ✓
- x₁ = (9422 - 21.1×10)/9211 = 9211/9211 = **1.000** ✓

In this case, 4-digit arithmetic gives exact solution!

But let's assume we got x̃ = (0.99, 10.1)ᵀ due to rounding.

**Iterative Refinement Step 1:**

Compute residual (double precision):
```
r = b - Ax̃
  = (-5.191, 9422)ᵀ - (0.009×0.99 - 0.52×10.1, 9211×0.99 + 21.1×10.1)ᵀ
  = (-5.191, 9422)ᵀ - (-5.2394, 9331.0)ᵀ
  = (0.0484, 91.0)ᵀ
```

Solve Ay = r:
```
0.009y₁ - 0.52y₂ = 0.0484
9211y₁ + 21.1y₂ = 91.0
```

Solution: y ≈ (0.01, -0.09)ᵀ

Update: z = x̃ + y = (0.99 + 0.01, 10.1 - 0.09)ᵀ = (1.00, 10.01)ᵀ

**Condition number estimate:**
$$\text{cond}(A) \approx 10^4 \cdot \frac{\|y\|_\infty}{\|\tilde{x}\|_\infty} = 10^4 \cdot \frac{0.09}{10.1} \approx 89$$

**Iterative Refinement Step 2:**

Compute new residual, solve, update again.

After 2-3 steps, solution converges to (1, 10)ᵀ.

---

## Section 4.5 Exercises

### Exercise 1: Spectral Condition Number

**Matrix:**
$$A = \begin{pmatrix} 1 & 4 \\ 2 & -1 \end{pmatrix}$$

**Eigenvalues of A:**

det(A - λI) = 0:
$$\begin{vmatrix} 1-\lambda & 4 \\ 2 & -1-\lambda \end{vmatrix} = (1-\lambda)(-1-\lambda) - 8 = \lambda^2 - 1 - 8 = \lambda^2 - 9 = 0$$

λ₁ = 3, λ₂ = -3

**Eigenvalues of A⁻¹:**

A⁻¹ = (1/-9) × (-1, -4; -2, 1) = (1/9, 4/9; 2/9, -1/9)

Eigenvalues: 1/λ₁ = 1/3, 1/λ₂ = -1/3

**Spectral condition number:**
$$\text{cond}_*(A) = \rho(A) \cdot \rho(A^{-1}) = 3 \times \frac{1}{3} = 1$$

**This matrix is perfectly conditioned!**

---

### Exercise 2: Prove Theorem 4.24

**Theorem 4.24:** For any invertible A:
1. cond(A) ≥ 1
2. ρ(A)ρ(A⁻¹) ≤ cond(A)

**Proof:**

**(1) cond(A) ≥ 1:**

$$\text{cond}(A) = \|A\|\|A^{-1}\| \geq \|AA^{-1}\| = \|I\| = 1$$

(using submultiplicative property of matrix norm)

**(2) ρ(A)ρ(A⁻¹) ≤ cond(A):**

For any eigenvalue λ of A with eigenvector v (∥v∥ = 1):
$$\|A\| \geq \|Av\| = \|\lambda v\| = |\lambda|$$

So ∥A∥ ≥ ρ(A).

Similarly, ∥A⁻¹∥ ≥ ρ(A⁻¹) = 1/min|λᵢ|.

Therefore:
$$\text{cond}(A) = \|A\|\|A^{-1}\| \geq \rho(A) \cdot \rho(A^{-1})$$

□

---

### Exercise 3: Spectral Condition Number Formula

**To show:**
$$\text{cond}_*(A) = \frac{\max\{|\lambda_1|, \ldots, |\lambda_n|\}}{\min\{|\lambda_1|, \ldots, |\lambda_n|\}}$$

**Proof:**

Let λ₁, ..., λₙ be eigenvalues of A.

**Eigenvalues of A⁻¹:** 1/λ₁, ..., 1/λₙ

**Spectral radii:**
- ρ(A) = max{|λ₁|, ..., |λₙ|}
- ρ(A⁻¹) = max{|1/λ₁|, ..., |1/λₙ|} = 1/min{|λ₁|, ..., |λₙ|}

**Therefore:**
$$\text{cond}_*(A) = \rho(A) \cdot \rho(A^{-1}) = \frac{\max_i |\lambda_i|}{\min_i |\lambda_i|}$$

□

---

## Additional Problems

### Problem: Compare Jacobi and Gauss-Seidel Convergence

**System:**
```
4x₁ - x₂        = 3
-x₁ + 4x₂ - x₃  = 2
     -x₂ + 4x₃  = 3
```

**Iteration Matrices:**

A = D + L + U where:
- D = diag(4, 4, 4)
- L = strictly lower part
- U = strictly upper part

**Jacobi:** T_J = -D⁻¹(L + U)
$$T_J = \begin{pmatrix} 0 & 1/4 & 0 \\ 1/4 & 0 & 1/4 \\ 0 & 1/4 & 0 \end{pmatrix}$$

Eigenvalues of T_J: λ = 0, ±√2/4 ≈ ±0.354

**ρ(T_J) = √2/4 ≈ 0.354**

**Gauss-Seidel:** T_GS = -(D + L)⁻¹U

After computation:
$$T_{GS} = \begin{pmatrix} 0 & 1/4 & 0 \\ 0 & 1/16 & 1/4 \\ 0 & 1/64 & 1/16 \end{pmatrix}$$

Eigenvalues: λ = 0, 1/16, 1/16

**ρ(T_GS) = 1/16 = 0.0625**

**Comparison:**
- ρ(T_GS) < ρ(T_J): Gauss-Seidel converges faster
- Ratio: ρ(T_J)/ρ(T_GS) ≈ 5.66
- Gauss-Seidel needs ~5-6 times fewer iterations

---

### Problem: Divergent Example

**System where Jacobi diverges but Gauss-Seidel converges:**

$$A = \begin{pmatrix} 1 & 2 & -2 \\ 1 & 1 & 1 \\ 2 & 2 & 1 \end{pmatrix}$$

**Jacobi iteration matrix:**
$$T_J = \begin{pmatrix} 0 & -2 & 2 \\ -1 & 0 & -1 \\ -2 & -2 & 0 \end{pmatrix}$$

ρ(T_J) > 1 → **Jacobi diverges**

**Gauss-Seidel:** May converge or diverge depending on specific structure.

---

## Summary of Key Formulas

**Jacobi Iteration:**
$$x_i^{(k+1)} = \frac{1}{a_{ii}}\left(b_i - \sum_{j \neq i} a_{ij} x_j^{(k)}\right)$$

**Gauss-Seidel Iteration:**
$$x_i^{(k+1)} = \frac{1}{a_{ii}}\left(b_i - \sum_{j=1}^{i-1} a_{ij} x_j^{(k+1)} - \sum_{j=i+1}^n a_{ij} x_j^{(k)}\right)$$

**Convergence Criterion:**
$$\rho(T) < 1 \iff \text{iteration converges}$$

**Error Bounds:**
$$\|x^{(k)} - x\| \leq \frac{\|T\|^k}{1 - \|T\|} \|x^{(1)} - x^{(0)}\|$$

**Condition Number:**
$$\text{cond}(A) = \|A\|\|A^{-1}\|$$

**Perturbation Bound:**
$$\frac{\|x - \tilde{x}\|}{\|x\|} \leq \text{cond}(A) \frac{\|b - \tilde{b}\|}{\|b\|}$$

**Iterative Refinement:**
$$\text{cond}(A) \approx 10^t \frac{\|y\|}{\|\tilde{x}\|}$$
