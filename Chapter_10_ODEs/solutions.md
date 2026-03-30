# Chapter 10: Exercise Solutions

## Section 10.1 Exercises

### Exercise 1: Convert Higher-Order ODEs to Systems

**(a) y'' + 5y' = e²ᵗ⁻¹, y(0) = 3, y'(0) = -1**

Let y₁ = y, y₂ = y'

Then:
- y₁' = y₂
- y₂' = e²ᵗ⁻¹ - 5y₂

**System form:**
$$\begin{pmatrix} y_1' \\ y_2' \end{pmatrix} = \begin{pmatrix} y_2 \\ e^{2t-1} - 5y_2 \end{pmatrix}, \quad \begin{pmatrix} y_1(0) \\ y_2(0) \end{pmatrix} = \begin{pmatrix} 3 \\ -1 \end{pmatrix}$$

---

**(b) y'' - t²y' + ty = 0, y(1) = 1, y'(1) = 0**

Let y₁ = y, y₂ = y'

Then:
- y₁' = y₂
- y₂' = t²y₂ - ty₁

**System form:**
$$\begin{pmatrix} y_1' \\ y_2' \end{pmatrix} = \begin{pmatrix} y_2 \\ t^2 y_2 - t y_1 \end{pmatrix}, \quad \begin{pmatrix} y_1(1) \\ y_2(1) \end{pmatrix} = \begin{pmatrix} 1 \\ 0 \end{pmatrix}$$

---

