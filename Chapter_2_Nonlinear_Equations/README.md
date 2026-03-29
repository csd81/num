# Chapter 2: Nonlinear Algebraic Equations and Systems

## Summary

This chapter covers numerical methods for solving nonlinear equations and systems, including root-finding algorithms, convergence analysis, and vector/matrix norms.

### 2.1 Review of Calculus

**Key Theorems:**
- **Extreme Value Theorem (2.1):** Continuous functions on [a,b] attain max/min
- **Intermediate Value Theorem (2.2):** Continuous functions take all values between f(a) and f(b)
- **Rolle's Theorem (2.3):** If f(a)=f(b), then f'(ξ)=0 for some ξ∈(a,b)
- **Mean Value Theorem (2.4):** f(b)-f(a) = f'(ξ)(b-a)
- **Taylor's Theorem (2.5):** Function approximation with polynomial + remainder
- **Cantor's Intersection Theorem (2.7):** Nested intervals converge to unique point
- **Fundamental Theorem of Algebra (2.9):** Degree-n polynomial has exactly n complex roots

### 2.2 Fixed-Point Iteration

**Definition:** Given g: I → R, the sequence pₖ₊₁ = g(pₖ) is a fixed-point iteration.

**Fixed Point:** A number p where g(p) = p.

**Theorem 2.12 (Existence/Uniqueness):** If g: [a,b] → [a,b] is continuous, then g has a fixed point. If |g'(x)| ≤ c < 1, the fixed point is unique.

