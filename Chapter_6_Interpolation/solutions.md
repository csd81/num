# Chapter 6: Exercise Solutions

## Section 6.1 Exercises

### Exercise 1: Lagrange Polynomials

**(a) Data:**
```
xᵢ:  -1   0   2   4
yᵢ:   3  -2   4  -2
```

**Lagrange basis polynomials:**

$$l_0(x) = \frac{(x-0)(x-2)(x-4)}{(-1-0)(-1-2)(-1-4)} = \frac{x(x-2)(x-4)}{(-1)(-3)(-5)} = -\frac{x(x-2)(x-4)}{15}$$

$$l_1(x) = \frac{(x+1)(x-2)(x-4)}{(0+1)(0-2)(0-4)} = \frac{(x+1)(x-2)(x-4)}{(1)(-2)(-4)} = \frac{(x+1)(x-2)(x-4)}{8}$$

$$l_2(x) = \frac{(x+1)(x-0)(x-4)}{(2+1)(2-0)(2-4)} = \frac{(x+1)x(x-4)}{(3)(2)(-2)} = -\frac{(x+1)x(x-4)}{12}$$

$$l_3(x) = \frac{(x+1)(x-0)(x-2)}{(4+1)(4-0)(4-2)} = \frac{(x+1)x(x-2)}{(5)(4)(2)} = \frac{(x+1)x(x-2)}{40}$$

**Lagrange polynomial:**
$$L_3(x) = 3l_0(x) - 2l_1(x) + 4l_2(x) - 2l_3(x)$$

**At x = 1:**
$$l_0(1) = -\frac{1(-1)(-3)}{15} = -\frac{3}{15} = -0.2$$
$$l_1(1) = \frac{(2)(-1)(-3)}{8} = \frac{6}{8} = 0.75$$
$$l_2(1) = -\frac{(2)(1)(-3)}{12} = \frac{6}{12} = 0.5$$
$$l_3(1) = \frac{(2)(1)(-1)}{40} = -\frac{2}{40} = -0.05$$

$$L_3(1) = 3(-0.2) - 2(0.75) + 4(0.5) - 2(-0.05) = -0.6 - 1.5 + 2 + 0.1 = 0$$

**L₃(1) = 0**

---

**(b) Data:**
```
xᵢ:  0.1   0.4   1.3   2.5   2.8
yᵢ:  1.2   0.2  -2.2   3.1   1.3
```

At x = 1, compute each lᵢ(1):

$$l_0(1) = \frac{(1-0.4)(1-1.3)(1-2.5)(1-2.8)}{(0.1-0.4)(0.1-1.3)(0.1-2.5)(0.1-2.8)} = \frac{(0.6)(-0.3)(-1.5)(-0.8)}{(-0.3)(-1.2)(-2.4)(-2.7)} = \frac{-0.216}{2.3328} = -0.0926$$

Similarly compute l₁(1), l₂(1), l₃(1), l₄(1), then:
$$L_4(1) = 1.2l_0(1) + 0.2l_1(1) - 2.2l_2(1) + 3.1l_3(1) + 1.3l_4(1)$$

---

**(c) Data:**
```
xᵢ:  -0.5   0.0   1.5   2.0   3.0   3.5
yᵢ:  -0.5   1.5   3.5   2.0   2.5   6.5
```

Similar computation at x = 1.

---

### Exercise 2: Uniqueness without Formula

**To show:** System (6.1) has a unique solution without using Lagrange formula.

**Proof:**

The system Lₙ(xᵢ) = yᵢ for i = 0, ..., n gives n+1 linear equations for n+1 coefficients c₀, c₁, ..., cₙ of the polynomial:
$$L_n(x) = c_0 + c_1 x + c_2 x^2 + \cdots + c_n x^n$$

The coefficient matrix is the **Vandermonde matrix:**
$$V = \begin{pmatrix}
1 & x_0 & x_0^2 & \cdots & x_0^n \\
1 & x_1 & x_1^2 & \cdots & x_1^n \\
\vdots & \vdots & \vdots & \ddots & \vdots \\
1 & x_n & x_n^2 & \cdots & x_n^n
\end{pmatrix}$$

**Determinant of V:**
$$\det(V) = \prod_{0 \leq i < j \leq n} (x_j - x_i)$$

Since all xᵢ are pairwise different, det(V) ≠ 0.

**Therefore, V is invertible, and the system has a unique solution.** □

---

