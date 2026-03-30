# Chapter 10: Ordinary Differential Equations

## Summary

This chapter covers numerical methods for solving initial value problems (IVPs) for ordinary differential equations, including Euler's method, Taylor's method, and Runge-Kutta methods.

### 10.1 Review of Differential Equations

**Initial Value Problem (IVP):**
$$y' = f(t, y), \quad y(t_0) = y_0$$

on a finite interval [t₀, T].

**Lipschitz Continuity:** f is Lipschitz continuous in y with constant L if:
$$|f(t, y) - f(t, \tilde{y})| \leq L|y - \tilde{y}|$$

**Theorem 10.1 (Existence and Uniqueness):** If f is continuous and Lipschitz continuous in y, then the IVP has a unique solution on [t₀, T].

**Higher-Order ODEs:** An mth-order ODE:
$$y^{(m)} = f(t, y, y', \ldots, y^{(m-1)})$$

can be converted to a first-order system by letting:
$$\mathbf{y} = (y, y', \ldots, y^{(m-1)})^T$$

---

### 10.2 Euler's Method

**Mesh:** tᵢ = t₀ + ih, where h = (T - t₀)/n

**Iteration:**
$$z_{i+1} = z_i + hf(t_i, z_i), \quad z_0 = y_0$$

**Derivation Methods:**
1. **Taylor expansion:** y(t+h) = y(t) + hy'(t) + O(h²)
2. **Integral form:** y(tᵢ₊₁) - y(tᵢ) = ∫f(t,y)dt ≈ hf(tᵢ, zᵢ)
3. **Finite difference:** y' ≈ (y(t+h) - y(t))/h

---

#### Local Truncation Error

**Definition:**
$$\tau_{i+1} = \frac{y(t_{i+1}) - y(t_i)}{h} - f(t_i, y(t_i))$$

**For Euler's method:** τᵢ₊₁ = (h/2)y''(ξᵢ) = O(h)

**Theorem 10.3:** If f is Lipschitz continuous and y ∈ C²:
$$|\tau_{i+1}| \leq \frac{h}{2}M_2$$

where M₂ = max|y''(t)| on [t₀, T].

---

#### Global Error and Convergence

**Theorem 10.5:** If f is Lipschitz continuous with constant L and y ∈ C²:
$$|y(t_i) - z_i| \leq \frac{hM_2}{2L}(e^{L(t_i-t_0)} - 1) = O(h)$$

**Euler's method is first-order accurate.**

---

#### Stability and Rounding Errors

**Theorem 10.6:** With rounding errors δᵢ at each step:
$$|y(t_i) - w_i| \leq \frac{e^{L(T-t_0)} - 1}{L}\left(\frac{hM_2}{2} + \frac{\delta}{h}\right) + |\delta_0|e^{L(T-t_0)}$$

**Key insight:** If h is too small, rounding error δ/h dominates!

**Optimal step size:** Balance truncation error (hM₂/2) with rounding error (δ/h):
$$h_{opt} = \sqrt{\frac{2\delta}{M_2}}$$

---

### 10.4 Taylor's Method

**General one-step method:**
$$z_{i+1} = z_i + hF(t_i, z_i; h)$$

**Taylor's method of order α:**
$$F(t, z; h) = f(t, z) + \frac{h}{2}f^{(1)}(t, z) + \cdots + \frac{h^{\alpha-1}}{\alpha!}f^{(\alpha-1)}(t, z)$$

where f⁽ⁱ⁾ denotes the ith total derivative of f with respect to t.

**Derivatives:**
- y'(t) = f(t, y(t))
- y''(t) = f⁽¹⁾(t, y(t)) = ∂f/∂t + ∂f/∂y · f
- y'''(t) = f⁽²⁾(t, y(t)) = d/dt[f⁽¹⁾(t, y(t))]

---

#### Second-Order Taylor's Method

$$z_{i+1} = z_i + hf(t_i, z_i) + \frac{h^2}{2}f^{(1)}(t_i, z_i)$$

**Local truncation error:** O(h²)

**Global error:** O(h²)

---

#### Third-Order Taylor's Method

$$z_{i+1} = z_i + hf(t_i, z_i) + \frac{h^2}{2}f^{(1)}(t_i, z_i) + \frac{h^3}{6}f^{(2)}(t_i, z_i)$$

**Local truncation error:** O(h³)

**Global error:** O(h³)

---

**Theorem 10.7:** If F is Lipschitz continuous and local truncation error is O(hᵅ), then global error is O(hᵅ).

**Disadvantage:** Computing higher derivatives f⁽ⁱ⁾ can be very complicated!

---

### 10.5 Runge-Kutta Methods

**Idea:** Achieve high-order accuracy without computing derivatives of f.

**General explicit Runge-Kutta method:**
$$z_{i+1} = z_i + h\sum_{j=1}^p \gamma_j G_j(t_i, z_i; h)$$

where:
- G₁(t, z; h) = f(t, z)
- Gⱼ(t, z; h) = f(t + αⱼh, z + h∑ₖ₌₁ʲ⁻¹βⱼₖGₖ)

---

#### Second-Order Runge-Kutta Methods

**General form (p = 2):**
$$F(t, z; h) = \gamma_1 f(t, z) + \gamma_2 f(t + \alpha_1 h, z + \beta_{21}hf(t, z))$$

**For second-order accuracy:**
$$\gamma_1 + \gamma_2 = 1, \quad \gamma_2\alpha_1 = \frac{1}{2}, \quad \gamma_2\beta_{21} = \frac{1}{2}$$

---

**Midpoint Method:**
$$z_{i+1} = z_i + hf\left(t_i + \frac{h}{2}, z_i + \frac{h}{2}f(t_i, z_i)\right)$$

Parameters: γ₁ = 0, γ₂ = 1, α₁ = β₂₁ = 1/2

---

**Modified Euler Method:**
$$z_{i+1} = z_i + \frac{h}{2}[f(t_i, z_i) + f(t_{i+1}, z_i + hf(t_i, z_i))]$$

Parameters: γ₁ = γ₂ = 1/2, α₁ = β₂₁ = 1

**Geometric interpretation:** Average of slopes at beginning and predicted endpoint.

---

**Heun's Method:**
$$z_{i+1} = z_i + \frac{h}{4}\left[f(t_i, z_i) + 3f\left(t_i + \frac{2h}{3}, z_i + \frac{2h}{3}f(t_i, z_i)\right)\right]$$

Parameters: γ₁ = 1/4, γ₂ = 3/4, α₁ = β₂₁ = 2/3

---

#### Classical Fourth-Order Runge-Kutta Method (RK4)

$$z_{i+1} = z_i + \frac{h}{6}(w_{i,1} + 2w_{i,2} + 2w_{i,3} + w_{i,4})$$

where:
- wᵢ,₁ = f(tᵢ, zᵢ)
- wᵢ,₂ = f(tᵢ + h/2, zᵢ + hwᵢ,₁/2)
- wᵢ,₃ = f(tᵢ + h/2, zᵢ + hwᵢ,₂/2)
- wᵢ,₄ = f(tᵢ + h, zᵢ + hwᵢ,₃)

**Local truncation error:** O(h⁴)

**Global error:** O(h⁴)

**Most popular ODE solver!**

---

### Maximum Order vs. Number of Stages

| p (stages) | Max Order |
|------------|-----------|
| 1 | 1 |
| 2 | 2 |
| 3 | 3 |
| 4 | 4 |
| 5 | 4 |
| 6 | 5 |
| 7 | 6 |
| 8 | 6 |

Note: p = 5 gives at most order 4 (not 5)!

---

### Method Comparison

| Method | Order | Function Evaluations | Derivatives Needed |
|--------|-------|---------------------|-------------------|
| Euler | 1 | 1 | No |
| Midpoint (RK2) | 2 | 2 | No |
| Modified Euler | 2 | 2 | No |
| Taylor (order 2) | 2 | 1 | Yes (f⁽¹⁾) |
| Taylor (order 3) | 3 | 1 | Yes (f⁽¹⁾, f⁽²⁾) |
| Heun | 2 | 2 | No |
| RK4 | 4 | 4 | No |

---

### Special Properties

**Exercise 10.5.4:** For y' = 2 - t - y, y(0) = 1:
- Midpoint, Modified Euler, and Heun give **identical results**
- This is because f is linear in y

**Exercise 10.5.6:** If f depends only on t (y' = f(t)):
- RK4 reduces to **Simpson's rule** for integration
- This connects ODE solving to numerical integration

---

## Key Takeaways

1. **Euler's method** is simple but only first-order accurate
2. **Taylor's method** achieves higher order but requires derivative computation
3. **Runge-Kutta methods** achieve high order without derivatives
4. **RK4** is the most popular method (good balance of accuracy and cost)
5. **Optimal step size** balances truncation error with rounding error
6. **Lipschitz continuity** ensures existence, uniqueness, and stability
7. **Global error** is one order less than local truncation error
8. For **stiff equations**, implicit methods may be needed (not covered here)
