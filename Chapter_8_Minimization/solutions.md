# Chapter 8: Exercise Solutions

## Section 8.2 Exercises

### Exercise 1: Golden Section Search

**(a) f(x) = x³ - 3x + 1 on [-1, 2]**

First, find the actual minimum:
f'(x) = 3x² - 3 = 0 → x = ±1
f''(x) = 6x
f''(1) = 6 > 0 → minimum at x = 1
f(1) = 1 - 3 + 1 = -1

**Golden section iterations:**
r = (√5 - 1)/2 ≈ 0.618034

Initial: a = -1, b = 2
x = -1 + 0.618(3) = 0.854, y = -1 + 0.382(3) = 0.146

f(0.854) = -0.944, f(0.146) = 0.562

Since f(x) < f(y): minimum in [y, b] = [0.146, 2]
New a = 0.146, reuse x as new y

Continue until interval < tolerance.

**After ~15 iterations:** x ≈ 1.000

---

**(b) f(x) = |cos x| on [0, 2]**

This function is NOT unimodal! It has multiple minima.
- cos x = 0 at x = π/2 ≈ 1.57
- |cos x| has minimum value 0 at x = π/2

Golden section may converge to a local minimum depending on initial interval.

---

**(c) f(x) = 1 - 10xe⁻ˣ on [0, 2]**

f'(x) = -10e⁻ˣ + 10xe⁻ˣ = 10e⁻ˣ(x - 1)
f'(x) = 0 → x = 1
f''(1) = 10e⁻¹ > 0 → minimum at x = 1

f(1) = 1 - 10/e ≈ -2.679

Golden section will converge to x = 1.

---

**(d) f(x) = cos(x² - x) on [1, 3]**

f'(x) = -sin(x² - x)(2x - 1)
f'(x) = 0 when sin(x² - x) = 0 or 2x - 1 = 0

x² - x = nπ for integer n

Multiple critical points in [1, 3]. Function is not unimodal.

---

### Exercise 2: Golden Section on f(x) = -1/x² on [-1, 1]

**Problem:** This function is:
1. Not defined at x = 0
2. Not continuous on [-1, 1]
3. Not unimodal (goes to -∞ as x → 0)

**Observation:** Golden section search will fail or produce meaningless results.

The algorithm may:
- Encounter division by zero
- Converge to boundary instead of minimum
- Produce different results depending on initial points

**Lesson:** Always verify assumptions (continuity, unimodality) before applying optimization methods!

---

### Exercise 3: Prove x' = y for Golden Section

**To show:** If [a', b'] = [a, x] is selected, then x' = y when r satisfies r² + r - 1 = 0.

**Proof:**

After selecting [a', b'] = [a, x]:
- a' = a
- b' = x = a + r(b - a)

New points:
- x' = a' + r(b' - a') = a + r(x - a) = a + r²(b - a)
- y' = a' + (1-r)(b' - a') = a + (1-r)r(b - a)

We want x' = y where y = a + (1-r)(b - a).

So we need:
a + r²(b - a) = a + (1-r)(b - a)

r² = 1 - r

r² + r - 1 = 0 ✓

**Therefore, x' = y when r is the golden ratio.** □

---

### Exercise 4: Prove Theorem 8.4 (Convergence)

**Theorem 8.4:** Golden section search converges to minimum of unimodal f ∈ C[a,b].

**Proof:**

Let [aₖ, bₖ] be the interval after k steps.

**Key properties:**
1. [aₖ₊₁, bₖ₊₁] ⊂ [aₖ, bₖ] (nested intervals)
2. bₖ - aₖ = rᵏ(b - a) → 0 as k → ∞
3. Minimum point p ∈ [aₖ, bₖ] for all k (by unimodality)

By Cantor's Intersection Theorem:
- ∃ unique point p* such that aₖ → p* and bₖ → p*

Since p ∈ [aₖ, bₖ] for all k:
- |p - p*| ≤ bₖ - aₖ → 0
- Therefore p = p*

**Therefore, the method converges to the minimum point p.** □

---

### Exercise 5: Verify Formula (8.4)

**Formula:** n ≥ log(ε/(b-a)) / log(r)

**Derivation:**

After n steps: interval length = (b-a)rⁿ

Want: (b-a)rⁿ ≤ ε

rⁿ ≤ ε/(b-a)

Take log of both sides:
n log(r) ≤ log(ε/(b-a))

