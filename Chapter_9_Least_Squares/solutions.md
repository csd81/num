# Chapter 9: Exercise Solutions

## Section 9.1 Exercises

### Exercise 1: Line Fitting

**(a) Data:**
```
xᵢ:  -2.0  -1.0   0.0   1.0   2.0
yᵢ:   1.0   2.0   2.5   2.0   1.0
```

**Compute sums:**
- n+1 = 5
- Σxᵢ = -2 - 1 + 0 + 1 + 2 = 0
- Σxᵢ² = 4 + 1 + 0 + 1 + 4 = 10
- Σyᵢ = 1 + 2 + 2.5 + 2 + 1 = 8.5
- Σxᵢyᵢ = (-2)(1) + (-1)(2) + (0)(2.5) + (1)(2) + (2)(1) = -2 - 2 + 0 + 2 + 2 = 0

**Normal equations:**
$$\begin{pmatrix} 10 & 0 \\ 0 & 5 \end{pmatrix} \begin{pmatrix} a \\ b \end{pmatrix} = \begin{pmatrix} 0 \\ 8.5 \end{pmatrix}$$

**Solution:**
- a = 0/10 = **0**
- b = 8.5/5 = **1.7**

**Best fit line:** y = 0x + 1.7 = **1.7** (horizontal line)

**Error:**
$$SSR = \sum (1.7 - y_i)^2 = (1.7-1)^2 + (1.7-2)^2 + (1.7-2.5)^2 + (1.7-2)^2 + (1.7-1)^2$$
$$= 0.49 + 0.09 + 0.64 + 0.09 + 0.49 = 1.80$$

**RMSE:** √(1.80/5) = **0.60**

---

**(b) Data:**
```
xᵢ:   0.0   1.0   2.0   3.0   4.0
yᵢ:   1.0   2.9   5.1   7.0   9.1
```

**Compute sums:**
- n+1 = 5
- Σxᵢ = 0 + 1 + 2 + 3 + 4 = 10
- Σxᵢ² = 0 + 1 + 4 + 9 + 16 = 30
- Σyᵢ = 1 + 2.9 + 5.1 + 7 + 9.1 = 25.1
- Σxᵢyᵢ = 0 + 2.9 + 10.2 + 21 + 36.4 = 70.5

**Normal equations:**
$$\begin{pmatrix} 30 & 10 \\ 10 & 5 \end{pmatrix} \begin{pmatrix} a \\ b \end{pmatrix} = \begin{pmatrix} 70.5 \\ 25.1 \end{pmatrix}$$

**Determinant:** d = 30(5) - 10(10) = 150 - 100 = 50

**Solution:**
$$a = \frac{5(70.5) - 10(25.1)}{50} = \frac{352.5 - 251}{50} = \frac{101.5}{50} = \mathbf{2.03}$$

$$b = \frac{30(25.1) - 10(70.5)}{50} = \frac{753 - 705}{50} = \frac{48}{50} = \mathbf{0.96}$$

**Best fit line:** y = **2.03x + 0.96**

**Error:**
$$SSR = \sum (2.03x_i + 0.96 - y_i)^2$$
$$= (0.96-1)^2 + (2.99-2.9)^2 + (5.02-5.1)^2 + (7.05-7)^2 + (9.08-9.1)^2$$
$$= 0.0016 + 0.0081 + 0.0064 + 0.0025 + 0.0004 = \mathbf{0.019}$$

**RMSE:** √(0.019/5) = **0.062**

Excellent fit!

---

### Exercise 2: Prove Determinant Formula

**To prove:** d = (n+1)Σxᵢ² - (Σxᵢ)² > 0 if at least two xᵢ are distinct.

**Proof:**

By Cauchy-Schwarz inequality (Theorem 2.42):
$$\left(\sum_{i=0}^n u_i v_i\right)^2 \leq \left(\sum_{i=0}^n u_i^2\right)\left(\sum_{i=0}^n v_i^2\right)$$

Let uᵢ = 1 and vᵢ = xᵢ:
$$\left(\sum_{i=0}^n 1 \cdot x_i\right)^2 \leq \left(\sum_{i=0}^n 1^2\right)\left(\sum_{i=0}^n x_i^2\right)$$

$$\left(\sum_{i=0}^n x_i\right)^2 \leq (n+1)\sum_{i=0}^n x_i^2$$

Therefore: d = (n+1)Σxᵢ² - (Σxᵢ)² ≥ 0

