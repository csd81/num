# Chapter 9: Method of Least Squares

## Summary

This chapter covers curve fitting using the method of least squares, including line fitting, polynomial fitting, and special nonlinear functions using linearization techniques.

### Introduction: The Least Squares Problem

**Problem:** Given data points (xᵢ, yᵢ), i = 0, 1, ..., n, find parameters **a** that minimize the error between model g(x; **a**) and measurements.

**Error Measures:**
- **Maximum error:** F₁(**a**) = maxᵢ|g(xᵢ; **a**) - yᵢ| (not differentiable)
- **Sum of absolute errors:** F₂(**a**) = Σᵢ|g(xᵢ; **a**) - yᵢ| (not differentiable)
- **Least squares error:** F(**a**) = Σᵢ(g(xᵢ; **a**) - yᵢ)² (differentiable!)

**Advantage of least squares:**
- Differentiable → can use calculus to find minimum
- Leads to linear systems for many models
- Statistically optimal for Gaussian noise

---

### 9.1 Line Fitting

**Model:** g(x) = ax + b

**Least squares error:**
$$F(a, b) = \sum_{i=0}^n (ax_i + b - y_i)^2$$

**Normal Equations** (set ∂F/∂a = 0, ∂F/∂b = 0):
$$\begin{pmatrix} \sum x_i^2 & \sum x_i \\ \sum x_i & n+1 \end{pmatrix} \begin{pmatrix} a \\ b \end{pmatrix} = \begin{pmatrix} \sum x_i y_i \\ \sum y_i \end{pmatrix}$$

**Solution:**
$$\bar{a} = \frac{(n+1)\sum x_i y_i - (\sum x_i)(\sum y_i)}{(n+1)\sum x_i^2 - (\sum x_i)^2}$$

$$\bar{b} = \frac{(\sum x_i^2)(\sum y_i) - (\sum x_i y_i)(\sum x_i)}{(n+1)\sum x_i^2 - (\sum x_i)^2}$$

**Determinant:**
$$d = (n+1)\sum x_i^2 - (\sum x_i)^2 > 0$$

if at least two xᵢ are distinct (by Cauchy-Schwarz inequality).

---

### 9.2 Polynomial Curve Fitting

**Model:** g(x) = aₘxᵐ + aₘ₋₁xᵐ⁻¹ + ... + a₁x + a₀ (degree m < n)

**Least squares error:**
$$F(a_m, \ldots, a_0) = \sum_{i=0}^n (a_m x_i^m + \cdots + a_1 x_i + a_0 - y_i)^2$$

**Normal Equations (m+1 equations):**
$$\begin{pmatrix}
\sum x_i^{2m} & \sum x_i^{2m-1} & \cdots & \sum x_i^m \\
\sum x_i^{2m-1} & \sum x_i^{2m-2} & \cdots & \sum x_i^{m-1} \\
\vdots & \vdots & \ddots & \vdots \\
\sum x_i^m & \sum x_i^{m-1} & \cdots & n+1
\end{pmatrix}
\begin{pmatrix} a_m \\ a_{m-1} \\ \vdots \\ a_0 \end{pmatrix}
=
\begin{pmatrix} \sum x_i^m y_i \\ \sum x_i^{m-1} y_i \\ \vdots \\ \sum y_i \end{pmatrix}$$

**Theorem 9.3:** If there are at least m+1 distinct mesh points, the normal equations have a **unique solution**.

**Proof:** The coefficient matrix A is **positive definite**:
$$\mathbf{z}^T A \mathbf{z} = \sum_{i=0}^n \left(\sum_{j=1}^{m+1} z_j x_i^{m+1-j}\right)^2 \geq 0$$

Equals zero only if z = 0 (polynomial with m+1 roots must be identically zero).

**Example - Parabola (m=2):**
$$\begin{pmatrix}
\sum x_i^4 & \sum x_i^3 & \sum x_i^2 \\
\sum x_i^3 & \sum x_i^2 & \sum x_i \\
\sum x_i^2 & \sum x_i & n+1
\end{pmatrix}
\begin{pmatrix} a \\ b \\ c \end{pmatrix}
=
\begin{pmatrix} \sum x_i^2 y_i \\ \sum x_i y_i \\ \sum y_i \end{pmatrix}$$

---

### 9.3 Special Nonlinear Curve Fitting

#### Exponential Function: y = beᵃˣ

**Nonlinear least squares:**
$$F(a, b) = \sum_{i=0}^n (be^{ax_i} - y_i)^2$$

**Normal equations are nonlinear:**
$$2\sum (be^{ax_i} - y_i)be^{ax_i}x_i = 0$$
$$2\sum (be^{ax_i} - y_i)e^{ax_i} = 0$$

**Linearization method:**

Take natural log: ln y = ln b + ax

Let Y = ln y, X = x, A = a, B = ln b

**Linear model:** Y = AX + B

1. Transform data: (xᵢ, ln yᵢ)
2. Fit line using linear least squares → get Ā, B̄
3. Transform back: ā = Ā, b̄ = eᴮ̄

**Note:** This minimizes Σ(ln yᵢ - (axᵢ + ln b))², NOT the original Σ(yᵢ - beᵃˣ)²

---

#### Power Function: y = bxᵃ

**Linearization:**

Take natural log: ln y = a ln x + ln b

Let Y = ln y, X = ln x, A = a, B = ln b

**Linear model:** Y = AX + B

1. Transform data: (ln xᵢ, ln yᵢ)
2. Fit line → get Ā, B̄
3. Transform back: ā = Ā, b̄ = eᴮ̄

---

#### Other Linearizable Models

| Model | Linearization | Transformation |
|-------|---------------|----------------|
| y = beᵃˣ | ln y = ax + ln b | Y = ln y, X = x |
| y = bxᵃ | ln y = a ln x + ln b | Y = ln y, X = ln x |
| y = a + b/x | y = a + bX | X = 1/x |
| y = x/(ax + b) | 1/y = a + b/x | Y = 1/y, X = 1/x |
| y = 1/(a + bx) | 1/y = a + bx | Y = 1/y |

---

### Computational Considerations

**For polynomial fitting:**
- Normal equations can be ill-conditioned for high degree
- Use orthogonal polynomials (Legendre, Chebyshev) for better stability
- Or use QR factorization instead of normal equations

**For nonlinear fitting:**
- Linearization gives approximate solution
- Use as initial guess for iterative nonlinear optimization
- Newton's method or Gauss-Newton method for exact solution

---

### Error Analysis

**Residual:** rᵢ = g(xᵢ; **ā**) - yᵢ

**Sum of squared residuals:** SSR = Σᵢ rᵢ²

**Root mean square error:** RMSE = √(SSR/(n+1))

**Coefficient of determination:**
$$R^2 = 1 - \frac{\sum (y_i - \hat{y}_i)^2}{\sum (y_i - \bar{y})^2}$$

where ȳ is the mean of yᵢ and ŷᵢ = g(xᵢ; **ā**)

R² close to 1 indicates good fit.

---

## Key Takeaways

1. **Least squares** minimizes sum of squared residuals (differentiable!)
2. **Normal equations** are linear for models linear in parameters
3. **Line fitting** gives closed-form solution via 2×2 system
4. **Polynomial fitting** requires (m+1)×(m+1) system for degree m
5. **Coefficient matrix is positive definite** → unique solution exists
6. **Nonlinear models** can often be linearized (exponential, power)
7. **Linearization** gives approximate solution, not exact least squares
8. For exact nonlinear least squares, use iterative numerical methods