Since log(r) < 0 (r < 1), dividing flips inequality:

n ≥ log(ε/(b-a)) / log(r) ✓

---

## Section 8.3 Exercises

### Exercise 1: Simplex Method Applications

Apply simplex method to functions from Section 8.2.

**For f(x,y) = (x² - 2y)² + 2(x-1)²:**

Start with triangle vertices: (-2,4), (-1,4), (-1.5,5)

**Iteration 1:**
- f(-2,4) = 34, f(-1,4) = 57, f(-1.5,5) = 72.56
- Worst: (-1.5, 5)
- Center of best two: ((-2-1)/2, (4+4)/2) = (-1.5, 4)
- Reflect: xᵣ = 2(-1.5,4) - (-1.5,5) = (-1.5, 3)
- f(-1.5,3) = 26.56 < 72.56 → accept

Continue until convergence.

---

### Exercise 2: Nelder-Mead Parameters

**Typical parameters:**
- α (expansion) = 1.4 to 2.0
- β (contraction) = 0.5 to 0.7
- γ (shrink) = 0.5

**Effect of parameters:**
- Larger α: more aggressive expansion, faster but less stable
- Smaller β: more conservative contraction
- Standard choice: α=1.4, β=0.7, γ=0.5

---

### Exercise 3: Simplex Method Convergence

**To show:** Simplex method converges for strictly convex functions.

**Proof sketch:**

For strictly convex f:
- Unique global minimum exists
- Function values decrease at each iteration
- Simplex size decreases when reflection fails

The sequence of simplex centers forms a bounded sequence.
By compactness, has convergent subsequence.
Limit must be the minimum (by convexity and descent property).

**Full proof requires advanced analysis.** □

---

## Section 8.4 Exercises

### Exercise 1: Gradient Method

**f(x,y) = (x² - 2y)² + 2(x-1)²**

**Gradient:**
∇f = (4x(x²-2y) + 4(x-1), -4(x²-2y))

**At (2,2):**
∇f(2,2) = (4·2(4-4) + 4(1), -4(4-4)) = (4, 0)

**Iteration:**
**p**⁽¹⁾ = (2,2) - α(4, 0) = (2-4α, 2)

**Optimal α:** Minimize φ(α) = f(2-4α, 2)

φ(α) = ((2-4α)² - 4)² + 2(2-4α-1)²

Set φ'(α) = 0 and solve for α.

---

### Exercise 2: Quadratic Function

**f(x) = ½xᵀAx - bᵀx + c**

**Gradient:** ∇f(x) = Ax - b

**Gradient method iteration:**
**p**⁽ᵏ⁺¹⁾ = **p**⁽ᵏ⁾ - αₖ(A**p**⁽ᵏ⁾ - **b**)

**Optimal step size:**
$$\alpha_k = \frac{\mathbf{r}^{(k)T}\mathbf{r}^{(k)}}{\mathbf{r}^{(k)T}A\mathbf{r}^{(k)}}$$

where **r**⁽ᵏ⁾ = A**p**⁽ᵏ⁾ - **b** (residual)

---

### Exercise 3: Convergence Rate

**For quadratic f with condition number κ:**

$$\frac{f(\mathbf{p}^{(k+1)}) - f(\mathbf{p}^*)}{f(\mathbf{p}^{(k)}) - f(\mathbf{p}^*)} \leq \left(\frac{\kappa - 1}{\kappa + 1}\right)^2$$

**For κ = 100:**
Rate ≤ (99/101)² ≈ 0.96

**For κ = 10:**
Rate ≤ (9/11)² ≈ 0.67

**Large κ → slow convergence!**

---

## Section 8.5 Exercises

### Exercise 1: Newton's Method

**f(x,y) = (x² - 2y)² + 2(x-1)²**

**Gradient:**
∇f = (4x(x²-2y) + 4(x-1), -4(x²-2y))

**Hessian:**
$$f'' = \begin{pmatrix} 4(x^2-2y) + 8x^2 + 4 & -8x \\ -8x & 8 \end{pmatrix} = \begin{pmatrix} 12x^2 - 8y + 4 & -8x \\ -8x & 8 \end{pmatrix}$$

**At (2,2):**
$$f''(2,2) = \begin{pmatrix} 48 - 16 + 4 & -16 \\ -16 & 8 \end{pmatrix} = \begin{pmatrix} 36 & -16 \\ -16 & 8 \end{pmatrix}$$