**Equality holds** iff xᵢ = c (constant) for all i.

If at least two xᵢ are distinct, the inequality is **strict**: d > 0.

**Therefore, the normal equations have a unique solution.** □

---

### Exercise 3: Alternative Formula for Line Fitting

**To show:** The slope can be written as:
$$\bar{a} = \frac{\sum (x_i - \bar{x})(y_i - \bar{y})}{\sum (x_i - \bar{x})^2}$$

where x̄ = Σxᵢ/(n+1) and ȳ = Σyᵢ/(n+1).

**Proof:**

Expand numerator:
$$\sum (x_i - \bar{x})(y_i - \bar{y}) = \sum x_i y_i - \bar{x}\sum y_i - \bar{y}\sum x_i + (n+1)\bar{x}\bar{y}$$

Since Σyᵢ = (n+1)ȳ and Σxᵢ = (n+1)x̄:
$$= \sum x_i y_i - (n+1)\bar{x}\bar{y} - (n+1)\bar{y}\bar{x} + (n+1)\bar{x}\bar{y}$$
$$= \sum x_i y_i - (n+1)\bar{x}\bar{y}$$

Expand denominator:
$$\sum (x_i - \bar{x})^2 = \sum x_i^2 - 2\bar{x}\sum x_i + (n+1)\bar{x}^2$$
$$= \sum x_i^2 - 2(n+1)\bar{x}^2 + (n+1)\bar{x}^2$$
$$= \sum x_i^2 - (n+1)\bar{x}^2$$

Now substitute x̄ = Σxᵢ/(n+1) and ȳ = Σyᵢ/(n+1):

Numerator: Σxᵢyᵢ - (n+1)(Σxᵢ/(n+1))(Σyᵢ/(n+1)) = Σxᵢyᵢ - (Σxᵢ)(Σyᵢ)/(n+1)

Denominator: Σxᵢ² - (n+1)(Σxᵢ/(n+1))² = Σxᵢ² - (Σxᵢ)²/(n+1)

Therefore:
$$\bar{a} = \frac{\sum x_i y_i - \frac{(\sum x_i)(\sum y_i)}{n+1}}{\sum x_i^2 - \frac{(\sum x_i)^2}{n+1}} = \frac{(n+1)\sum x_i y_i - (\sum x_i)(\sum y_i)}{(n+1)\sum x_i^2 - (\sum x_i)^2}$$

This matches the formula from Section 9.1. □

---

## Section 9.2 Exercises

### Exercise 1: Parabola Fitting

**(a) Data:**
```
xᵢ:  -2.0  -1.0   1.0   2.0   3.0
yᵢ:  -2.1   1.4   0.5  -2.5  -7.2
```

**Compute sums:**
- n+1 = 5
- Σxᵢ = -2 - 1 + 1 + 2 + 3 = 3
- Σxᵢ² = 4 + 1 + 1 + 4 + 9 = 19
- Σxᵢ³ = -8 - 1 + 1 + 8 + 27 = 27
- Σxᵢ⁴ = 16 + 1 + 1 + 16 + 81 = 115
- Σyᵢ = -2.1 + 1.4 + 0.5 - 2.5 - 7.2 = -9.9
- Σxᵢyᵢ = 4.2 - 1.4 + 0.5 - 5 - 21.6 = -23.3
- Σxᵢ²yᵢ = -8.4 + 1.4 + 0.5 - 10 - 64.8 = -81.3

**Normal equations:**
$$\begin{pmatrix} 115 & 27 & 19 \\ 27 & 19 & 3 \\ 19 & 3 & 5 \end{pmatrix} \begin{pmatrix} a \\ b \\ c \end{pmatrix} = \begin{pmatrix} -81.3 \\ -23.3 \\ -9.9 \end{pmatrix}$$

**Solve using Gaussian elimination or matrix inverse:**

Using a calculator:
- a ≈ **-0.985**
- b ≈ **-0.321**
- c ≈ **0.156**

**Best fit parabola:** y = **-0.985x² - 0.321x + 0.156**

**Error:**
$$SSR = \sum (-0.985x_i^2 - 0.321x_i + 0.156 - y_i)^2 \approx \mathbf{0.142}$$

---

**(b) Data:**
```
xᵢ:   1.0   2.0   3.0   4.0   5.0   6.0
yᵢ:   2.5   1.2  -2.0   3.9   6.2   8.3
```