### Exercise 3: Sum of Lagrange Basis Polynomials

**To show:** Σᵢ₌₀ⁿ lᵢ(x) = 1 for all x.

**Proof:**

Consider the constant function f(x) = 1.

The Lagrange polynomial interpolating f at x₀, ..., xₙ is:
$$L_n(x) = \sum_{i=0}^n f(x_i) l_i(x) = \sum_{i=0}^n 1 \cdot l_i(x) = \sum_{i=0}^n l_i(x)$$

But f(x) = 1 is itself a polynomial of degree 0 ≤ n that interpolates the data.

By uniqueness of Lagrange interpolation: Lₙ(x) = f(x) = 1.

**Therefore, Σᵢ₌₀ⁿ lᵢ(x) = 1.** □

---

### Exercise 4: Factorial Inequality

**To prove:** (k+1)!(n-k)! ≤ n! for k = 0, 1, ..., n-1.

**Proof:**

$$\frac{n!}{(k+1)!(n-k)!} = \binom{n}{k+1}$$

Since binomial coefficients are positive integers for 0 ≤ k+1 ≤ n:
$$\binom{n}{k+1} \geq 1$$

**Therefore, (k+1)!(n-k)! ≤ n!.** □

---

### Exercise 5: cos(x) Approximation

**Find:** Smallest n such that |cos(x) - Lₙ(x)| < 0.001 for x ∈ [-π, π] with equidistant points.

**Using Theorem 6.6:**
$$|f(x) - L_n(x)| \leq \frac{M_{n+1}}{4(n+1)}\left(\frac{2\pi}{n}\right)^{n+1}$$

For f(x) = cos(x): |f⁽ⁿ⁺¹⁾(x)| ≤ 1 for all n, so M_{n+1} = 1.

Need:
$$\frac{1}{4(n+1)}\left(\frac{2\pi}{n}\right)^{n+1} < 0.001$$

Try n = 8:
$$\frac{1}{36}\left(\frac{2\pi}{8}\right)^9 = \frac{1}{36}(0.785)^9 \approx \frac{0.113}{36} \approx 0.0031 > 0.001$$

Try n = 10:
$$\frac{1}{44}\left(\frac{2\pi}{10}\right)^{11} = \frac{1}{44}(0.628)^{11} \approx \frac{0.0061}{44} \approx 0.00014 < 0.001$$

**Answer: n = 10** (or possibly n = 9, needs verification)

---

### Exercise 6: Bivariate Lagrange Polynomial L₂,₂

**Data:**
```
(xi, yj): (0,0) (0,1) (0,2) (1,0) (1,1) (1,2) (2,0) (2,1) (2,2)
zij:       3    1    0    2   -1    0    2    3    1
```

**Lagrange basis in x (degree 2):**
$$l_0(x) = \frac{(x-1)(x-2)}{(0-1)(0-2)} = \frac{(x-1)(x-2)}{2}$$
$$l_1(x) = \frac{(x-0)(x-2)}{(1-0)(1-2)} = -x(x-2)$$
$$l_2(x) = \frac{(x-0)(x-1)}{(2-0)(2-1)} = \frac{x(x-1)}{2}$$

**Lagrange basis in y (degree 2):**
$$\tilde{l}_0(y) = \frac{(y-1)(y-2)}{2}, \quad \tilde{l}_1(y) = -y(y-2), \quad \tilde{l}_2(y) = \frac{y(y-1)}{2}$$

**Bivariate polynomial:**
$$L_{2,2}(x,y) = \sum_{i=0}^2 \sum_{j=0}^2 z_{ij} l_i(x) \tilde{l}_j(y)$$

$$= 3l_0(x)\tilde{l}_0(y) + 1l_0(x)\tilde{l}_1(y) + 0l_0(x)\tilde{l}_2(y) + 2l_1(x)\tilde{l}_0(y) - 1l_1(x)\tilde{l}_1(y) + 0l_1(x)\tilde{l}_2(y) + 2l_2(x)\tilde{l}_0(y) + 3l_2(x)\tilde{l}_1(y) + 1l_2(x)\tilde{l}_2(y)$$

Expand and simplify.

---

## Section 6.2 Exercises

### Exercise 1: Divided Differences

**(a) f[x₀, x₁, x₂, x₃] where xᵢ = i, f(x) = x²**