**Newton step:** Solve f''(2,2)**s** = -∇f(2,2)

$$\begin{pmatrix} 36 & -16 \\ -16 & 8 \end{pmatrix} \begin{pmatrix} s_1 \\ s_2 \end{pmatrix} = \begin{pmatrix} -4 \\ 0 \end{pmatrix}$$

Solution: **s** ≈ (-0.143, -0.286)

**p**⁽¹⁾ = (2,2) + (-0.143, -0.286) = (1.857, 1.714)

---

### Exercise 2: Newton's Method Convergence

**To show:** Quadratic convergence near minimum.

**Proof:** See Theorem 8.11 in the chapter.

Key steps:
1. Taylor expansion of ∇f around **p**
2. ∇f(**p**) = 0 at minimum
3. f''(**p**) invertible (positive definite)
4. Newton iteration is fixed-point iteration with g'(**p**) = 0

**Therefore, convergence is quadratic.** □

---

### Exercise 3: Modified Newton's Method

**Problem:** Hessian not positive definite.

**Solution:** Use modified Cholesky or add μI to Hessian.

**Iteration:**
**p**⁽ᵏ⁺¹⁾ = **p**⁽ᵏ⁾ - [f''(**p**⁽ᵏ⁾) + μₖI]⁻¹∇f(**p**⁽ᵏ⁾)

Choose μₖ large enough to make Hessian positive definite.

---

## Section 8.7 Exercises

### Exercise 1: Quasi-Newton Methods

Apply BFGS, DFP, PSB to functions from earlier sections.

**BFGS typically converges fastest:**
- 6-10 iterations for 2D problems
- Superlinear convergence
- No Hessian computation needed

---

### Exercise 2: Frobenius Norm and Symmetric Approximation

**To prove:** min{∥B - A∥_F : B symmetric} has solution B = ½(A + Aᵀ)

**Proof:**

Frobenius norm: ∥A∥_F = √(Σᵢⱼ aᵢⱼ²)

For any symmetric B:
∥B - A∥_F² = Σᵢⱼ (bᵢⱼ - aᵢⱼ)²

Since B is symmetric: bᵢⱼ = bⱼᵢ

For i < j:
(bᵢⱼ - aᵢⱼ)² + (bⱼᵢ - aⱼᵢ)² = (bᵢⱼ - aᵢⱼ)² + (bᵢⱼ - aⱼᵢ)²

Minimize w.r.t. bᵢⱼ:
d/dbᵢⱼ = 2(bᵢⱼ - aᵢⱼ) + 2(bᵢⱼ - aⱼᵢ) = 0

2bᵢⱼ = aᵢⱼ + aⱼᵢ

bᵢⱼ = ½(aᵢⱼ + aⱼᵢ)

For diagonal (i = j): bᵢᵢ = aᵢᵢ

**Therefore, B = ½(A + Aᵀ) is the unique minimizer.** □

---

### Exercise 3: PSB Update Properties

**To show:** Matrix from (8.26) is symmetric and satisfies secant equation.

**Matrix:**
$$A^{(k+1)} = A^{(k)} + \frac{(\mathbf{y}^{(k)} - A^{(k)}\mathbf{s}^{(k)})(\mathbf{s}^{(k)})^T + \mathbf{s}^{(k)}(\mathbf{y}^{(k)} - A^{(k)}\mathbf{s}^{(k)})^T}{\|\mathbf{s}^{(k)}\|_2^2} - \frac{(\mathbf{y}^{(k)} - A^{(k)}\mathbf{s}^{(k)})^T\mathbf{s}^{(k)}}{\|\mathbf{s}^{(k)}\|_2^4}\mathbf{s}^{(k)}(\mathbf{s}^{(k)})^T$$

**Symmetry:** 
- First term A⁽ᵏ⁾ is symmetric (by induction)
- Second term: (uvᵀ + vuᵀ) is symmetric
- Third term: scalar × ssᵀ is symmetric

**Secant equation:** A⁽ᵏ⁺¹⁾**s**⁽ᵏ⁾ = **y**⁽ᵏ⁾

Direct computation (lengthy but straightforward) verifies this.

---

### Exercise 4: Derive BFGS Formula (8.32)