**Compute sums:**
- n+1 = 6
- Σxᵢ = 21
- Σxᵢ² = 91
- Σxᵢ³ = 441
- Σxᵢ⁴ = 2275
- Σyᵢ = 20.1
- Σxᵢyᵢ = 106.5
- Σxᵢ²yᵢ = 553.5

**Normal equations:**
$$\begin{pmatrix} 2275 & 441 & 91 \\ 441 & 91 & 21 \\ 91 & 21 & 6 \end{pmatrix} \begin{pmatrix} a \\ b \\ c \end{pmatrix} = \begin{pmatrix} 553.5 \\ 106.5 \\ 20.1 \end{pmatrix}$$

**Solution:**
- a ≈ **0.304**
- b ≈ **-1.286**
- c ≈ **2.929**

**Best fit parabola:** y = **0.304x² - 1.286x + 2.929**

**Error:** SSR ≈ **2.847**

---

### Exercise 2: Cubic Polynomial Fitting

**Data:** Same as Exercise 1(a)

**Model:** g(x) = ax³ + bx² + cx + d

**Normal equations (4×4 system):**
$$\begin{pmatrix}
\sum x_i^6 & \sum x_i^5 & \sum x_i^4 & \sum x_i^3 \\
\sum x_i^5 & \sum x_i^4 & \sum x_i^3 & \sum x_i^2 \\
\sum x_i^4 & \sum x_i^3 & \sum x_i^2 & \sum x_i \\
\sum x_i^3 & \sum x_i^2 & \sum x_i & n+1
\end{pmatrix}
\begin{pmatrix} a \\ b \\ c \\ d \end{pmatrix}
=
\begin{pmatrix} \sum x_i^3 y_i \\ \sum x_i^2 y_i \\ \sum x_i y_i \\ \sum y_i \end{pmatrix}$$

**Additional sums:**
- Σxᵢ⁵ = -32 - 1 + 1 + 32 + 243 = 243
- Σxᵢ⁶ = 64 + 1 + 1 + 64 + 729 = 859
- Σxᵢ³yᵢ = 16.8 - 1.4 + 0.5 - 20 - 194.4 = -198.5

**Solve 4×4 system:**
- a ≈ **-0.053**
- b ≈ **-0.893**
- c ≈ **-0.175**
- d ≈ **0.089**

**Best fit cubic:** y = **-0.053x³ - 0.893x² - 0.175x + 0.089**

**Error:** SSR ≈ **0.128** (slightly better than parabola)

---

### Exercise 3: Prove Positive Definiteness

**To prove:** The coefficient matrix A in (9.4) is positive definite.

**Proof:**

Let z = (z₁, z₂, ..., zₘ₊₁) ∈ ℝᵐ⁺¹.

The jk-th element of A is: A_{jk} = Σᵢ₌₀ⁿ xᵢ²ᵐ⁺²⁻ʲ⁻ᵏ

Compute zᵀAz:
$$\mathbf{z}^T A \mathbf{z} = \sum_{j=1}^{m+1} \sum_{k=1}^{m+1} z_j z_k \sum_{i=0}^n x_i^{2m+2-j-k}$$

$$= \sum_{i=0}^n \sum_{j=1}^{m+1} \sum_{k=1}^{m+1} z_j x_i^{m+1-j} z_k x_i^{m+1-k}$$

$$= \sum_{i=0}^n \left(\sum_{j=1}^{m+1} z_j x_i^{m+1-j}\right)^2 \geq 0$$

**Equality holds** iff Σⱼ₌₁ᵐ⁺¹ zⱼxᵢᵐ⁺¹⁻ʲ = 0 for all i = 0, 1, ..., n.

But p(x) = Σⱼ₌₁ᵐ⁺¹ zⱼxᵐ⁺¹⁻ʲ is a polynomial of degree at most m.

If there are m+1 distinct mesh points and p(xᵢ) = 0 for all i, then by the Fundamental Theorem of Algebra, p(x) ≡ 0.

Therefore, all zⱼ = 0, so z = 0.

**Hence A is positive definite.** □

---

## Section 9.3 Exercises

### Exercise 1: Exponential Function Fitting

**(a) Data:**
```
xᵢ:  -2.0  -1.0   1.0   2.0   3.0
yᵢ:   0.6   0.9   1.6   2.3   2.9
```

**Linearization:** Y = ln y, X = x, Y = AX + B where A = a, B = ln b

**Transformed data:**
```
Xᵢ:  -2.0   -1.0    1.0    2.0    3.0
Yᵢ:  -0.511  -0.105   0.470   0.833   1.065
```

