# Chapter 4: Iterative Techniques for Solving Linear Systems

## Summary

This chapter covers iterative methods for solving linear systems, including Jacobi and Gauss-Seidel iterations, convergence analysis, condition numbers, and iterative refinement for ill-conditioned systems.

### 4.1 Linear Fixed-Point Iteration

**General Form:**
$$x^{(k+1)} = Tx^{(k)} + c, \quad k = 0, 1, 2, \ldots$$

**Theorem 4.1 (Equivalent Conditions):** The following are equivalent:
1. lim_{k→∞} Tᵏ = 0 (zero matrix)
2. lim_{k→∞} Tᵏx = 0 for all x ∈ ℝⁿ
3. ρ(T) < 1 (spectral radius less than 1)

**Theorem 4.2:** If ∥T∥ < 1 in some matrix norm, then ∥Tᵏ∥ → 0.

**Neumann Series (Theorem 4.3):** If ρ(A) < 1:
- I - A is invertible
- (I - A)⁻¹ = I + A + A² + A³ + ...
- Series converges to the inverse

**Corollary 4.4:** If ∥A∥ < 1:
$$\|(I - A)^{-1}\| \leq \frac{1}{1 - \|A\|}$$

**Theorem 4.5 (Perturbation):** If A is nonsingular and ∥A - B∥ < 1/∥A⁻¹∥, then B is also nonsingular with:
$$\|B^{-1}\| \leq \frac{\|A^{-1}\|}{1 - \|A^{-1}\|\|A - B\|}$$

**Theorem 4.6 (Convergence):** The fixed-point equation x = Tx + c has a unique solution and the iteration converges for all x⁽⁰⁾ if and only if ρ(T) < 1.

**Corollary 4.7:** If ∥T∥ < 1, iteration converges with error bound:
$$\|x^{(k)} - x\| \leq \|T\|^k \|x^{(0)} - x\|$$

**A Priori Error Estimate:**
$$\|x^{(k)} - x\| \leq \frac{\|T\|^k}{1 - \|T\|} \|x^{(1)} - x^{(0)}\|$$

**A Posteriori Error Estimate:**
$$\|x^{(k)} - x\| \leq \frac{\|T\|}{1 - \|T\|} \|x^{(k)} - x^{(k-1)}\|$$

---

### 4.2 Jacobi Iteration

**For system Ax = b with aᵢᵢ ≠ 0:**

**Iteration Formula:**
$$x_i^{(k+1)} = -\sum_{j \neq i} \frac{a_{ij}}{a_{ii}} x_j^{(k)} + \frac{b_i}{a_{ii}}, \quad i = 1, \ldots, n$$

**Matrix Decomposition:** A = L + D + U where:
- L: strictly lower triangular
- D: diagonal
- U: strictly upper triangular

**Jacobi Iteration Matrix:**
$$x^{(k+1)} = T_J x^{(k)} + c$$
$$T_J = -D^{-1}(L + U), \quad c = D^{-1}b$$

**Theorem 4.9:** Jacobi iteration converges for all x⁽⁰⁾ ⟺ ρ(T_J) < 1.

**Corollary 4.10:** If ∥T_J∥ < 1 in some norm, Jacobi converges.

**Theorem 4.11:** If A is **diagonally dominant**, Jacobi iteration converges for all initial values.

**Proof:** ∥T_J∥_∞ = max_i Σ_{j≠i} |aᵢⱼ|/|aᵢᵢ| < 1 by diagonal dominance.

---

### 4.3 Gauss-Seidel Iteration

**Key Difference from Jacobi:** Uses newly computed values immediately.

**Iteration Formula:**
$$x_i^{(k+1)} = -\sum_{j=1}^{i-1} \frac{a_{ij}}{a_{ii}} x_j^{(k+1)} - \sum_{j=i+1}^{n} \frac{a_{ij}}{a_{ii}} x_j^{(k)} + \frac{b_i}{a_{ii}}$$

**Matrix Form:**
$$(D + L)x^{(k+1)} = -Ux^{(k)} + b$$

**Gauss-Seidel Iteration Matrix:**
$$T_{GS} = -(D + L)^{-1}U, \quad c = (D + L)^{-1}b$$

**Theorem 4.13:** Gauss-Seidel converges ⟺ ρ(T_GS) < 1.

**Theorem 4.15:** If A is diagonally dominant, Gauss-Seidel converges for all x⁽⁰⁾.

**Theorem 4.16 (Stein-Rosenberg):** For matrices with aᵢⱼ ≤ 0 (i ≠ j) and aᵢᵢ > 0, exactly one holds:
1. 0 ≤ ρ(T_GS) < ρ(T_J) < 1 (both converge, GS faster)
2. 1 < ρ(T_J) < ρ(T_GS) (both diverge)
3. ρ(T_J) = ρ(T_GS) = 0
4. ρ(T_J) = ρ(T_GS) = 1

**Comparison:**
| Property | Jacobi | Gauss-Seidel |
|----------|--------|--------------|
| Uses old values | All x⁽ᵏ⁾ | Mix of x⁽ᵏ⁺¹⁾ and x⁽ᵏ⁾ |
| Parallelizable | Yes | No (sequential) |
| Convergence rate | Slower | Typically faster |
| Storage | 2 vectors | 1 vector (in-place) |

---

### 4.4 Error Bounds and Iterative Refinement

**Residual Vector:** r = b - Ax̃