**Theorem 2.13 (Fixed-Point Theorem):** Under contraction conditions (|g'(x)| ≤ c < 1):
- Sequence converges to unique fixed point p
- Error bound: |pₖ - p| ≤ cᵏ|p₀ - p|
- Alternative bound: |pₖ - p| ≤ cᵏ/(1-c) · |p₁ - p₀|

**Contraction Principle (2.14):** Lipschitz continuous g with constant c < 1 guarantees convergence.

**Local Convergence (2.15):** If |g'(p)| < 1, iteration converges for p₀ sufficiently close to p.

### 2.3 Bisection Method

**Algorithm:** Repeatedly halve interval where f changes sign.

**Theorem 2.16:** If f ∈ C[a,b] and f(a)f(b) < 0:
- Error bound: |pₖ - p| ≤ (b-a)/2ᵏ⁺¹
- Steps needed for tolerance ε: k ≥ log₂((b-a)/ε) - 1

**Characteristics:**
- Guaranteed convergence
- Linear convergence rate
- Does not use function shape information

### 2.4 Method of False Position (Regula Falsi)

**Algorithm:** Use secant line intersection with x-axis instead of midpoint:
$$p_k = a_k - f(a_k) \frac{a_k - b_k}{f(a_k) - f(b_k)}$$

**Theorem 2.19:** For convex/concave functions, method converges to unique root.

**Characteristics:**
- Faster than bisection for well-behaved functions
- Can be slower if interval is poorly chosen
- Maintains bracketing (guaranteed convergence)

### 2.5 Newton's Method

**Iteration Formula:**
$$p_{k+1} = p_k - \frac{f(p_k)}{f'(p_k)}$$

**Geometric Interpretation:** x-intercept of tangent line at pₖ.

**Theorem 2.23:** If f ∈ C²[a,b], f(p)=0, and f'(p)≠0, then Newton's method converges locally to p.

**Characteristics:**
- Quadratic convergence for simple roots
- Requires derivative computation
- May diverge if p₀ is far from root
- Fails if f'(pₖ) = 0

### 2.6 Secant Method

**Iteration Formula:**
$$p_{k+1} = p_k - \frac{p_k - p_{k-1}}{f(p_k) - f(p_{k-1})} f(p_k)$$

**Characteristics:**
- Two-step iteration (needs p₀ and p₁)
- Does not require derivative
- Order of convergence: α = (1+√5)/2 ≈ 1.618 (superlinear)
- Slower than Newton but avoids derivative computation

### 2.7 Order of Convergence

**Definition:** Sequence pₖ → p has order α if:
$$|p_{k+1} - p| \leq c|p_k - p|^\alpha$$

**Convergence Types:**
| Order α | Name | Error Reduction |
|---------|------|-----------------|
| 1 | Linear | |eₖ₊₁| ≤ c|eₖ| |
| 2 | Quadratic | |eₖ₊₁| ≤ c|eₖ|² |
| 1.618 | Superlinear (Secant) | Golden ratio |

**Asymptotic Error Constant:**
$$\lambda = \lim_{k\to\infty} \frac{|p_{k+1} - p|}{|p_k - p|^\alpha}$$

**Theorem 2.32:** For fixed-point iteration pₖ₊₁ = g(pₖ):
- If |g'(p)| < 1: linear convergence
- If g'(p) = g''(p) = ... = g⁽ᵐ⁻¹⁾(p) = 0: order m convergence

**Theorem 2.34 (Newton's Method):**
- Simple root (f'(p)≠0): quadratic convergence
- Multiple root (multiplicity m>1): linear convergence with rate (1-1/m)

**Modified Newton for Multiple Roots:**
$$p_{k+1} = p_k - m\frac{f(p_k)}{f'(p_k)}$$

or using μ(x) = f(x)/f'(x):
$$p_{k+1} = p_k - \frac{f(p_k)f'(p_k)}{(f'(p_k))^2 - f(p_k)f''(p_k)}$$

### 2.8 Stopping Criteria

**Common Criteria:**
1. **Absolute error:** |pₖ - pₖ₋₁| < TOL
2. **Relative error:** |pₖ - pₖ₋₁|/|pₖ| < TOL
3. **Function value:** |f(pₖ)| < TOL
4. **Maximum iterations:** k < MAXIT

**Best Practice:** Use combination of criteria for robust termination.

### 2.9-2.10 Vector and Matrix Norms

**Vector Norm Properties:**
1. ‖x‖ ≥ 0, ‖x‖ = 0 ⇔ x = 0
2. ‖αx‖ = |α|‖x‖
3. ‖x + y‖ ≤ ‖x‖ + ‖y‖ (triangle inequality)

**Common Vector Norms:**
- **1-norm:** ‖x‖₁ = Σ|xᵢ|
- **2-norm (Euclidean):** ‖x‖₂ = √(Σxᵢ²)
- **∞-norm:** ‖x‖∞ = max|xᵢ|

**Matrix Norms:**
- **Induced norm:** ‖A‖ = max_{‖x‖=1} ‖Ax‖
- **1-norm:** ‖A‖₁ = max column sum
- **∞-norm:** ‖A‖∞ = max row sum
- **Frobenius norm:** ‖A‖F = √(Σaᵢⱼ²)

**Convergence:** Vector sequence x⁽ᵏ⁾ → x iff each component converges.

### 2.11 Fixed-Point Iteration in n-dimensions

**Definition:** For g: E ⊂ ℝⁿ → ℝⁿ, iteration p⁽ᵏ⁺¹⁾ = g(p⁽ᵏ⁾).

**Contraction:** ‖g(x) - g(y)‖ ≤ c‖x - y‖ with 0 ≤ c < 1.

**Theorem 2.52 (Fixed-Point Theorem):** If g: E → E is a contraction on closed set E:
- Unique fixed point p exists
- Iteration converges for all p⁽⁰⁾ ∈ E
- Order of convergence is (at least) linear

**Theorem 2.53:** If ‖g'(p)‖ < 1, iteration converges locally to p.

**Theorem 2.55:** If g'(p) = 0, convergence is locally quadratic.

### 2.12 Newton's Method in n-dimensions

**Iteration Formula:**
$$p^{(k+1)} = p^{(k)} - [f'(p^{(k)})]^{-1} f(p^{(k)})$$

where f'(p) is the Jacobian matrix.

**Practical Implementation:** Solve linear system:
$$f'(p^{(k)})s^{(k)} = -f(p^{(k)})$$
$$p^{(k+1)} = p^{(k)} + s^{(k)}$$

**Theorem 2.56:** If f ∈ C², f(p)=0, and f'(p) invertible:
- Locally quadratically convergent

### 2.13 Quasi-Newton Methods (Broyden's Method)

**Motivation:** Avoid expensive Jacobian computation/inversion.

**General Form:**
$$p^{(k+1)} = p^{(k)} - [A^{(k)}]^{-1} f(p^{(k)})$$

where A⁽ᵏ⁾ approximates f'(p⁽ᵏ⁾).

**Broyden's Update:**
$$A^{(k+1)} = A^{(k)} + \frac{(y^{(k)} - A^{(k)}s^{(k)})(s^{(k)})^T}{\|s^{(k)}\|_2^2}$$

where y⁽ᵏ⁾ = f(p⁽ᵏ⁺¹⁾) - f(p⁽ᵏ⁾) and s⁽ᵏ⁾ = p⁽ᵏ⁺¹⁾ - p⁽ᵏ⁾.

**Sherman-Morrison-Woodbury Formula:** Efficient inverse update:
$$(A + uv^T)^{-1} = A^{-1} - \frac{A^{-1}uv^T A^{-1}}{1 + v^T A^{-1}u}$$

**Characteristics:**
- Superlinear convergence
- O(n²) operations per step vs O(n³) for Newton
- Does not require Jacobian computation

---

## Method Comparison

| Method | Order | Derivative | Bracketing | Guaranteed |
|--------|-------|------------|------------|------------|
| Bisection | 1 (linear) | No | Yes | Yes |
| False Position | 1 (linear) | No | Yes | Yes |
| Newton | 2 (quadratic) | Yes | No | No |
| Secant | 1.618 (superlinear) | No | No | No |
| Broyden (n-D) | Superlinear | No | No | No |
| Newton (n-D) | 2 (quadratic) | Yes | No | No |

---

## Key Takeaways

1. **Bisection** is reliable but slow; use when guaranteed convergence is needed
2. **Newton's method** is fastest for simple roots but requires derivatives
3. **Secant method** is good compromise when derivatives are unavailable
4. **Multiple roots** reduce Newton's convergence to linear
5. **Fixed-point iteration** converges if |g'(x)| < 1 near the fixed point
6. **Vector norms** are essential for analyzing n-dimensional convergence
7. **Broyden's method** provides efficient n-dimensional root-finding without Jacobian