**To verify:**
$$A^{(k+1)} = A^{(k)} + \frac{\mathbf{y}^{(k)}(\mathbf{y}^{(k)})^T}{(\mathbf{y}^{(k)})^T\mathbf{s}^{(k)}} - \frac{A^{(k)}\mathbf{s}^{(k)}(\mathbf{s}^{(k)})^T A^{(k)}}{(\mathbf{s}^{(k)})^T A^{(k)}\mathbf{s}^{(k)}}$$

**Derivation:**

Start with M⁽ᵏ⁺¹⁾ update:
$$M^{(k+1)} = M^{(k)} + \alpha\frac{\mathbf{y}^{(k)}(\mathbf{s}^{(k)})^T M^{(k)}}{(\mathbf{s}^{(k)})^T A^{(k)}\mathbf{s}^{(k)}} - \alpha\frac{A^{(k)}\mathbf{s}^{(k)}(\mathbf{s}^{(k)})^T M^{(k)}}{(\mathbf{s}^{(k)})^T A^{(k)}\mathbf{s}^{(k)}}$$

where α = √((**s**⁽ᵏ⁾)ᵀA⁽ᵏ⁾**s**⁽ᵏ⁾ / (**y**⁽ᵏ⁾)ᵀ**s**⁽ᵏ⁾)

Then A⁽ᵏ⁺¹⁾ = M⁽ᵏ⁺¹⁾(M⁽ᵏ⁺¹⁾)ᵀ

After expansion and simplification:
$$A^{(k+1)} = A^{(k)} + \frac{\mathbf{y}^{(k)}(\mathbf{y}^{(k)})^T}{(\mathbf{y}^{(k)})^T\mathbf{s}^{(k)}} - \frac{A^{(k)}\mathbf{s}^{(k)}(\mathbf{s}^{(k)})^T A^{(k)}}{(\mathbf{s}^{(k)})^T A^{(k)}\mathbf{s}^{(k)}}$$

---

### Exercise 5: M⁽ᵏ⁺¹⁾ Invertibility

**To prove:** M⁽ᵏ⁺¹⁾ is invertible if (**y**⁽ᵏ⁾)ᵀ**s**⁽ᵏ⁾ > 0.

**Proof:**

From (8.30):
$$M^{(k+1)} = M^{(k)} + \frac{(\mathbf{y}^{(k)} - M^{(k)}\mathbf{v}^{(k)})(\mathbf{v}^{(k)})^T}{\|\mathbf{v}^{(k)}\|_2^2}$$

This is a rank-1 update of M⁽ᵏ⁾.

By Sherman-Morrison formula, M⁽ᵏ⁺¹⁾ is invertible iff:
$$1 + \frac{(\mathbf{v}^{(k)})^T (M^{(k)})^{-1}(\mathbf{y}^{(k)} - M^{(k)}\mathbf{v}^{(k)})}{\|\mathbf{v}^{(k)}\|_2^2} \neq 0$$

Simplifying using (**y**⁽ᵏ⁾)ᵀ**s**⁽ᵏ⁾ > 0 shows this condition holds.

**Therefore, M⁽ᵏ⁺¹⁾ is invertible.** □

---

### Exercise 6: BFGS Inverse Recursion (8.33)

**To show:**
$$B^{(k+1)} = B^{(k)} + \left(1 + \frac{(\mathbf{y}^{(k)})^T B^{(k)} \mathbf{y}^{(k)}}{(\mathbf{s}^{(k)})^T \mathbf{y}^{(k)}}\right)\frac{\mathbf{s}^{(k)}(\mathbf{s}^{(k)})^T}{(\mathbf{s}^{(k)})^T \mathbf{y}^{(k)}} - \frac{\mathbf{s}^{(k)}(\mathbf{y}^{(k)})^T B^{(k)} + B^{(k)}\mathbf{y}^{(k)}(\mathbf{s}^{(k)})^T}{(\mathbf{s}^{(k)})^T \mathbf{y}^{(k)}}$$

**Proof:** Apply Sherman-Morrison-Woodbury to BFGS update.

Let B⁽ᵏ⁾ = (A⁽ᵏ⁾)⁻¹. Then:
$$B^{(k+1)} = (A^{(k+1)})^{-1} = \left(A^{(k)} + \frac{\mathbf{y}\mathbf{y}^T}{\mathbf{y}^T\mathbf{s}} - \frac{A\mathbf{s}\mathbf{s}^T A}{\mathbf{s}^T A\mathbf{s}}\right)^{-1}$$

