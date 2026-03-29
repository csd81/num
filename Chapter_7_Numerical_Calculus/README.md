# Chapter 7: Numerical Differentiation and Integration

## Summary

This chapter covers numerical methods for computing derivatives and definite integrals, including finite difference formulas, Richardson extrapolation, Newton-Cotes formulas, and Gaussian quadrature.

### 7.1 Numerical Differentiation

**Forward Difference Formula (First-Order):**
$$f'(x_0) \approx \frac{f(x_0 + h) - f(x_0)}{h}$$

**Error:** $-\frac{h}{2}f''(\xi)$, where $\xi \in \langle x_0, x_0+h \rangle$

**Derivation Methods:**
1. **Lagrange's method:** Differentiate Lagrange interpolating polynomial
2. **Taylor's method:** Use Taylor expansion with remainder

---

### Higher-Order Formulas

**Centered Difference (Second-Order):**
$$f'(x_0) \approx \frac{f(x_0 + h) - f(x_0 - h)}{2h}$$

**Error:** $-\frac{h^2}{6}f'''(\xi)$

**Derivation:** Using three points x₀-h, x₀, x₀+h:
$$f'(x_0) = \frac{f(x_0+h) - f(x_0-h)}{2h} - \frac{h^2}{6}f'''(\xi)$$

---

### Second Derivative Formulas

**Central Difference for f''(x₀):**
$$f''(x_0) \approx \frac{f(x_0 + h) - 2f(x_0) + f(x_0 - h)}{h^2}$$

**Error:** $-\frac{h^2}{12}f^{(4)}(\xi)$

**General Formula (Theorem 7.2):** For n+1 points:
$$f'(x_i) = \sum_{j=0}^n f(x_j)l'_j(x_i) + \frac{f^{(n+1)}(\xi)}{(n+1)!}\prod_{j=0}^n(x_i - x_j)$$

---

### Richardson Extrapolation

**Idea:** Combine lower-order approximations to eliminate leading error terms.

**For First Derivative:**
Let $N_1(h) = \frac{f(x_0+h) - f(x_0)}{h}$ (first-order forward difference)

Then:
$$N_2(h) = N_1(h) + \frac{N_1(h) - N_1(2h)}{2}$$

is a **second-order** approximation.

**General Recursion:**
$$N_k(h) = N_{k-1}(h) + \frac{N_{k-1}(h) - N_{k-1}(2h)}{2^{k-1}}$$

**Table Format:**
```
h      N₁(h)      N₂(h)      N₃(h)
2h     N₁(2h)     N₂(2h)
4h     N₁(4h)
```

**Result:** Nₖ(h) has error O(hᵏ)

---

### 7.2 Numerical Integration: Basic Concepts

**Quadrature Formula:**
$$\int_a^b f(x)dx \approx \sum_{i=1}^n c_i f(x_i)$$

**Degree of Precision:** Highest degree polynomial integrated exactly.

**Error Term:** For quadrature exact for degree m:
$$E(f) = K f^{(m+1)}(\xi)$$

---

### 7.3 Newton-Cotes Formulas

Newton-Cotes formulas use **equally spaced** nodes.

#### Trapezoidal Rule (n=1)
$$\int_{x_0}^{x_1} f(x)dx \approx \frac{h}{2}(f(x_0) + f(x_1))$$

**Error:** $-\frac{h^3}{12}f''(\xi)$

**Composite Trapezoidal Rule:**
$$\int_a^b f(x)dx \approx \frac{h}{2}\left(f(x_0) + 2\sum_{i=1}^{n-1}f(x_i) + f(x_n)\right)$$

**Error:** $-\frac{(b-a)h^2}{12}f''(\xi) = -\frac{(b-a)^3}{12n^2}f''(\xi)$

---

#### Simpson's Rule (n=2)
$$\int_{x_0}^{x_2} f(x)dx \approx \frac{h}{3}(f(x_0) + 4f(x_1) + f(x_2))$$

**Error:** $-\frac{h^5}{90}f^{(4)}(\xi)$

**Note:** Exact for polynomials up to degree **3** (not just 2)!

**Composite Simpson's Rule:**
$$\int_a^b f(x)dx \approx \frac{h}{3}\left(f(x_0) + 4\sum_{i=1}^n f(x_{2i-1}) + 2\sum_{i=1}^{n-1}f(x_{2i}) + f(x_{2n})\right)$$

**Error:** $-\frac{(b-a)h^4}{180}f^{(4)}(\xi)$

---

#### Other Newton-Cotes Formulas

**Simpson's 3/8 Rule (n=3):**
$$\int_{x_0}^{x_3} f(x)dx \approx \frac{3h}{8}(f(x_0) + 3f(x_1) + 3f(x_2) + f(x_3))$$

**Error:** $-\frac{3h^5}{80}f^{(4)}(\xi)$

**Boole's Rule (n=4):**
$$\int_{x_0}^{x_4} f(x)dx \approx \frac{2h}{45}(7f(x_0) + 32f(x_1) + 12f(x_2) + 32f(x_3) + 7f(x_4))$$