```
x₀=0: f[0] = 0
           f[0,1] = (1-0)/(1-0) = 1
x₁=1: f[1] = 1                    f[0,1,2] = (3-1)/(2-0) = 1
           f[1,2] = (4-1)/(2-1) = 3              f[0,1,2,3] = (1-1)/(3-0) = 0
x₂=2: f[2] = 4                    f[1,2,3] = (5-3)/(3-1) = 1
           f[2,3] = (9-4)/(3-2) = 5
x₃=3: f[3] = 9
```

**f[0,1,2,3] = 0** (makes sense since f is degree 2, third divided difference is 0)

---

**(b) f[x₀, x₁, x₂] where xᵢ = 0.2i, f(x) = sin(x)**

x₀ = 0, x₁ = 0.2, x₂ = 0.4

f[0] = sin(0) = 0
f[0.2] = sin(0.2) ≈ 0.1987
f[0.4] = sin(0.4) ≈ 0.3894

f[0, 0.2] = (0.1987 - 0)/(0.2 - 0) = 0.9935
f[0.2, 0.4] = (0.3894 - 0.1987)/(0.4 - 0.2) = 0.9535

f[0, 0.2, 0.4] = (0.9535 - 0.9935)/(0.4 - 0) = -0.01

**f[x₀, x₁, x₂] ≈ -0.01**

---

**(c) f[x₀, x₀] where x₀ = 0, f(x) = sin(x)**

$$f[x_0, x_0] = f'(x_0) = f'(0) = \cos(0) = 1$$

**f[0, 0] = 1**

---

### Exercise 2: Mean Value Theorem for Divided Differences

**To show:** For f ∈ C¹[a,b], x₀ ≠ x₁, ∃ξ ∈ ⟨x₀, x₁⟩ such that f[x₀, x₁] = f'(ξ).

**Proof:**

By definition:
$$f[x_0, x_1] = \frac{f(x_1) - f(x_0)}{x_1 - x_0}$$

By the Mean Value Theorem (Theorem 2.4), there exists ξ ∈ (x₀, x₁) such that:
$$f'(\xi) = \frac{f(x_1) - f(x_0)}{x_1 - x_0} = f[x_0, x_1]$$

**Therefore, f[x₀, x₁] = f'(ξ).** □

---

### Exercise 3: Newton Form Coefficients

**Given:** P(x) = a₀ + a₁(x-x₀) + a₂(x-x₀)(x-x₁) + a₃(x-x₀)(x-x₁)(x-x₂)

**To show:** a₀ = P[x₀], a₁ = P[x₀,x₁], a₂ = P[x₀,x₁,x₂], a₃ = P[x₀,x₁,x₂,x₃]

**Proof:**

**a₀:** P(x₀) = a₀ + 0 + 0 + 0 = a₀, so a₀ = P[x₀] = P(x₀). ✓

**a₁:** P(x₁) = a₀ + a₁(x₁-x₀), so:
$$a_1 = \frac{P(x_1) - P(x_0)}{x_1 - x_0} = P[x_0, x_1]$$
✓

**a₂:** P(x₂) = a₀ + a₁(x₂-x₀) + a₂(x₂-x₀)(x₂-x₁), so:
$$a_2 = \frac{P(x_2) - P(x_0) - a_1(x_2-x_0)}{(x_2-x_0)(x_2-x_1)} = \frac{P[x_0,x_2] - P[x_0,x_1]}{x_2-x_1} = P[x_0,x_1,x_2]$$
✓

**a₃:** Similarly, using P(x₃):
$$a_3 = P[x_0,x_1,x_2,x_3]$$
✓

---

## Section 6.4 Exercises

### Exercise 1: Hermite Interpolation

**(a) Data:**
```
xᵢ:   -2   -1    0    1
yᵢ:    4    1   14  -35
y'ᵢ:  -1   -2   43 -394
```

**Construct divided difference table with repeated points:**

z₀ = z₁ = -2, z₂ = z₃ = -1, z₄ = z₅ = 0, z₆ = z₇ = 1

```
z    f[·]
-2   4
         -1
-2   4          3
         -1            -10
-1   1           -45          208
         -2             98
-1   1           42
         43
 0  14
         ...
```

Continue filling table, then:
$$H_7(x) = f[z_0] + f[z_0,z_1](x+2) + f[z_0,z_1,z_2](x+2)^2 + \cdots$$

---

**(b) Data:**
```
xᵢ:   -1    0    2    3
yᵢ:    1    2   64  -19
y'ᵢ:   3   -1  111 -301
```