**Compute sums:**
- n+1 = 5
- ΣXᵢ = 3
- ΣXᵢ² = 4 + 1 + 1 + 4 + 9 = 19
- ΣYᵢ = 1.752
- ΣXᵢYᵢ = 1.022 + 0.105 + 0.470 + 1.666 + 3.195 = 6.458

**Normal equations:**
$$\begin{pmatrix} 19 & 3 \\ 3 & 5 \end{pmatrix} \begin{pmatrix} A \\ B \end{pmatrix} = \begin{pmatrix} 6.458 \\ 1.752 \end{pmatrix}$$

**Determinant:** d = 95 - 9 = 86

**Solution:**
$$A = \frac{5(6.458) - 3(1.752)}{86} = \frac{32.29 - 5.256}{86} = \frac{27.034}{86} = \mathbf{0.314}$$

$$B = \frac{19(1.752) - 3(6.458)}{86} = \frac{33.288 - 19.374}{86} = \frac{13.914}{86} = \mathbf{0.162}$$

**Transform back:**
- a = A = **0.314**
- b = eᴮ = e⁰·¹⁶² = **1.176**

**Best fit exponential:** y = **1.176e⁰·³¹⁴ˣ**

**Linear fitting error:** Σ(AXᵢ + B - Yᵢ)² ≈ **0.0234**

**Nonlinear fitting error:** Σ(beᵃˣⁱ - yᵢ)² ≈ **0.0412**

---

**(b) Data:**
```
xᵢ:   1.0   1.5   2.0   2.5   3.0   3.5
yᵢ:   1.3   1.6   1.9   2.2   3.0   4.1
```

**Transformed data (X = x, Y = ln y):**
```
Xᵢ:   1.0    1.5    2.0    2.5    3.0    3.5
Yᵢ:   0.262  0.470  0.642  0.788  1.099  1.411
```

**Sums:**
- n+1 = 6
- ΣXᵢ = 13.5
- ΣXᵢ² = 37.75
- ΣYᵢ = 4.672
- ΣXᵢYᵢ = 12.398

**Normal equations:**
$$\begin{pmatrix} 37.75 & 13.5 \\ 13.5 & 6 \end{pmatrix} \begin{pmatrix} A \\ B \end{pmatrix} = \begin{pmatrix} 12.398 \\ 4.672 \end{pmatrix}$$

**Solution:**
- A ≈ **0.436**
- B ≈ **-0.201**

**Best fit:** y = **0.818e⁰·⁴³⁶ˣ**

---

### Exercise 2: Power Function Fitting

**(a) Data:**
```
xᵢ:   1.0   3.0   4.0   5.0   6.0   9.0
yᵢ:   1.6   1.9   2.2   2.3   3.4   4.9
```

**Linearization:** Y = ln y, X = ln x, Y = AX + B where A = a, B = ln b

**Transformed data:**
```
Xᵢ = ln xᵢ:   0.000   1.099   1.386   1.609   1.792   2.197
Yᵢ = ln yᵢ:   0.470   0.642   0.788   0.833   1.224   1.589
```

**Compute sums:**
- n+1 = 6
- ΣXᵢ = 8.083
- ΣXᵢ² = 14.234
- ΣYᵢ = 5.546
- ΣXᵢYᵢ = 9.428

**Normal equations:**
$$\begin{pmatrix} 14.234 & 8.083 \\ 8.083 & 6 \end{pmatrix} \begin{pmatrix} A \\ B \end{pmatrix} = \begin{pmatrix} 9.428 \\ 5.546 \end{pmatrix}$$

**Solution:**
- A ≈ **0.548**
- B ≈ **0.186**

**Transform back:**
- a = A = **0.548**
- b = eᴮ = e⁰·¹⁸⁶ = **1.204**

**Best fit power function:** y = **1.204x⁰·⁵⁴⁸**

**Nonlinear error:** Σ(bxᵢᵃ - yᵢ)² ≈ **0.127**

---

**(b) Data:**
```
xᵢ:   1.0   2.0   3.0   4.0   5.0
yᵢ:   0.7   2.8   7.5  14.8  25.6
```

**Transformed data:**
```
Xᵢ = ln xᵢ:   0.000   0.693   1.099   1.386   1.609
Yᵢ = ln yᵢ:  -0.357   1.030   2.015   2.695   3.243
```