**Error:** $-\frac{8h^7}{945}f^{(6)}(\xi)$

---

#### Open Newton-Cotes Formulas

**Midpoint Rule:**
$$\int_{x_{-1}}^{x_1} f(x)dx \approx 2hf(x_0)$$

**Error:** $\frac{h^3}{3}f''(\xi)$

**Other Open Formulas:**
$$\int_{x_{-1}}^{x_2} f(x)dx \approx \frac{3h}{2}(f(x_0) + f(x_1))$$

$$\int_{x_{-1}}^{x_3} f(x)dx \approx \frac{4h}{3}(2f(x_0) - f(x_1) + 2f(x_2))$$

---

### Numerical Stability (Theorem 7.9)

If quadrature $\sum c_i f(x_i)$ is exact for constants and all $c_i > 0$, then:
$$\left|\sum c_i f(x_i) - \sum c_i y_i\right| \leq \varepsilon(b-a)$$

where $|y_i - f(x_i)| \leq \varepsilon$.

**Interpretation:** Positive weights → stable against rounding errors.

---

### 7.4 Gaussian Quadrature

**Goal:** Maximize degree of precision for given number of nodes.

**n-point Gaussian quadrature** has degree of precision **2n-1** (vs n for Newton-Cotes).

$$\int_a^b f(x)dx \approx \sum_{i=1}^n c_i f(x_i)$$

---

### Legendre Polynomials

**Definition:** Orthogonal polynomials on [-1, 1]:
$$\int_{-1}^1 P_m(x)P_n(x)dx = 0 \quad \text{if } m \neq n$$

**First Few:**
- P₀(x) = 1
- P₁(x) = x
- P₂(x) = x² - 1/3
- P₃(x) = x³ - 3x/5
- P₄(x) = x⁴ - 6x²/7 + 3/35

**Recursion:**
$$P_{n+1}(x) = xP_n(x) - \frac{n^2}{4n^2-1}P_{n-1}(x)$$

---

### Gaussian Quadrature on [-1, 1]

**Theorem 7.13:** Nodes are roots of Pₙ(x), weights given by:
$$c_i = \int_{-1}^1 \frac{(x-x_1)\cdots(x-x_{i-1})(x-x_{i+1})\cdots(x-x_n)}{(x_i-x_1)\cdots(x_i-x_{i-1})(x_i-x_{i+1})\cdots(x_i-x_n)}dx$$

**Two-Point Formula:**
$$\int_{-1}^1 f(x)dx \approx f\left(-\frac{1}{\sqrt{3}}\right) + f\left(\frac{1}{\sqrt{3}}\right)$$

**Error:** $\frac{f^{(4)}(\xi)}{135}$

---

### Gaussian Quadrature Parameters

| n | Nodes (xᵢ) | Weights (cᵢ) |
|---|------------|--------------|
| 2 | ±0.5773502692 | 1.0, 1.0 |
| 3 | ±0.7745966692, 0 | 0.555..., 0.888..., 0.555... |
| 4 | ±0.8611363116, ±0.3399810436 | 0.347..., 0.652..., 0.652..., 0.347... |
| 5 | ±0.9061798459, ±0.5384693101, 0 | 0.236..., 0.478..., 0.568..., 0.478..., 0.236... |

---

### Error Formula (Theorem 7.14)

For f ∈ C²ⁿ[-1, 1]:
$$\int_{-1}^1 f(x)dx - \sum_{k=1}^n c_k f(x_k) = \frac{f^{(2n)}(\xi)}{(2n)!}\int_{-1}^1 P_n^2(x)dx$$

**Simplified:**
$$\text{Error} = \frac{\pi f^{(2n)}(\xi)}{4^n(2n)!}$$

**Key Point:** Error decreases **exponentially** with n (vs polynomial for Newton-Cotes).

---

### Change of Interval

For arbitrary [a, b], use transformation:
$$x = \frac{(b-a)t + a + b}{2}$$

$$\int_a^b f(x)dx = \frac{b-a}{2}\int_{-1}^1 f\left(\frac{(b-a)t + a + b}{2}\right)dt$$

---

## Method Comparison

| Method | Nodes | Degree | Error Order |
|--------|-------|--------|-------------|
| Trapezoidal | 2 | 1 | O(h²) |
| Simpson's | 3 | 3 | O(h⁴) |
| Simpson's 3/8 | 4 | 3 | O(h⁴) |
| Boole's | 5 | 5 | O(h⁶) |
| Gaussian (n-point) | n | 2n-1 | O(h²ⁿ) |

---

## Key Takeaways

1. **Forward/backward difference** are first-order; **centered difference** is second-order
2. **Richardson extrapolation** systematically improves accuracy
3. **Newton-Cotes** use equally spaced nodes; simple but limited precision
4. **Simpson's rule** is exact for cubics (degree 3, not 2)
5. **Gaussian quadrature** maximizes precision: 2n-1 degree for n nodes
6. **Legendre polynomial roots** are optimal nodes for Gaussian quadrature
7. **Positive weights** ensure numerical stability
8. Gaussian error decreases exponentially with n (vs polynomial for Newton-Cotes)