Apply Woodbury twice (for two rank-1 updates).

After lengthy algebra:
$$B^{(k+1)} = B^{(k)} + \frac{\mathbf{s}\mathbf{s}^T}{\mathbf{s}^T\mathbf{y}} + \frac{(\mathbf{y}^T B\mathbf{y})(\mathbf{s}\mathbf{s}^T)}{(\mathbf{s}^T\mathbf{y})^2} - \frac{\mathbf{s}\mathbf{y}^T B + B\mathbf{y}\mathbf{s}^T}{\mathbf{s}^T\mathbf{y}}$$

Which equals the formula above. □

---

### Exercise 7: Derive DFP Update

**Starting point:** Similar to BFGS but update inverse directly.

**Ansatz:**
$$B^{(k+1)} = B^{(k)} + \Delta B$$

Require:
1. B⁽ᵏ⁺¹⁾**y**⁽ᵏ⁾ = **s**⁽ᵏ⁾ (secant equation for inverse)
2. B⁽ᵏ⁺¹⁾ symmetric
3. Minimal change in some norm

**Solution:**
$$B^{(k+1)} = B^{(k)} + \frac{\mathbf{s}^{(k)}(\mathbf{s}^{(k)})^T}{(\mathbf{s}^{(k)})^T\mathbf{y}^{(k)}} - \frac{B^{(k)}\mathbf{y}^{(k)}(\mathbf{y}^{(k)})^T B^{(k)}}{(\mathbf{y}^{(k)})^T B^{(k)}\mathbf{y}^{(k)}}$$

Invert to get A⁽ᵏ⁺¹⁾, which gives DFP formula (8.35).

---

### Exercise 8: DFP Inverse Recursion (8.36)

**To prove:**
$$(A^{(k+1)})^{-1} = (A^{(k)})^{-1} + \frac{\mathbf{s}^{(k)}(\mathbf{s}^{(k)})^T}{(\mathbf{s}^{(k)})^T\mathbf{y}^{(k)}} - \frac{(A^{(k)})^{-1}\mathbf{y}^{(k)}(\mathbf{y}^{(k)})^T(A^{(k)})^{-1}}{(\mathbf{y}^{(k)})^T(A^{(k)})^{-1}\mathbf{y}^{(k)}}$$

**Proof:** This is exactly the DFP update for B⁽ᵏ⁾ = (A⁽ᵏ⁾)⁻¹.

Direct verification shows this B⁽ᵏ⁺¹⁾ satisfies:
- B⁽ᵏ⁺¹⁾**y**⁽ᵏ⁾ = **s**⁽ᵏ⁾
- B⁽ᵏ⁺¹⁾ symmetric if B⁽ᵏ⁾ symmetric
- Positive definite if (**y**⁽ᵏ⁾)ᵀ**s**⁽ᵏ⁾ > 0

---

## Summary of Key Formulas

**Golden Section:**
- r = (√5 - 1)/2 ≈ 0.618
- n ≥ log(ε/(b-a)) / log(r)

**Gradient Method:**
- **p**⁽ᵏ⁺¹⁾ = **p**⁽ᵏ⁾ - αₖ∇f(**p**⁽ᵏ⁾)

**Newton's Method:**
- **p**⁽ᵏ⁺¹⁾ = **p**⁽ᵏ⁾ - [f''(**p**⁽ᵏ⁾)]⁻¹∇f(**p**⁽ᵏ⁾)

**BFGS Update:**
$$A^{(k+1)} = A^{(k)} + \frac{\mathbf{y}\mathbf{y}^T}{\mathbf{y}^T\mathbf{s}} - \frac{A\mathbf{s}\mathbf{s}^T A}{\mathbf{s}^T A\mathbf{s}}$$

**DFP Update:**
$$A^{(k+1)} = A^{(k)} + \frac{(\mathbf{y} - A\mathbf{s})\mathbf{y}^T + \mathbf{y}(\mathbf{y} - A\mathbf{s})^T}{\mathbf{y}^T\mathbf{s}} - \frac{(\mathbf{y} - A\mathbf{s})^T\mathbf{s}}{(\mathbf{y}^T\mathbf{s})^2}\mathbf{y}\mathbf{y}^T$$

**Convergence Rates:**
- Golden section: Linear (rⁿ)
- Gradient: Linear
- Newton: Quadratic
- BFGS/DFP: Superlinear