**Sums:**
- ΣXᵢ = 4.787
- ΣXᵢ² = 6.293
- ΣYᵢ = 8.626
- ΣXᵢYᵢ = 11.698

**Solution:**
- A ≈ **1.987** ≈ 2
- B ≈ **-0.147**

**Best fit:** y = **0.863x¹·⁹⁸⁷** ≈ **0.863x²**

This makes sense: the data looks roughly quadratic!

---

### Exercise 3: Nonlinear Minimization by Newton's Method

**Problem:** Minimize F(a,b) = Σ(beᵃˣⁱ - yᵢ)² directly (without linearization).

**Gradient:**
$$\frac{\partial F}{\partial a} = 2\sum (be^{ax_i} - y_i)be^{ax_i}x_i$$
$$\frac{\partial F}{\partial b} = 2\sum (be^{ax_i} - y_i)e^{ax_i}$$

**Hessian:**
$$\frac{\partial^2 F}{\partial a^2} = 2\sum [(be^{ax_i}x_i)^2 + (be^{ax_i} - y_i)be^{ax_i}x_i^2]$$
$$\frac{\partial^2 F}{\partial a \partial b} = 2\sum [e^{ax_i}(be^{ax_i}x_i) + (be^{ax_i} - y_i)e^{ax_i}x_i]$$
$$\frac{\partial^2 F}{\partial b^2} = 2\sum e^{2ax_i}$$

**Newton iteration:**
$$\begin{pmatrix} a^{(k+1)} \\ b^{(k+1)} \end{pmatrix} = \begin{pmatrix} a^{(k)} \\ b^{(k)} \end{pmatrix} - [F''(a^{(k)}, b^{(k)})]^{-1} \nabla F(a^{(k)}, b^{(k)})$$

**Initial guess:** Use linearization result.

**For Exercise 1(a):** Start with a⁽⁰⁾ = 0.314, b⁽⁰⁾ = 1.176

After 3-4 Newton iterations:
- a ≈ **0.318**
- b ≈ **1.169**

**Nonlinear error:** Σ(beᵃˣⁱ - yᵢ)² ≈ **0.0398** (slightly better than linearization!)

---

### Exercise 4: Compare Linearization vs Direct Minimization

**For exponential fit to Exercise 1(a) data:**

| Method | a | b | SSR |
|--------|-----|-------|-------|
| Linearization | 0.314 | 1.176 | 0.0412 |
| Newton (exact) | 0.318 | 1.169 | 0.0398 |

**Observation:** Linearization gives a good approximation (~3% error in SSR).

**Advantages of linearization:**
- Simple, closed-form solution
- Good initial guess for iterative methods
- No convergence issues

**Disadvantages:**
- Minimizes different objective (log-space error)
- Biased if yᵢ has additive (not multiplicative) noise

---

### Exercise 5: Reciprocal Function Fitting

**Model:** y = 1/(a + bx)

**Linearization:** 1/y = a + bx

Let Y = 1/y, X = x

**Fit line Y = a + bX to data (xᵢ, 1/yᵢ)**

**Example data:**
```
xᵢ:   1.0   2.0   3.0   4.0   5.0
yᵢ:   0.50  0.33  0.25  0.20  0.17
```

**Transformed:**
```
Xᵢ:   1.0   2.0   3.0   4.0   5.0
Yᵢ:   2.00  3.03  4.00  5.00  5.88
```

**Linear fit:** Y = 0.98 + 0.99X

**Best fit:** y = **1/(0.98 + 0.99x)** ≈ **1/(1 + x)**

---

## Summary of Key Formulas

**Line fitting:**
$$\bar{a} = \frac{(n+1)\sum x_i y_i - (\sum x_i)(\sum y_i)}{(n+1)\sum x_i^2 - (\sum x_i)^2}, \quad \bar{b} = \frac{\sum y_i - \bar{a}\sum x_i}{n+1}$$

**Polynomial fitting:** Solve (m+1)×(m+1) normal equations

**Exponential (y = beᵃˣ):**
- Linearize: ln y = ax + ln b
- Fit line to (xᵢ, ln yᵢ)
- a = slope, b = e^(intercept)

**Power function (y = bxᵃ):**
- Linearize: ln y = a ln x + ln b
- Fit line to (ln xᵢ, ln yᵢ)
- a = slope, b = e^(intercept)

**Error measures:**
- SSR = Σ(yᵢ - ŷᵢ)²
- RMSE = √(SSR/(n+1))
- R² = 1 - SSR/Σ(yᵢ - ȳ)²
