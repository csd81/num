# Chapter 8: Minimization of Functions

## Summary

This chapter covers numerical methods for finding minima of single and multivariable functions, classified by derivative requirements: derivative-free methods, first-derivative methods, and second-derivative methods.

### 8.1 Review of Calculus

**Theorem 8.1 (Necessary Condition):** If f: ℝⁿ → ℝ has a local extremum at **a** and is partially differentiable, then:
$$\frac{\partial f}{\partial x_i}(\mathbf{a}) = 0 \quad \text{for all } i = 1, \ldots, n$$

**Theorem 8.1 (Sufficient Condition):** If f ∈ C², ∇f(**a**) = 0, and Hessian f''(**a**) is:
- **Positive definite** → local minimum
- **Negative definite** → local maximum

**For 2-variable functions (Theorem 8.2):**

At critical point (a,b) where fₓ = fᵧ = 0:
$$D(a,b) = f_{xx}(a,b) \cdot f_{yy}(a,b) - (f_{xy}(a,b))^2$$

- D > 0 and fₓₓ < 0 → local **maximum**
- D > 0 and fₓₓ > 0 → local **minimum**
- D < 0 → saddle point (no extremum)

---

### 8.2 Golden Section Search Method

**For:** Unimodal functions on [a,b] (functions with unique minimum)

**Idea:** Similar to bisection, but maintains golden ratio to reuse one function evaluation per step.

**Golden Ratio:**
$$r = \frac{\sqrt{5} - 1}{2} \approx 0.618034$$

Satisfies: $\frac{r}{1-r} = \frac{1}{r}$

**Algorithm:**
1. Initialize: x = a + r(b-a), y = a + (1-r)(b-a)
2. Compare f(x) and f(y):
   - If f(x) > f(y): minimum in [a,x], set b = x
   - If f(x) ≤ f(y): minimum in [y,b], set a = y
3. Reuse one point, compute one new function value
4. Repeat until (b-a) < ε

**Convergence:** After n steps, interval length = (b-a)rⁿ

**Steps needed:**
$$n \geq \frac{\log(\varepsilon/(b-a))}{\log r}$$

**Advantages:**
- Only 1 function evaluation per iteration
- Guaranteed convergence for unimodal functions
- No derivatives needed

---

### 8.3 Simplex Method

**Simplex:** Convex hull of n+1 vectors in ℝⁿ
- 1D: line segment
- 2D: triangle
- 3D: tetrahedron

**Algorithm:**
1. Start with n+1 vertices
2. Find "worst" vertex x⁽ʲ⁾ (largest f value)
3. Compute center of best n vertices:
   $$\mathbf{x}_c = \frac{1}{n}\sum_{i \neq j} \mathbf{x}^{(i)}$$
4. **Reflect:** xᵣ = 2x_c - x⁽ʲ⁾
5. If f(xᵣ) < f(x⁽ʲ⁾): accept reflection
6. Otherwise: **shrink** toward best vertex:
   $$\mathbf{x}^{(i)} \leftarrow \mathbf{x}^{(k)} + \frac{1}{2}(\mathbf{x}^{(i)} - \mathbf{x}^{(k)})$$

**Stopping Criteria:**
- Max edge length < tolerance
- |fₖ₊₁ - fₖ| < ε
- Standard deviation of vertex values < ε

---

### Nelder-Mead Method

**Enhanced simplex method** with expansion and contraction:

**Vertices ordered:** f(x⁽⁰⁾) ≤ f(x⁽¹⁾) ≤ ... ≤ f(x⁽ⁿ⁾)

**Reflection:** xᵣ = 2x_c - x⁽ⁿ⁾ where x_c = (1/n)Σᵢ₌₀ⁿ⁻¹ x⁽ⁱ⁾

**Three Cases:**

1. **Accept reflection:** f(x⁽⁰⁾) < f(xᵣ) < f(x⁽ⁿ⁻¹⁾)
   - Replace x⁽ⁿ⁾ with xᵣ

2. **Expand:** f(xᵣ) ≤ f(x⁽⁰⁾) (xᵣ is new best)
   - xₑ = x_c + α(xᵣ - x_c), α > 1
   - If f(xₑ) < f(x⁽⁰⁾): accept xₑ
   - Otherwise: accept xᵣ

3. **Contract:** f(xᵣ) ≥ f(x⁽ⁿ⁻¹⁾)
   - x_z = x_c ± β(xᵣ - x_c), 0 < β < 1
   - If f(x_z) < min{f(x⁽ⁿ⁾), f(xᵣ)}: accept x_z
   - Otherwise: **shrink** all toward x⁽⁰⁾

**Typical parameters:** α = 1.4 (expansion), β = 0.7 (contraction)