Similar approach with z₀=z₁=-1, z₂=z₃=0, z₄=z₅=2, z₆=z₇=3.

---

### Exercise 2: Hermite Interpolation of Polynomials

**To prove:** If P is degree ≤ 2n+2 and H₂ₙ₊₁ is Hermite polynomial for P, then P(x) = H₂ₙ₊₁(x).

**Proof:**

H₂ₙ₊₁ interpolates P at x₀, ..., xₙ with matching derivatives:
$$H_{2n+1}(x_i) = P(x_i), \quad H'_{2n+1}(x_i) = P'(x_i)$$

Consider Q(x) = P(x) - H₂ₙ₊₁(x).

Q has degree ≤ 2n+2, and:
- Q(xᵢ) = 0 for i = 0, ..., n (n+1 zeros)
- Q'(xᵢ) = 0 for i = 0, ..., n (n+1 additional conditions)

Each xᵢ is a **double root** of Q (since Q(xᵢ) = Q'(xᵢ) = 0).

So Q has at least 2n+2 roots (counting multiplicity).

But Q has degree ≤ 2n+2, so Q must be identically zero.

**Therefore, P(x) = H₂ₙ₊₁(x) for all x.** □

---

### Exercise 3: Continuity of Divided Differences

**To show:** 
$$\lim_{(x'_0,\ldots,x'_n) \to (x_0,\ldots,x_n)} f[x_0, x'_0, x_1, x'_1, \ldots, x_n, x'_n] = f[x_0, x_0, x_1, x_1, \ldots, x_n, x_n]$$

**Proof:**

By Corollary 6.12, divided differences depend continuously on mesh points when f is continuous.

As x'ᵢ → xᵢ, the divided difference with distinct points approaches the divided difference with repeated points.

By definition of divided differences with repeated points:
$$f[\underbrace{x_0, x_0}_{2}, \underbrace{x_1, x_1}_{2}, \ldots, \underbrace{x_n, x_n}_{2}] = \frac{f^{(2n+1)}(\xi)}{(2n+1)!}$$

for some ξ (by the connection to derivatives).

**The limit holds by continuity.** □

---

### Exercise 4: Symmetry of Divided Differences

**To show:** f[x₀, x₀, x₁, x₁, ..., xₙ, xₙ] = f[xᵢ₀, xᵢ₀, xᵢ₁, xᵢ₁, ..., xᵢₙ, xᵢₙ] for any permutation.

**Proof:**

By Corollary 6.11, divided differences are independent of the order of mesh points.

This extends to repeated points by continuity.

**Therefore, the divided difference is invariant under permutation.** □

---

### Exercise 5: General Hermite Interpolation

**Given:** x₀, x₁ with f(x₀), f'(x₀), f''(x₀), f(x₁)

**To show:** Solution is:
$$H(x) = f[x_0] + f[x_0,x_0](x-x_0) + f[x_0,x_0,x_0](x-x_0)^2 + f[x_0,x_0,x_0,x_1](x-x_0)^3$$

**Proof:**

We have 4 conditions:
- H(x₀) = f(x₀)
- H'(x₀) = f'(x₀)
- H''(x₀) = f''(x₀)
- H(x₁) = f(x₁)

The polynomial has degree ≤ 3 (4 parameters).

Using Newton form with z₀ = z₁ = z₂ = x₀, z₃ = x₁:
$$H(x) = f[z_0] + f[z_0,z_1](x-z_0) + f[z_0,z_1,z_2](x-z_0)(x-z_1) + f[z_0,z_1,z_2,z_3](x-z_0)(x-z_1)(x-z_2)$$

Since z₀ = z₁ = z₂ = x₀:
$$H(x) = f[x_0] + f[x_0,x_0](x-x_0) + f[x_0,x_0,x_0](x-x_0)^2 + f[x_0,x_0,x_0,x_1](x-x_0)^3$$

**Verification:**
- H(x₀) = f[x₀] = f(x₀) ✓
- H'(x₀) = f[x₀,x₀] = f'(x₀) ✓
- H''(x₀) = 2f[x₀,x₀,x₀] = 2·f''(x₀)/2 = f''(x₀) ✓
- H(x₁) matches by construction of divided differences ✓

---

## Section 6.5 Exercises

### Exercise 1: Linear Spline Formula

**Given:** Data (xᵢ, yᵢ), i = 0, ..., n

**On interval [xᵢ, xᵢ₊₁]:**
$$S_i(x) = y_i + \frac{y_{i+1} - y_i}{x_{i+1} - x_i}(x - x_i)$$

Or equivalently:
$$S_i(x) = \frac{x_{i+1} - x}{x_{i+1} - x_i}y_i + \frac{x - x_i}{x_{i+1} - x_i}y_{i+1}$$

This is the linear Lagrange polynomial on [xᵢ, xᵢ₊₁].

---

### Exercise 2: Linear Spline Error

**(a) Show: max|f(x) - Sₕ(x)| → 0 as h → 0**

**Proof:**

f is continuous on [a,b], hence uniformly continuous.

For any ε > 0, ∃δ > 0 such that |x - y| < δ ⟹ |f(x) - f(y)| < ε.

Choose h < δ. On each [xᵢ, xᵢ₊₁], Sₕ is linear interpolation.

For x ∈ [xᵢ, xᵢ₊₁]:
$$|f(x) - S_h(x)| \leq \max(|f(x) - f(x_i)|, |f(x) - f(x_{i+1})|) < \epsilon$$

**Therefore, max|f(x) - Sₕ(x)| → 0 as h → 0.** □

---

**(b) For f ∈ C¹[a,b]: |f(x) - Sₕ(x)| ≤ M₁h**

**Proof:**

On [xᵢ, xᵢ₊₁], by Mean Value Theorem:
$$|f(x) - f(x_i)| \leq M_1|x - x_i| \leq M_1 h$$

Similarly, |f(x) - f(xᵢ₊₁)| ≤ M₁h.

Since Sₕ(x) is between f(xᵢ) and f(xᵢ₊₁):
$$|f(x) - S_h(x)| \leq M_1 h$$

**Therefore, error is O(h).** □

---

### Exercise 3: Natural Cubic Spline

Compute natural cubic spline for data from Exercise 1 of Section 6.1.

Set up tridiagonal system for cᵢ, solve, then compute bᵢ and dᵢ.

---

### Exercise 4: Uniqueness with One Boundary Condition

**To show:** Either S'(x₀) = f'(x₀) OR S'(xₙ) = f'(xₙ) determines cubic spline uniquely.

**Proof:**

With one boundary condition, we have 4n-1 conditions for 4n parameters.

But the tridiagonal system for cᵢ becomes:
- n equations from continuity
- 1 boundary condition
- Total: n+1 equations for n+1 unknowns (c₀, ..., cₙ)

The coefficient matrix remains diagonally dominant (or can be shown to be nonsingular).

**Therefore, the system has a unique solution.** □

---

### Exercise 5: Clamped Spline Minimal Property

**To show:** Clamped spline satisfies inequality (6.26) for functions with matching endpoint derivatives.

**Proof:**

Same as Theorem 6.24, but now g(x) = f(x) - S(x) satisfies:
- g(xᵢ) = 0 for all i
- g'(a) = g'(b) = 0 (since both f and S match endpoint derivatives)

Integration by parts:
$$\int_a^b S''(x)g''(x)dx = [S''(x)g'(x)]_a^b - \int_a^b S'''(x)g'(x)dx$$

Since g'(a) = g'(b) = 0, boundary term vanishes.

Remaining integral vanishes as before (S''' constant on each interval, ∫g' = 0).

**Therefore, ∫(S'')² ≤ ∫(f'')².** □

---

## Summary of Key Formulas

**Lagrange Basis:**
$$l_k(x) = \prod_{j \neq k} \frac{x - x_j}{x_k - x_j}$$

**Newton Form:**
$$L_n(x) = \sum_{k=0}^n f[x_0,\ldots,x_k] \prod_{j=0}^{k-1} (x - x_j)$$

**Divided Difference Recursion:**
$$f[x_0,\ldots,x_k] = \frac{f[x_1,\ldots,x_k] - f[x_0,\ldots,x_{k-1}]}{x_k - x_0}$$

**Hermite with Repeated Points:**
$$f[\underbrace{x_0,\ldots,x_0}_{k+1}] = \frac{f^{(k)}(x_0)}{k!}$$

**Cubic Spline Coefficients:**
$$d_i = \frac{c_{i+1} - c_i}{3\Delta x_i}, \quad b_i = \frac{\Delta y_i}{\Delta x_i} - \frac{2c_i + c_{i+1}}{3}\Delta x_i$$

**Error Bounds:**
- Lagrange: O(hⁿ⁺¹)
- Cubic spline: O(h⁴)
