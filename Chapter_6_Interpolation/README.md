# Chapter 6: Interpolation

## Summary

This chapter covers interpolation methods for approximating functions from discrete data points, including Lagrange interpolation, Newton's divided differences, Hermite interpolation, and spline interpolation.

### 6.1 Lagrange Interpolation

**Problem:** Given mesh points x₀, x₁, ..., xₙ and values y₀, y₁, ..., yₙ, find a polynomial Lₙ(x) of degree at most n such that:
$$L_n(x_i) = y_i, \quad i = 0, 1, \ldots, n$$

**Lagrange Basis Polynomials:**
$$l_k(x) = \frac{(x-x_0)\cdots(x-x_{k-1})(x-x_{k+1})\cdots(x-x_n)}{(x_k-x_0)\cdots(x_k-x_{k-1})(x_k-x_{k+1})\cdots(x_k-x_n)}$$

**Properties:**
$$l_k(x_i) = \begin{cases} 1, & k = i \\ 0, & k \neq i \end{cases}$$

**Lagrange Interpolating Polynomial:**
$$L_n(x) = \sum_{k=0}^n y_k l_k(x)$$

**Theorem 6.1:** The Lagrange interpolation problem has a **unique solution**.

---

### Error Formula

**Theorem 6.5:** If f ∈ Cⁿ⁺¹[a,b] and Lₙ(x) interpolates f at x₀, ..., xₙ, then for any x ∈ [a,b]:
$$f(x) = L_n(x) + \frac{f^{(n+1)}(\xi)}{(n+1)!}(x-x_0)(x-x_1)\cdots(x-x_n)$$

where ξ ∈ ⟨x, x₀, ..., xₙ⟩.

**Error Bound:**
$$|f(x) - L_n(x)| \leq \frac{M_{n+1}}{(n+1)!}|(x-x_0)\cdots(x-x_n)|$$

where M_{n+1} = max|f⁽ⁿ⁺¹⁾(t)| on [a,b].

**For Equidistant Points (Theorem 6.6):** With h = (b-a)/n:
$$|f(x) - L_n(x)| \leq \frac{M_{n+1}}{4(n+1)}\left(\frac{b-a}{n}\right)^{n+1}$$

---

### Bivariate Lagrange Interpolation

For f: [a,b] × [c,d] → ℝ with data zᵢⱼ = f(xᵢ, yⱼ):
$$L_{n,m}(x,y) = \sum_{i=0}^n \sum_{j=0}^m z_{ij} l_i(x) \tilde{l}_j(y)$$

where lᵢ and l̃ⱼ are Lagrange basis polynomials in x and y respectively.

---

### 6.2 Divided Differences

**Definitions:**
- **Zeroth:** f[x₀] = f(x₀)
- **First:** f[x₀, x₁] = (f(x₁) - f(x₀))/(x₁ - x₀)
- **nth:** f[x₀, ..., xₙ] = (f[x₁, ..., xₙ] - f[x₀, ..., xₙ₋₁])/(xₙ - x₀)

**Theorem 6.10 (Explicit Formula):**
$$f[x_0, \ldots, x_n] = \sum_{i=0}^n \frac{f(x_i)}{(x_i-x_0)\cdots(x_i-x_{i-1})(x_i-x_{i+1})\cdots(x_i-x_n)}$$

**Corollary 6.11:** Divided differences are **independent of the order** of mesh points.

**Divided Differences with Equal Points:**
$$f[x_0, x_0] := f'(x_0)$$

**Connection to Derivatives:**
$$f[\underbrace{x_0, \ldots, x_0}_{k+1}] = \frac{f^{(k)}(x_0)}{k!}$$

---

### 6.3 Newton's Divided Difference Formula

**Newton Form:**
$$L_n(x) = f[x_0] + f[x_0,x_1](x-x_0) + f[x_0,x_1,x_2](x-x_0)(x-x_1) + \cdots + f[x_0,\ldots,x_n](x-x_0)\cdots(x-x_{n-1})$$

**Advantage over Lagrange:** Easy to add new points without recomputing everything.

**Divided Difference Table:**
```
x₀   y₀
          f[x₀,x₁]
x₁   y₁            f[x₀,x₁,x₂]
          f[x₁,x₂]            f[x₀,x₁,x₂,x₃]
x₂   y₂            f[x₁,x₂,x₃]
          f[x₂,x₃]
x₃   y₃
```

---

### 6.4 Hermite Interpolation

**Problem:** Interpolate both function values AND derivative values.

**Given:** x₀, ..., xₙ with yᵢ = f(xᵢ) and y'ᵢ = f'(xᵢ)

**Hermite Polynomial:** Degree at most 2n+1 satisfying:
$$H_{2n+1}(x_i) = y_i, \quad H'_{2n+1}(x_i) = y'_i$$

**Newton Form with Repeated Points:**
$$H_{2n+1}(x) = f[z_0] + f[z_0,z_1](x-z_0) + \cdots + f[z_0,\ldots,z_{2n+1}](x-z_0)\cdots(x-z_{2n})$$