**Theorem 4.18:** For exact solution x and approximate x̃:
$$\|x - \tilde{x}\| \leq \|A^{-1}\|\|r\|$$
$$\frac{\|x - \tilde{x}\|}{\|x\|} \leq \|A\|\|A^{-1}\| \frac{\|r\|}{\|b\|}$$

**Condition Number:**
$$\text{cond}(A) = \|A\|\|A^{-1}\|$$

**Interpretation:**
- cond(A) ≥ 1 always
- cond(A) ≈ 1: well-conditioned
- cond(A) > 100-1000: ill-conditioned
- Relative error can be amplified by cond(A)

**Condition Number Properties (Theorem 4.24):**
1. cond(A) ≥ 1
2. ρ(A)ρ(A⁻¹) ≤ cond(A)

**Spectral Condition Number:**
$$\text{cond}_*(A) = \rho(A)\rho(A^{-1})$$

**Theorem 4.25 (Gastinel):**
$$\frac{1}{\text{cond}(A)} = \min\left\{\frac{\|A - B\|}{\|A\|} : B \text{ is singular}\right\}$$

**Interpretation:** 1/cond(A) is the relative distance to the nearest singular matrix.

---

### Iterative Refinement Algorithm

**Purpose:** Improve solution accuracy for ill-conditioned systems.

**Algorithm 4.20:**
```
1. Solve Ax = b with Gaussian elimination → x̃
2. For k = 1, 2, ..., N:
   a. Compute residual r = b - Ax (double precision)
   b. Solve Ay = r for y
   c. Update: z = x + y
   d. If k=1: estimate cond(A) ≈ 10^t · ∥y∥/∥x∥
   e. If ∥y∥ < TOL: stop
   f. x ← z
```

**Key Points:**
- Residual computed in **double precision**
- Uses same LU factorization for Ay = r
- Condition number estimate from first iteration
- Effective even for ill-conditioned matrices

**Example:** For 4-digit arithmetic with ill-conditioned A:
- Initial relative error: 25%
- After one refinement step: much closer to true solution

---

### 4.5 Perturbation of Linear Systems

**Problem:** How does solution change when A and b are perturbed?

**Theorem 4.22 (RHS Perturbation):** For Ax = b and Ax̃ = b̃:
$$\frac{\|x - \tilde{x}\|}{\|x\|} \leq \text{cond}(A) \frac{\|b - \tilde{b}\|}{\|b\|}$$

**Theorem 4.23 (General Perturbation):** For Ax = b and Ãx̃ = b̃ with ∥A - Ã∥ < 1/∥A⁻¹∥:
$$\frac{\|x - \tilde{x}\|}{\|x\|} \leq \frac{\text{cond}(A)}{1 - \text{cond}(A)\frac{\|A - \tilde{A}\|}{\|A\|}} \left(\frac{\|A - \tilde{A}\|}{\|A\|} + \frac{\|b - \tilde{b}\|}{\|b\|}\right)$$

**Interpretation:**
- One order of magnitude increase in cond(A) → loss of one significant digit
- Small residual ≠ small error for ill-conditioned systems
- Condition number measures sensitivity to perturbations

---

### Hilbert Matrix (Ill-Conditioned Example)

$$H_n = \begin{pmatrix}
1 & 1/2 & 1/3 & \cdots & 1/n \\
1/2 & 1/3 & 1/4 & \cdots & 1/(n+1) \\
1/3 & 1/4 & 1/5 & \cdots & 1/(n+2) \\
\vdots & \vdots & \vdots & \ddots & \vdots \\
1/n & 1/(n+1) & 1/(n+2) & \cdots & 1/(2n-1)
\end{pmatrix}$$

**Spectral Condition Numbers:**

| n | cond*(Hₙ) |
|---|-----------|
| 3 | 5.24 × 10² |
| 4 | 1.55 × 10⁴ |
| 5 | 4.77 × 10⁵ |
| 6 | 1.50 × 10⁶ |
| 7 | 7.45 × 10⁸ |
| 8 | 1.53 × 10¹⁰ |
| 9 | 4.93 × 10¹¹ |
| 10 | 1.60 × 10¹³ |

Condition numbers grow **exponentially** with n!

---

## Stopping Criteria for Iterations

Similar to nonlinear equations (Section 2.8):

1. **Absolute:** ∥x⁽ᵏ⁺¹⁾ - x⁽ᵏ⁾∥ < ε
2. **Relative:** ∥x⁽ᵏ⁺¹⁾ - x⁽ᵏ⁾∥/∥x⁽ᵏ⁺¹⁾∥ < ε
3. **Residual:** ∥b - Ax⁽ᵏ⁾∥ < ε

**Warning:** Criterion (iii) is unreliable for ill-conditioned matrices (small residual ≠ small error).

---

## Key Takeaways

1. **Jacobi iteration** uses all old values; **Gauss-Seidel** uses new values immediately
2. Both converge if A is **diagonally dominant**
3. **Spectral radius ρ(T) < 1** is necessary and sufficient for convergence
4. **Condition number** measures sensitivity: large cond(A) → ill-conditioned
5. **Small residual** does NOT guarantee small error for ill-conditioned systems
6. **Iterative refinement** improves accuracy using double-precision residuals
7. **Hilbert matrices** are classic examples of ill-conditioned systems
8. For well-conditioned systems, Gauss-Seidel typically converges faster than Jacobi