---

### 8.4 Gradient Method (Steepest Descent)

**Idea:** Move in direction of negative gradient (steepest descent direction).

**Iteration:**
$$\mathbf{p}^{(k+1)} = \mathbf{p}^{(k)} - \alpha_k \nabla f(\mathbf{p}^{(k)})$$

**Step size αₖ:** Found by line search (minimize φ(α) = f(**p**⁽ᵏ⁾ - α∇f(**p**⁽ᵏ⁾)))

**Theorem 8.8:** For quadratic f(**x**) = ½**x**ᵀA**x** - **b**ᵀ**x** + c with A symmetric positive definite:
- Optimal step size: $\alpha_k = \frac{\mathbf{r}^{(k)T}\mathbf{r}^{(k)}}{\mathbf{r}^{(k)T}A\mathbf{r}^{(k)}}$ where **r**⁽ᵏ⁾ = ∇f(**p**⁽ᵏ⁾)
- Convergence rate depends on condition number κ(A)
- Large κ(A) → slow convergence (zigzag pattern)

---

### 8.5 Newton's Method for Minimization

**Idea:** Use second-order Taylor approximation.

**Quadratic model:**
$$q(\mathbf{x}) = f(\mathbf{p}^{(k)}) + \nabla f(\mathbf{p}^{(k)})^T(\mathbf{x} - \mathbf{p}^{(k)}) + \frac{1}{2}(\mathbf{x} - \mathbf{p}^{(k)})^T f''(\mathbf{p}^{(k)})(\mathbf{x} - \mathbf{p}^{(k)})$$

**Iteration:**
$$\mathbf{p}^{(k+1)} = \mathbf{p}^{(k)} - [f''(\mathbf{p}^{(k)})]^{-1} \nabla f(\mathbf{p}^{(k)})$$

**In practice:** Solve linear system
$$f''(\mathbf{p}^{(k)})\mathbf{s}^{(k)} = -\nabla f(\mathbf{p}^{(k)})$$
$$\mathbf{p}^{(k+1)} = \mathbf{p}^{(k)} + \mathbf{s}^{(k)}$$

**Theorem 8.11:** If f ∈ C³, ∇f(**p**) = 0, f''(**p**) positive definite, and **p**⁽⁰⁾ close to **p**:
- Newton's method converges **quadratically**

**Problems:**
- Requires Hessian computation (n² second derivatives)
- Requires matrix inversion (O(n³) operations)
- May not converge if initial point far from minimum
- Hessian may not be positive definite

---

### 8.6 Steepest Descent vs Newton

| Property | Gradient Method | Newton's Method |
|----------|-----------------|-----------------|
| Convergence | Linear | Quadratic |
| Per-iteration cost | O(n) | O(n³) |
| Derivatives needed | First (gradient) | First + Second (Hessian) |
| Robustness | More robust | Needs good initial guess |
| Step direction | -∇f | -[f'']⁻¹∇f |

---

### 8.7 Quasi-Newton Methods

**Goal:** Approximate Hessian to avoid computing second derivatives.

**General form:**
$$\mathbf{p}^{(k+1)} = \mathbf{p}^{(k)} - [A^{(k)}]^{-1} \nabla f(\mathbf{p}^{(k)})$$

where A⁽ᵏ⁾ ≈ f''(**p**⁽ᵏ⁾)

---

#### Broyden's Method (for minimization)

**Secant equation:** A⁽ᵏ⁺¹⁾**s**⁽ᵏ⁾ = **y**⁽ᵏ⁾

where **s**⁽ᵏ⁾ = **p**⁽ᵏ⁺¹⁾ - **p**⁽ᵏ⁾, **y**⁽ᵏ⁾ = ∇f(**p**⁽ᵏ⁺¹⁾) - ∇f(**p**⁽ᵏ⁾)

**Update:**
$$A^{(k+1)} = A^{(k)} + \frac{(\mathbf{y}^{(k)} - A^{(k)}\mathbf{s}^{(k)})(\mathbf{s}^{(k)})^T}{\|\mathbf{s}^{(k)}\|_2^2}$$

**Problem:** A⁽ᵏ⁾ not symmetric, may not be positive definite

---

#### PSB Update (Powell-Symmetric-Broyden)

**Makes A⁽ᵏ⁾ symmetric:**
$$A^{(k+1)} = A^{(k)} + \frac{(\mathbf{y}^{(k)} - A^{(k)}\mathbf{s}^{(k)})(\mathbf{s}^{(k)})^T + \mathbf{s}^{(k)}(\mathbf{y}^{(k)} - A^{(k)}\mathbf{s}^{(k)})^T}{\|\mathbf{s}^{(k)}\|_2^2} - \frac{(\mathbf{y}^{(k)} - A^{(k)}\mathbf{s}^{(k)})^T\mathbf{s}^{(k)}}{\|\mathbf{s}^{(k)}\|_2^4}\mathbf{s}^{(k)}(\mathbf{s}^{(k)})^T$$