where z₂ᵢ = z₂ᵢ₊₁ = xᵢ (each point repeated twice).

**Divided Difference Table for Hermite:**
```
x₀   y₀
          f'(x₀)
x₀   y₀            f[x₀,x₀,x₁]
          f[x₀,x₁]
x₁   y₁            f[x₀,x₁,x₁]
          f'(x₁)
x₁   y₁
```

---

### 6.5 Spline Interpolation

**Definition:** A **spline of degree k** on mesh a = x₀ < x₁ < ... < xₙ = b is a function S such that:
1. S ∈ Cᵏ⁻¹[a,b] (k-1 times continuously differentiable)
2. On each [xᵢ, xᵢ₊₁], S is a polynomial of degree ≤ k

**Types:**
- **Linear spline** (k=1): Piecewise linear, C⁰
- **Quadratic spline** (k=2): C¹ continuous
- **Cubic spline** (k=3): C² continuous (most common)

---

### Cubic Spline Interpolation

**Given:** x₀, ..., xₙ and y₀, ..., yₙ

**Find:** Cubic spline S(x) with S(xᵢ) = yᵢ

**On each interval [xᵢ, xᵢ₊₁]:**
$$S_i(x) = a_i + b_i(x-x_i) + c_i(x-x_i)^2 + d_i(x-x_i)^3$$

**Conditions:**
1. Sᵢ(xᵢ) = yᵢ, Sᵢ(xᵢ₊₁) = yᵢ₊₁ (interpolation)
2. S'ᵢ(xᵢ₊₁) = S'ᵢ₊₁(xᵢ₊₁) (C¹ continuity)
3. S''ᵢ(xᵢ₊₁) = S''ᵢ₊₁(xᵢ₊₁) (C² continuity)

**Total:** 4n parameters, 4n-2 conditions → need 2 more conditions

---

### Boundary Conditions

**Natural Spline:**
$$S''_0(x_0) = 0, \quad S''_{n-1}(x_n) = 0$$

**Clamped Spline:**
$$S'(x_0) = y'_0, \quad S'(x_n) = y'_n$$

---

### Solving for Coefficients

Let Δxᵢ = xᵢ₊₁ - xᵢ, Δyᵢ = yᵢ₊₁ - yᵢ

**For natural spline, solve tridiagonal system for cᵢ:**
$$\begin{pmatrix}
1 & 0 & 0 & \cdots & 0 \\
\Delta x_0 & 2(\Delta x_0 + \Delta x_1) & \Delta x_1 & \cdots & 0 \\
0 & \Delta x_1 & 2(\Delta x_1 + \Delta x_2) & \cdots & 0 \\
\vdots & \vdots & \ddots & \ddots & \vdots \\
0 & 0 & \cdots & 0 & 1
\end{pmatrix}
\begin{pmatrix} c_0 \\ c_1 \\ \vdots \\ c_n \end{pmatrix}
=
\begin{pmatrix} 0 \\ 3(\frac{\Delta y_1}{\Delta x_1} - \frac{\Delta y_0}{\Delta x_0}) \\ \vdots \\ 0 \end{pmatrix}$$

**Then compute:**
$$d_i = \frac{c_{i+1} - c_i}{3\Delta x_i}, \quad b_i = \frac{\Delta y_i}{\Delta x_i} - \frac{2c_i + c_{i+1}}{3}\Delta x_i$$

**Theorem 6.22:** Natural cubic spline interpolation has a **unique solution** (matrix is diagonally dominant).

---

### Error Bounds (Theorem 6.25)

For clamped cubic spline with f ∈ C⁴[a,b]:
$$|f(x) - S(x)| \leq \frac{5}{384}M_4 h^4$$
$$|f'(x) - S'(x)| \leq \left(\frac{3}{216} + \frac{1}{24}\right)M_4 h^3$$
$$|f''(x) - S''(x)| \leq \left(\frac{1}{12} + \frac{1}{3}\right)M_4 h^2$$

where M₄ = max|f⁽⁴⁾(x)|, h = max(Δxᵢ)

---

### Minimal Property (Theorem 6.24)

Natural cubic spline minimizes curvature:
$$\int_a^b (S''(x))^2 dx \leq \int_a^b (f''(x))^2 dx$$

for any f ∈ C²[a,b] that interpolates the same data.

**Interpretation:** Natural spline is the "smoothest" interpolant.

---

## Key Takeaways

1. **Lagrange interpolation** gives unique polynomial but hard to update
2. **Newton's form** using divided differences is computationally efficient
3. **Error grows with n** for equidistant points (Runge phenomenon)
4. **Hermite interpolation** matches both function and derivative values
5. **Cubic splines** provide smooth (C²) interpolation
6. **Natural spline** has zero second derivative at endpoints
7. **Clamped spline** specifies endpoint slopes
8. Splines minimize curvature among all C² interpolants