**(c) y''' + 4y'' - 2y' + 5y = t³, y(-1) = 2, y'(-1) = -3, y''(-1) = 1**

Let y₁ = y, y₂ = y', y₃ = y''

Then:
- y₁' = y₂
- y₂' = y₃
- y₃' = t³ - 4y₃ + 2y₂ - 5y₁

**System form:**
$$\begin{pmatrix} y_1' \\ y_2' \\ y_3' \end{pmatrix} = \begin{pmatrix} y_2 \\ y_3 \\ t^3 - 4y_3 + 2y_2 - 5y_1 \end{pmatrix}, \quad \begin{pmatrix} y_1(-1) \\ y_2(-1) \\ y_3(-1) \end{pmatrix} = \begin{pmatrix} 2 \\ -3 \\ 1 \end{pmatrix}$$

---

### Exercise 2: Non-uniqueness Example

**IVP:** y' = √|y|, y(0) = 0

**Two solutions:**
1. y₁(t) = 0 for all t
2. y₂(t) = t²/4 for t ≥ 0

**Verification:**
- y₁'(t) = 0, √|y₁| = √0 = 0 ✓
- y₂'(t) = t/2, √|y₂| = √(t²/4) = t/2 ✓
- Both satisfy y(0) = 0 ✓

**Show f(y) = √|y| is not Lipschitz:**

For Lipschitz, we need |f(y) - f(ỹ)| ≤ L|y - ỹ| for some L.

Take ỹ = 0:
$$\frac{|f(y) - f(0)|}{|y - 0|} = \frac{\sqrt{|y|}}{|y|} = \frac{1}{\sqrt{|y|}}$$

As y → 0, this ratio → ∞.

**Therefore, no finite Lipschitz constant exists.**

**Conclusion:** Lipschitz continuity is essential for uniqueness!

---

### Exercise 3: C¹ Implies Local Lipschitz

**To prove:** If f is continuously differentiable in y, then f is locally Lipschitz in y.

**Proof:**

Let [a, b] be any bounded interval.

Since ∂f/∂y is continuous on [t₀, T] × [a, b], it is bounded:
$$\left|\frac{\partial f}{\partial y}(t, y)\right| \leq M \quad \text{for all } t \in [t_0, T], y \in [a, b]$$

By the Mean Value Theorem, for any y, ỹ ∈ [a, b]:
$$f(t, y) - f(t, \tilde{y}) = \frac{\partial f}{\partial y}(t, \xi)(y - \tilde{y})$$

for some ξ between y and ỹ.

Therefore:
$$|f(t, y) - f(t, \tilde{y})| = \left|\frac{\partial f}{\partial y}(t, \xi)\right||y - \tilde{y}| \leq M|y - \tilde{y}|$$

**Therefore, f is Lipschitz continuous on [a, b] with constant L = M.**

Since [a, b] was arbitrary, f is **locally Lipschitz**. □

---

### Exercise 4: Finite-Time Blowup

**IVP:** y' = y², y(0) = 1

**Exact solution:**
$$\frac{dy}{dt} = y^2 \implies \int \frac{dy}{y^2} = \int dt \implies -\frac{1}{y} = t + C$$

y(0) = 1 ⟹ C = -1

$$y(t) = \frac{1}{1-t}$$

**Blowup:** As t → 1⁻, y(t) → ∞

**Therefore, no solution exists on [0, T] for T ≥ 1.**

---

**Show g(y) = y² is locally but not globally Lipschitz:**

**Not globally Lipschitz:**
$$\frac{|g(y) - g(0)|}{|y - 0|} = \frac{y^2}{|y|} = |y|$$

As |y| → ∞, this ratio → ∞. No global Lipschitz constant exists.

**Locally Lipschitz:**
On any bounded interval [a, b]:
$$|g'(y)| = |2y| \leq 2\max(|a|, |b|) = M$$

By Exercise 3, g is locally Lipschitz.

**Conclusion:** Local Lipschitz ⟹ local existence/uniqueness, but not global existence!

---

## Section 10.2 Exercises

### Exercise 1: Euler's Method Applications

**(a) y' = 2y - 10t² + 2t, y(0) = 1 on [0, 1]**

Exact solution: y(t) = 5t² + 2t + 1 (can be verified)

**Euler's method:** zᵢ₊₁ = zᵢ + h(2zᵢ - 10tᵢ² + 2tᵢ)

**With h = 0.2:**
```
t₀ = 0.0:  z₀ = 1.0000
t₁ = 0.2:  z₁ = 1 + 0.2(2·1 - 0 + 0) = 1.4000
t₂ = 0.4:  z₂ = 1.4 + 0.2(2·1.4 - 10·0.04 + 0.4) = 1.4 + 0.2(2.8 - 0.4 + 0.4) = 1.9600
t₃ = 0.6:  z₃ = 1.96 + 0.2(2·1.96 - 10·0.16 + 0.8) = 1.96 + 0.2(3.92 - 1.6 + 0.8) = 2.5840
t₄ = 0.8:  z₄ = 2.584 + 0.2(2·2.584 - 10·0.36 + 1.2) = 2.584 + 0.2(5.168 - 3.6 + 1.2) = 3.1328
t₅ = 1.0:  z₅ = 3.1328 + 0.2(2·3.1328 - 10·0.64 + 1.6) = 3.1328 + 0.2(6.2656 - 6.4 + 1.6) = 3.4254
```

**Exact values:**
- y(0.2) = 5(0.04) + 2(0.2) + 1 = 1.6
- y(0.4) = 5(0.16) + 2(0.4) + 1 = 2.4
- y(0.6) = 5(0.36) + 2(0.6) + 1 = 3.4
- y(0.8) = 5(0.64) + 2(0.8) + 1 = 4.6
- y(1.0) = 5 + 2 + 1 = 8

**Errors at t = 1:**
- Euler (h=0.2): |8 - 3.4254| = 4.5746
- This is a large error! Euler's method is not accurate for this problem.

---

**(b) y' = y - t² + 1, y(0) = 0.5**

Exact solution: y(t) = t² + 2t + 1 - 0.5eᵗ

**Euler's method:** zᵢ₊₁ = zᵢ + h(zᵢ - tᵢ² + 1)

With h = 0.2:
```
t₀ = 0.0:  z₀ = 0.5000
t₁ = 0.2:  z₁ = 0.5 + 0.2(0.5 - 0 + 1) = 0.8000
t₂ = 0.4:  z₂ = 0.8 + 0.2(0.8 - 0.04 + 1) = 1.1520
...
```

---

**(c) y' = cos(t) - 2y, y(0) = 0**

Exact solution: y(t) = (2/5)e⁻²ᵗ + (1/5)(2cos(t) + sin(t)) - 2/5

**Euler's method:** zᵢ₊₁ = zᵢ + h(cos(tᵢ) - 2zᵢ)

---

### Exercise 2: Derive Euler from Integral Form

**To derive:** zᵢ₊₁ = zᵢ + hf(tᵢ, zᵢ) from y(tᵢ₊₁) - y(tᵢ) = ∫ᵢᵢ₊₁f(t,y)dt

**Proof:**

From the ODE y' = f(t, y):
$$y(t_{i+1}) - y(t_i) = \int_{t_i}^{t_{i+1}} f(t, y(t)) dt$$

Approximate the integral using the **left rectangle rule**:
$$\int_{t_i}^{t_{i+1}} f(t, y(t)) dt \approx h f(t_i, y(t_i))$$

Therefore:
$$y(t_{i+1}) \approx y(t_i) + hf(t_i, y(t_i))$$

Replace y(tᵢ) with approximation zᵢ:
$$z_{i+1} = z_i + hf(t_i, z_i)$$

**This is Euler's method.** □

---

### Exercise 3: Lipschitz Constant for f(t,y) = 2y - 10t² + 2t

**f(t, y) = 2y - 10t² + 2t**

**Lipschitz constant:**
$$|f(t, y) - f(t, \tilde{y})| = |2y - 2\tilde{y}| = 2|y - \tilde{y}|$$

**L = 2**

---

**Verify Theorem 10.5 bound:**

M₂ = max|y''(t)| on [0, 1]

y(t) = 5t² + 2t + 1
y'(t) = 10t + 2
y''(t) = 10

M₂ = 10

**Error bound at t = 1:**
$$|y(1) - z_n| \leq \frac{hM_2}{2L}(e^{L(1-0)} - 1) = \frac{0.2 \cdot 10}{2 \cdot 2}(e^2 - 1) = \frac{1}{2}(7.389 - 1) = 3.19$$

**Actual error:** 4.57

The bound is conservative but same order of magnitude.

---

### Exercise 4: Global Error Bound Derivation

**To derive:** |y(tᵢ) - zᵢ| ≤ (hM₂/2L)(e^(L(tᵢ-t₀)) - 1)

**Proof:**

Let eᵢ = y(tᵢ) - zᵢ be the global error.

From Taylor expansion:
$$y(t_{i+1}) = y(t_i) + hf(t_i, y(t_i)) + \frac{h^2}{2}y''(\xi_i)$$

Euler's method:
$$z_{i+1} = z_i + hf(t_i, z_i)$$

Subtract:
$$e_{i+1} = e_i + h[f(t_i, y(t_i)) - f(t_i, z_i)] + \frac{h^2}{2}y''(\xi_i)$$

Take absolute values:
$$|e_{i+1}| \leq |e_i| + h|f(t_i, y(t_i)) - f(t_i, z_i)| + \frac{h^2}{2}M_2$$

By Lipschitz continuity:
$$|e_{i+1}| \leq |e_i| + hL|e_i| + \frac{h^2}{2}M_2 = (1 + hL)|e_i| + \frac{h^2}{2}M_2$$

Let A = 1 + hL and B = h²M₂/2:
$$|e_{i+1}| \leq A|e_i| + B$$

By induction:
$$|e_i| \leq A^i|e_0| + B\frac{A^i - 1}{A - 1}$$

Since e₀ = 0 and A - 1 = hL:
$$|e_i| \leq \frac{B}{hL}(A^i - 1) = \frac{hM_2}{2L}((1 + hL)^i - 1)$$

Since (1 + hL)^i ≤ e^(ihL) = e^(L(tᵢ-t₀)):
$$|e_i| \leq \frac{hM_2}{2L}(e^{L(t_i-t_0)} - 1)$$

**QED** □

---

## Section 10.3 Exercises

### Exercise 1: Work Out Theorem 10.6 Details

**Theorem 10.6:** With rounding errors:
$$|y(t_i) - w_i| \leq \frac{e^{L(T-t_0)} - 1}{L}\left(\frac{hM_2}{2} + \frac{\delta}{h}\right) + |\delta_0|e^{L(T-t_0)}$$

**Derivation:**

Let wᵢ be the computed value with rounding:
$$w_{i+1} = w_i + hf(t_i, w_i) + \delta_{i+1}$$

where |δᵢ| ≤ δ for i ≥ 1, and |δ₀| is the initial error.

Let eᵢ = y(tᵢ) - wᵢ:
$$e_{i+1} = e_i + h[f(t_i, y(t_i)) - f(t_i, w_i)] + \frac{h^2}{2}y''(\xi_i) - \delta_{i+1}$$

$$|e_{i+1}| \leq (1 + hL)|e_i| + \frac{h^2}{2}M_2 + \delta$$

Let A = 1 + hL, B = h²M₂/2 + δ:
$$|e_i| \leq A^i|e_0| + B\frac{A^i - 1}{A - 1}$$

$$|e_i| \leq e^{L(t_i-t_0)}|\delta_0| + \frac{h^2M_2/2 + \delta}{hL}(e^{L(t_i-t_0)} - 1)$$

$$|e_i| \leq |\delta_0|e^{L(t_i-t_0)} + \frac{e^{L(t_i-t_0)} - 1}{L}\left(\frac{hM_2}{2} + \frac{\delta}{h}\right)$$

**QED** □

---

### Exercise 2: Graph of g(h) = hM₂/2 + δ/h

**Function:** g(h) = hM₂/2 + δ/h

**Derivative:** g'(h) = M₂/2 - δ/h²

**Critical point:** g'(h) = 0 ⟹ h² = 2δ/M₂

**Optimal step size:**
$$h_{opt} = \sqrt{\frac{2\delta}{M_2}}$$

**Second derivative:** g''(h) = 2δ/h³ > 0 for h > 0

**Therefore, hₒₚₜ is a minimum.**

**Minimum value:**
$$g(h_{opt}) = \sqrt{\frac{2\delta}{M_2}}\frac{M_2}{2} + \frac{\delta}{\sqrt{2\delta/M_2}} = \sqrt{2\delta M_2}$$

---

### Exercise 3: Optimal Step Size Calculation

**For Example 10.2:** y' = 2y - 10t² + 2t, y(0) = 1

M₂ = 10 (from y'' = 10)
δ = 0.00001 = 10⁻⁵

**Optimal step size:**
$$h_{opt} = \sqrt{\frac{2 \cdot 10^{-5}}{10}} = \sqrt{2 \cdot 10^{-6}} \approx 0.00141$$

**Minimum total error:**
$$g(h_{opt}) = \sqrt{2 \cdot 10^{-5} \cdot 10} = \sqrt{2 \cdot 10^{-4}} \approx 0.0141$$

**Interpretation:** Using h < 0.0014 would actually increase total error due to rounding!

---

## Section 10.4 Exercises

### Exercise 1: Taylor's Method Applications

**(a) Second-order Taylor for y' = 2y - 10t² + 2t**

f(t, y) = 2y - 10t² + 2t
f⁽¹⁾(t, y) = 2y' - 20t + 2 = 2(2y - 10t² + 2t) - 20t + 2 = 4y - 20t² - 16t + 2

**Method:**
$$z_{i+1} = z_i + h(2z_i - 10t_i^2 + 2t_i) + \frac{h^2}{2}(4z_i - 20t_i^2 - 16t_i + 2)$$

With h = 0.2, z₀ = 1:
```
t₀ = 0.0:  z₀ = 1.0000
t₁ = 0.2:  z₁ = 1 + 0.2(2) + 0.02(4 - 0 + 2) = 1 + 0.4 + 0.12 = 1.5200
t₂ = 0.4:  z₂ = 1.52 + 0.2(2·1.52 - 0.4 + 0.4) + 0.02(4·1.52 - 3.2 - 6.4 + 2)
                = 1.52 + 0.608 + 0.02(6.08 - 7.6) = 1.52 + 0.608 - 0.0304 = 2.0976
...
```

Compare to Euler: much more accurate!

---

**(b) Third-order Taylor**

f⁽²⁾(t, y) = 4y' - 40t - 16 = 4(2y - 10t² + 2t) - 40t - 16 = 8y - 40t² - 32t - 16

**Method:**
$$z_{i+1} = z_i + hf + \frac{h^2}{2}f^{(1)} + \frac{h^3}{6}f^{(2)}$$

With h = 0.2:
```
t₀ = 0.0:  z₀ = 1.0000
t₁ = 0.2:  z₁ = 1 + 0.2(2) + 0.02(6) + 0.00133(-8) = 1 + 0.4 + 0.12 - 0.0107 = 1.5093
...
```

Even more accurate!

---

### Exercise 2: Fourth and Fifth-Order Taylor

**Fourth-order:**
$$z_{i+1} = z_i + hf + \frac{h^2}{2}f^{(1)} + \frac{h^3}{6}f^{(2)} + \frac{h^4}{24}f^{(3)}$$

Need f⁽³⁾:
f⁽³⁾(t, y) = 8y' - 80t - 32 = 8(2y - 10t² + 2t) - 80t - 32 = 16y - 80t² - 64t - 32

**Fifth-order:**
$$z_{i+1} = z_i + hf + \frac{h^2}{2}f^{(1)} + \frac{h^3}{6}f^{(2)} + \frac{h^4}{24}f^{(3)} + \frac{h^5}{120}f^{(4)}$$

Need f⁽⁴⁾:
f⁽⁴⁾(t, y) = 16y' - 160t - 64 = 16(2y - 10t² + 2t) - 160t - 64 = 32y - 160t² - 128t - 64

**Observation:** Derivatives get increasingly complicated! This is why Runge-Kutta is preferred.

---

## Section 10.5 Exercises

### Exercise 1: Runge-Kutta Methods

Apply midpoint, modified Euler, Heun, and RK4 to ODEs from Section 10.2.

**For y' = 2y - 10t² + 2t, y(0) = 1:**

**Midpoint method:**
```
k₁ = f(tᵢ, zᵢ) = 2zᵢ - 10tᵢ² + 2tᵢ
k₂ = f(tᵢ + h/2, zᵢ + hk₁/2)
zᵢ₊₁ = zᵢ + hk₂
```

**Modified Euler:**
```
k₁ = f(tᵢ, zᵢ)
k₂ = f(tᵢ + h, zᵢ + hk₁)
zᵢ₊₁ = zᵢ + (h/2)(k₁ + k₂)
```

**RK4:**
```
k₁ = f(tᵢ, zᵢ)
k₂ = f(tᵢ + h/2, zᵢ + hk₁/2)
k₃ = f(tᵢ + h/2, zᵢ + hk₂/2)
k₄ = f(tᵢ + h, zᵢ + hk₃)
zᵢ₊₁ = zᵢ + (h/6)(k₁ + 2k₂ + 2k₃ + k₄)
```

**Expected accuracy (at t=1, h=0.1):**
- Euler: O(h) ≈ 0.1 error
- Midpoint/Modified Euler/Heun: O(h²) ≈ 0.01 error
- RK4: O(h⁴) ≈ 0.0001 error

---

### Exercise 2: Lipschitz Continuity of Midpoint Method

**To prove:** F(t, z; h) = f(t + h/2, z + (h/2)f(t, z)) is Lipschitz in z.

**Proof:**

$$|F(t, z; h) - F(t, \tilde{z}; h)| = \left|f\left(t + \frac{h}{2}, z + \frac{h}{2}f(t, z)\right) - f\left(t + \frac{h}{2}, \tilde{z} + \frac{h}{2}f(t, \tilde{z})\right)\right|$$

By Lipschitz continuity of f:
$$\leq L\left|\left(z + \frac{h}{2}f(t, z)\right) - \left(\tilde{z} + \frac{h}{2}f(t, \tilde{z})\right)\right|$$

$$= L\left|z - \tilde{z} + \frac{h}{2}(f(t, z) - f(t, \tilde{z}))\right|$$

$$\leq L|z - \tilde{z}| + \frac{hL}{2}|f(t, z) - f(t, \tilde{z})|$$

$$\leq L|z - \tilde{z}| + \frac{hL^2}{2}|z - \tilde{z}|$$

$$= L\left(1 + \frac{hL}{2}\right)|z - \tilde{z}|$$

**Therefore, F is Lipschitz with constant L(1 + hL/2).** □

---

### Exercise 3: Derive Modified Euler from Trapezoidal Rule

**Trapezoidal rule:**
$$y(t_{i+1}) = y(t_i) + \frac{h}{2}[f(t_i, y(t_i)) + f(t_{i+1}, y(t_{i+1}))]$$

**Problem:** y(tᵢ₊₁) appears on both sides (implicit).

**Idea:** Replace y(tᵢ₊₁) on RHS with Euler predictor:
$$w_{i+1} = z_i + hf(t_i, z_i)$$

**Modified Euler:**
$$z_{i+1} = z_i + \frac{h}{2}[f(t_i, z_i) + f(t_{i+1}, w_{i+1})]$$

$$= z_i + \frac{h}{2}[f(t_i, z_i) + f(t_i + h, z_i + hf(t_i, z_i))]$$

**This is formula (10.29).** □

---

### Exercise 4: Special Case - All RK2 Methods Agree

**IVP:** y' = 2 - t - y, y(0) = 1

**f(t, y) = 2 - t - y is linear in y.**

**Midpoint:**
```
k₁ = 2 - tᵢ - zᵢ
k₂ = 2 - (tᵢ + h/2) - (zᵢ + hk₁/2)
   = 2 - tᵢ - h/2 - zᵢ - h(2 - tᵢ - zᵢ)/2
   = 2 - tᵢ - h/2 - zᵢ - h + htᵢ/2 + hzᵢ/2
zᵢ₊₁ = zᵢ + hk₂
```

**Modified Euler:**
```
k₁ = 2 - tᵢ - zᵢ
k₂ = 2 - (tᵢ + h) - (zᵢ + hk₁)
   = 2 - tᵢ - h - zᵢ - h(2 - tᵢ - zᵢ)
   = 2 - tᵢ - h - zᵢ - 2h + htᵢ + hzᵢ
zᵢ₊₁ = zᵢ + (h/2)(k₁ + k₂)
```

**Heun:**
```
k₁ = 2 - tᵢ - zᵢ
k₂ = 2 - (tᵢ + 2h/3) - (zᵢ + 2hk₁/3)
zᵢ₊₁ = zᵢ + (h/4)(k₁ + 3k₂)
```

**After simplification, all three give:**
$$z_{i+1} = (1 - h + h^2/2)z_i + h(2 - t_i) - h^2/2$$

**Therefore, all methods give identical results for linear ODEs!**

---

### Exercise 5: Geometric Interpretation of RK4

**RK4 uses four slope evaluations:**

1. **k₁:** Slope at beginning (tᵢ, zᵢ)
2. **k₂:** Slope at midpoint using k₁ prediction
3. **k₃:** Slope at midpoint using k₂ prediction (refined)
4. **k₄:** Slope at endpoint using k₃ prediction

**Weighted average:**
$$\text{slope} = \frac{k_1 + 2k_2 + 2k_3 + k_4}{6}$$

**Geometric picture:**
- k₁: tangent at start
- k₂, k₃: tangents at midpoint (k₃ is corrected)
- k₄: tangent at end
- Final step uses weighted average (midpoint slopes weighted more)

This is analogous to **Simpson's rule** for integration!

---

### Exercise 6: RK4 Reduces to Simpson's Rule

**If f depends only on t:** y' = f(t)

Then y(t) = y₀ + ∫f(t)dt

**RK4 becomes:**
```
k₁ = f(tᵢ)
k₂ = f(tᵢ + h/2)
k₃ = f(tᵢ + h/2)
k₄ = f(tᵢ + h)
```

**RK4 step:**
$$z_{i+1} = z_i + \frac{h}{6}[f(t_i) + 2f(t_i + h/2) + 2f(t_i + h/2) + f(t_i + h)]$$

$$= z_i + \frac{h}{6}[f(t_i) + 4f(t_i + h/2) + f(t_i + h)]$$

**This is exactly Simpson's rule for ∫ᵢᵢ₊₁f(t)dt!**

**Therefore, RK4 generalizes Simpson's rule to ODEs.** □

---

## Summary of Key Formulas

**Euler's method:**
$$z_{i+1} = z_i + hf(t_i, z_i)$$

**Taylor's method (order α):**
$$z_{i+1} = z_i + h\sum_{k=0}^{\alpha-1} \frac{h^k}{(k+1)!}f^{(k)}(t_i, z_i)$$

**RK4:**
$$z_{i+1} = z_i + \frac{h}{6}(k_1 + 2k_2 + 2k_3 + k_4)$$

**Error bounds:**
- Euler: O(h)
- Taylor (order α): O(hᵅ)
- RK2: O(h²)
- RK4: O(h⁴)

**Optimal step size:**
$$h_{opt} = \sqrt{\frac{2\delta}{M_2}}$$