**Theorem 8.17:** Superlinear convergence if A⁽⁰⁾ close to f''(**p**)

---

#### BFGS Update (Best Known)

**Preserves positive definiteness:**
$$A^{(k+1)} = A^{(k)} + \frac{\mathbf{y}^{(k)}(\mathbf{y}^{(k)})^T}{(\mathbf{y}^{(k)})^T\mathbf{s}^{(k)}} - \frac{A^{(k)}\mathbf{s}^{(k)}(\mathbf{s}^{(k)})^T A^{(k)}}{(\mathbf{s}^{(k)})^T A^{(k)}\mathbf{s}^{(k)}}$$

**Condition:** (**y**⁽ᵏ⁾)ᵀ**s**⁽ᵏ⁾ > 0 (automatically satisfied near minimum)

**Inverse update (B⁽ᵏ⁾ = [A⁽ᵏ⁾]⁻¹):**
$$B^{(k+1)} = B^{(k)} + \left(1 + \frac{(\mathbf{y}^{(k)})^T B^{(k)} \mathbf{y}^{(k)}}{(\mathbf{s}^{(k)})^T \mathbf{y}^{(k)}}\right)\frac{\mathbf{s}^{(k)}(\mathbf{s}^{(k)})^T}{(\mathbf{s}^{(k)})^T \mathbf{y}^{(k)}} - \frac{\mathbf{s}^{(k)}(\mathbf{y}^{(k)})^T B^{(k)} + B^{(k)}\mathbf{y}^{(k)}(\mathbf{s}^{(k)})^T}{(\mathbf{s}^{(k)})^T \mathbf{y}^{(k)}}$$

**Theorem 8.19:** Superlinear convergence

---

#### DFP Update (Davidon-Fletcher-Powell)

$$A^{(k+1)} = A^{(k)} + \frac{(\mathbf{y}^{(k)} - A^{(k)}\mathbf{s}^{(k)})(\mathbf{y}^{(k)})^T + \mathbf{y}^{(k)}(\mathbf{y}^{(k)} - A^{(k)}\mathbf{s}^{(k)})^T}{(\mathbf{y}^{(k)})^T\mathbf{s}^{(k)}} - \frac{(\mathbf{y}^{(k)} - A^{(k)}\mathbf{s}^{(k)})^T\mathbf{s}^{(k)}}{((\mathbf{y}^{(k)})^T\mathbf{s}^{(k)})^2}\mathbf{y}^{(k)}(\mathbf{y}^{(k)})^T$$

**Inverse update:**
$$[A^{(k+1)}]^{-1} = [A^{(k)}]^{-1} + \frac{\mathbf{s}^{(k)}(\mathbf{s}^{(k)})^T}{(\mathbf{s}^{(k)})^T\mathbf{y}^{(k)}} - \frac{[A^{(k)}]^{-1}\mathbf{y}^{(k)}(\mathbf{y}^{(k)})^T[A^{(k)}]^{-1}}{(\mathbf{y}^{(k)})^T[A^{(k)}]^{-1}\mathbf{y}^{(k)}}$$

---

## Method Comparison

| Method | Derivatives | Convergence | Cost/Iteration | Best For |
|--------|-------------|-------------|----------------|----------|
| Golden Section | None | Linear (rⁿ) | 1 function eval | 1D unimodal |
| Simplex | None | Sublinear | n+1 function evals | Non-smooth |
| Nelder-Mead | None | Sublinear | 1-2 function evals | General purpose |
| Gradient | First | Linear | O(n) | Well-conditioned |
| Newton | First + Second | Quadratic | O(n³) | Near minimum |
| BFGS | First | Superlinear | O(n²) | General purpose |
| DFP | First | Superlinear | O(n²) | Alternative to BFGS |

---

## Key Takeaways

1. **Golden section** is optimal for 1D unimodal minimization (reuse function evaluations)
2. **Nelder-Mead** is popular derivative-free method for multivariable functions
3. **Gradient method** is simple but slow for ill-conditioned problems
4. **Newton's method** is fast (quadratic) but expensive per iteration
5. **BFGS** is the most popular quasi-Newton method (best overall performance)
6. **Positive definite Hessian approximation** is crucial for quasi-Newton methods
7. **Secant equation** A**s** = **y** ensures Hessian approximation stays current
8. All quasi-Newton methods achieve **superlinear convergence**
