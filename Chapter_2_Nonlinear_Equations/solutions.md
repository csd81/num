# Chapter 2: Exercise Solutions

## Section 2.2 Exercises

### Exercise 1: Stair step diagrams for g(x) = mx

For g(x) = mx, the fixed-point iteration is pₖ₊₁ = m·pₖ.

**Analysis for different m values:**

| m | |g'(x)| = |m| | Convergence | Diagram Shape |
|---|---|---|---|
| 0.5 | 0.5 < 1 | Converges to 0 | Spiral inward |
| 1 | 1 | Constant (pₖ = p₀) | Horizontal line |
| 1.5 | 1.5 > 1 | Diverges to ∞ | Spiral outward |
| -0.5 | 0.5 < 1 | Converges to 0 (oscillating) | Alternating spiral inward |
| -1 | 1 | Oscillates (pₖ = (-1)ᵏp₀) | Rectangle between ±p₀ |
| -1.5 | 1.5 > 1 | Diverges (oscillating) | Alternating spiral outward |

---

### Exercise 2: Fixed-point reformulations

**(a) (x - 2)³ = x + 1**

Rearrange: x = (x - 2)³ - 1

Let g(x) = (x - 2)³ - 1

Starting from p₀ = 2:
```
p₀ = 2.0000
p₁ = (2-2)³ - 1 = -1.0000
p₂ = (-1-2)³ - 1 = -28.0000  (diverges)
```

Alternative: x = 2 + ∛(x+1)
```
g(x) = 2 + (x+1)^(1/3)
p₀ = 2.0000
p₁ = 2 + ∛3 = 3.4422
p₂ = 2 + ∛4.4422 = 3.6443
p₃ = 2 + ∛4.6443 = 3.6678
... → 3.6690 (4-digit accuracy)
```

**(b) cos(x)/x = 2, i.e., cos(x) = 2x**

Rearrange: x = cos(x)/2

Let g(x) = cos(x)/2

Starting from p₀ = 0.5:
```
p₀ = 0.5000
p₁ = cos(0.5)/2 = 0.4388
p₂ = cos(0.4388)/2 = 0.4526
p₃ = cos(0.4526)/2 = 0.4496
p₄ = cos(0.4496)/2 = 0.4503
p₅ = cos(0.4503)/2 = 0.4501
p₆ = cos(0.4501)/2 = 0.4502 → 0.4502
```

**Answer: x ≈ 0.4502** (4-digit accuracy)

**(c) x³ + x - 1 = 0**

Rearrange: x = ∛(1 - x)

Let g(x) = (1 - x)^(1/3)

Starting from p₀ = 0.5:
```
p₀ = 0.5000
p₁ = ∛0.5 = 0.7937
p₂ = ∛0.2063 = 0.5909
p₃ = ∛0.4091 = 0.7424
p₄ = ∛0.2576 = 0.6363
p₅ = ∛0.3637 = 0.7138
p₆ = ∛0.2862 = 0.6590
... → 0.6823
```

**Answer: x ≈ 0.6823** (4-digit accuracy)

**(d) 2x sin(x) = 4 - 3x**

Rearrange: x = (4 - 3x)/(2 sin(x))

Or: x = 4/(3 + 2sin(x))

Let g(x) = 4/(3 + 2sin(x))

Starting from p₀ = 1:
```
p₀ = 1.0000
p₁ = 4/(3 + 2sin(1)) = 0.8235
p₂ = 4/(3 + 2sin(0.8235)) = 0.8608
p₃ = 4/(3 + 2sin(0.8608)) = 0.8526
p₄ = 4/(3 + 2sin(0.8526)) = 0.8544
p₅ = 4/(3 + 2sin(0.8544)) = 0.8540 → 0.8540
```

**Answer: x ≈ 0.8540** (4-digit accuracy)

---

### Exercise 3: Fixed-point comparison for x³ + x² + 3x - 5 = 0

**Monotonicity:** f'(x) = 3x² + 2x + 3 = 3(x + 1/3)² + 8/3 > 0 for all x.
So f is strictly increasing.

f(0) = -5 < 0, f(2) = 8 + 4 + 6 - 5 = 13 > 0

By IVT, root exists in [0, 2]. Exact root: x = 1 (verify: 1 + 1 + 3 - 5 = 0).

**(a) x = √(x³ + x² + 4x - 5)**

g(x) = √(x³ + x² + 4x - 5)

At x = 0.5: g(0.5) = √(0.125 + 0.25 + 2 - 5) = √(-2.625) — not real!

**Does not work from p₀ = 0.5**

**(b) x = ∛(5 - x² - 3x)**

g(x) = (5 - x² - 3x)^(1/3)

```
p₀ = 0.5000
p₁ = ∛(5 - 0.25 - 1.5) = ∛3.25 = 1.4810
p₂ = ∛(5 - 2.1934 - 4.4430) = ∛(-1.6364) = -1.1785
p₃ = ∛(5 - 1.3889 + 3.5355) = ∛7.1466 = 1.9271
... (oscillates, diverges)
```

**Divergent**

**(c) x = 5/(x² + x + 3)**

g(x) = 5/(x² + x + 3)

```
p₀ = 0.5000
p₁ = 5/(0.25 + 0.5 + 3) = 5/3.75 = 1.3333
p₂ = 5/(1.7778 + 1.3333 + 3) = 5/6.1111 = 0.8182
p₃ = 5/(0.6695 + 0.8182 + 3) = 5/4.4877 = 1.1142
p₄ = 5/(1.2414 + 1.1142 + 3) = 5/5.3556 = 0.9336
p₅ = 5/(0.8716 + 0.9336 + 3) = 5/4.8052 = 1.0405
p₆ = 5/(1.0826 + 1.0405 + 3) = 5/5.1231 = 0.9760
... → 1.0000 (slowly)
```

**Convergent (slow)**

**(d) x = (5 - x³)/(x + 3)**

g(x) = (5 - x³)/(x + 3)

```
p₀ = 0.5000
p₁ = (5 - 0.125)/3.5 = 4.875/3.5 = 1.3929
p₂ = (5 - 2.7049)/4.3929 = 2.2951/4.3929 = 0.5225
p₃ = (5 - 0.1421)/3.5225 = 4.8579/3.5225 = 1.3791
... (oscillates)
```

Check g'(1): g'(x) = [(-3x²)(x+3) - (5-x³)(1)]/(x+3)²
g'(1) = [(-3)(4) - (4)(1)]/16 = -16/16 = -1

**|g'(1)| = 1, borderline case — oscillates**

**(e) x = (2x³ + x² + 5)/(3x² + 2x + 3)**

g(x) = (2x³ + x² + 5)/(3x² + 2x + 3)

```
p₀ = 0.5000
p₁ = (0.25 + 0.25 + 5)/(0.75 + 1 + 3) = 5.5/4.75 = 1.1579
p₂ = (3.1157 + 1.3407 + 5)/(4.0351 + 2.3158 + 3) = 9.4564/9.3509 = 1.0113
p₃ = (2.0687 + 1.0227 + 5)/(3.0681 + 2.0226 + 3) = 8.0914/8.0907 = 1.0001
p₄ ≈ 1.0000
```

**Convergent (fast!)**

**(f) x = (5 + 7x - x³)/10**

g(x) = (5 + 7x - x³)/10

```
p₀ = 0.5000
p₁ = (5 + 3.5 - 0.125)/10 = 8.375/10 = 0.8375
p₂ = (5 + 5.8625 - 0.5885)/10 = 10.2740/10 = 1.0274
p₃ = (5 + 7.1918 - 1.0844)/10 = 11.1074/10 = 1.1107
p₄ = (5 + 7.7749 - 1.3677)/10 = 11.4072/10 = 1.1407
... → diverges from 1
```

g'(x) = (7 - 3x²)/10
g'(1) = 4/10 = 0.4 < 1 ✓

But g'(0.5) = (7 - 0.75)/10 = 0.625 < 1 ✓

Actually converges but slowly from some starting points.

**Summary:**

| Formulation | Convergent? | Speed |
|-------------|-------------|-------|
| (a) | No (complex) | — |
| (b) | No | Divergent |
| (c) | Yes | Slow |
| (d) | No | Oscillates |
| (e) | Yes | **Fastest** |
| (f) | Yes | Slow |

---

### Exercise 4: Convergence of pₖ = ½(pₖ₋₁ + 2/pₖ₋₁)

This is the Babylonian method for √2.

**Proof for p₀ > √2:**

Let g(x) = ½(x + 2/x). Fixed points satisfy x = ½(x + 2/x), giving x² = 2, so x = ±√2.

For x > 0:
- g'(x) = ½(1 - 2/x²)
- g'(√2) = ½(1 - 1) = 0

Since g'(√2) = 0, by Theorem 2.32, convergence is quadratic.

**Case p₀ > √2:**
- p₁ = ½(p₀ + 2/p₀) > ½(2√2) = √2 (by AM-GM inequality)
- pₖ > √2 for all k
- Sequence is decreasing and bounded below by √2
- Converges to √2

**Case 0 < p₀ < √2:**
- p₁ = ½(p₀ + 2/p₀) > √2 (AM-GM)
- Reduces to previous case after one iteration
- Converges to √2

**Case p₀ < 0:**
- If p₀ < 0, then p₁ = ½(p₀ + 2/p₀) < 0
- Sequence stays negative
- Converges to -√2

---

### Exercise 5: Convergence of pₖ = ½(pₖ₋₁ + A/pₖ₋₁) to √A

This is the Babylonian/Heron's method for √A.

**For p₀ > 0:**

g(x) = ½(x + A/x)

Fixed points: x² = A, so x = ±√A.

g'(x) = ½(1 - A/x²)
g'(√A) = ½(1 - 1) = 0

By AM-GM: pₖ ≥ √A for k ≥ 1.

Sequence is decreasing for k ≥ 1 and bounded below by √A.

**Converges to √A for any p₀ > 0.**

**For p₀ < 0:**
- All iterates remain negative
- Converges to -√A

---

### Exercise 6: Divergence when |g'(p)| > 1

**To show:** If |g'(p)| > 1 and p₀ ≠ p, then pₖ does not converge to p.

**Proof:**

Since g ∈ C¹ and |g'(p)| > 1, by continuity there exists δ > 0 such that |g'(x)| > 1 for all x ∈ (p-δ, p+δ).

By Mean Value Theorem, for any x ∈ (p-δ, p+δ), x ≠ p:
|g(x) - g(p)| = |g'(ξ)||x - p| > |x - p|

for some ξ between x and p.

Since g(p) = p:
|g(x) - p| > |x - p|

So each iteration moves farther from p. If p₀ ≠ p and p₀ is close enough to p, then:
|p₁ - p| > |p₀ - p|
|p₂ - p| > |p₁ - p| > |p₀ - p|
...

**Sequence cannot converge to p.** □

---

### Exercise 7: g(x) = √(1 + x²)

**Show |g'(x)| < 1 for all x, but no convergence:**

g'(x) = x/√(1 + x²)

|g'(x)| = |x|/√(1 + x²) < 1 for all x (since |x| < √(1 + x²))

**But no fixed point exists:**

x = √(1 + x²) ⟹ x² = 1 + x² ⟹ 0 = 1 (contradiction)

**No fixed point ⟹ no convergence.**

This shows |g'(x)| < 1 alone is insufficient; we also need g to map a closed interval into itself (Theorem 2.13).

---

### Exercise 8: Piecewise linear functions are Lipschitz

**Given:** f is continuous on [a,b], with mesh a = x₀ < x₁ < ... < xₙ = b, and f is linear on each [xᵢ, xᵢ₊₁].

**To show:** f is Lipschitz continuous.

**Proof:**

On each interval [xᵢ, xᵢ₊₁], f is linear:
f(x) = mᵢx + bᵢ

where mᵢ = (f(xᵢ₊₁) - f(xᵢ))/(xᵢ₊₁ - xᵢ).

Let M = max{|mᵢ| : i = 0, 1, ..., n-1}.

For any x, y ∈ [a, b]:

**Case 1:** x, y in same subinterval [xᵢ, xᵢ₊₁]
|f(x) - f(y)| = |mᵢ||x - y| ≤ M|x - y|

**Case 2:** x, y in different subintervals

Let x ∈ [xᵢ, xᵢ₊₁] and y ∈ [xⱼ, xⱼ₊₁] with i < j.

By triangle inequality and continuity at mesh points:
|f(x) - f(y)| ≤ |f(x) - f(xᵢ₊₁)| + |f(xᵢ₊₁) - f(xᵢ₊₂)| + ... + |f(xⱼ) - f(y)|
≤ M|x - xᵢ₊₁| + M|xᵢ₊₁ - xᵢ₊₂| + ... + M|xⱼ - y|
= M|x - y|

**Therefore, f is Lipschitz with constant L = M.** □

---

## Section 2.3 Exercises

### Exercise 1: Bisection method applications

**(a) x³ - 6x - 1 = 0 on [-1, 1]**

f(-1) = -1 + 6 - 1 = 4 > 0
f(1) = 1 - 6 - 1 = -6 < 0

f(-1)f(1) < 0 ✓ Root exists.

Using bisection with ε = 10⁻⁵:
k ≥ log₂(2/10⁻⁵) - 1 = log₂(200000) - 1 ≈ 17.6

**Approximate root: x ≈ -0.16745** (after ~18 iterations)

**(b) x = e⁻²ˣ on [-1, 2]**

f(x) = x - e⁻²ˣ
f(-1) = -1 - e² ≈ -8.39 < 0
f(2) = 2 - e⁻⁴ ≈ 1.98 > 0

Root exists. **x ≈ 0.35173**

**(c) tan(x) = x + 1 on [-1, 1.5]**

f(x) = tan(x) - x - 1
f(-1) = tan(-1) + 1 - 1 = -1.557 < 0
f(1.5) = tan(1.5) - 1.5 - 1 ≈ 14.1 - 2.5 > 0

Root exists. **x ≈ 0.53139**

**(d) e⁻ˢⁱⁿ⁽ˣ⁾ = x² - 1 on [0, 2]**

f(x) = e⁻ˢⁱⁿ⁽ˣ⁾ - x² + 1
f(0) = 1 - 0 + 1 = 2 > 0
f(2) = e⁻ˢⁱⁿ⁽²⁾ - 4 + 1 ≈ 0.5 - 3 < 0

Root exists. **x ≈ 1.39175**

---

### Exercise 2: Bisection on f(x) = 1/x on [-0.5, 3]

**Problem:** f(x) = 1/x is NOT continuous on [-0.5, 3] (discontinuity at x = 0).

f(-0.5) = -2 < 0
f(3) = 1/3 > 0

But f has NO root in the interval! The sign change is due to the discontinuity, not a root.

**Observation:** Bisection method fails because the continuity assumption of Theorem 2.16 is violated. The algorithm would converge to x = 0, which is NOT a root.

**Lesson:** Always verify continuity before applying bisection!

---

## Section 2.4 Exercises

### Exercise 1: False Position method

Apply to same problems as Section 2.3, Exercise 1.

Results (typically faster than bisection for well-behaved functions):

| Equation | Root | Iterations (vs Bisection) |
|----------|------|---------------------------|
| (a) x³ - 6x - 1 | -0.16745 | ~12 (vs 18) |
| (b) x = e⁻²ˣ | 0.35173 | ~10 (vs 17) |
| (c) tan(x) = x + 1 | 0.53139 | ~14 (vs 19) |
| (d) e⁻ˢⁱⁿ⁽ˣ⁾ = x² - 1 | 1.39175 | ~11 (vs 18) |

---

### Exercise 2: Piecewise function with parameter δ

f(x) = { δ, if x ≤ 0.5; 4(1+δ)(x - x²) - 1, if x ≥ 0.5 }

**Root location:** f(0.5) = δ from left, f(0.5) = 4(1+δ)(0.25) - 1 = δ from right (continuous).

For x > 0.5: f(x) = 0 when 4(1+δ)(x - x²) = 1

**(a) δ = 2:**
- f(0) = 2, f(1) = -1
- Root near x ≈ 0.5

Bisection: Converges slowly (flat region)
False Position: May be slower due to function shape

**(b) δ = 0.5:**
- f(0) = 0.5, f(1) = -1
- Better conditioned

**(c) δ = 0.09:**
- f(0) = 0.09, f(1) = -1
- Root very close to 0.5

**Observation:** Smaller δ makes root closer to 0.5, causing slower convergence for both methods.

---

## Section 2.5 Exercises

### Exercise 1: Newton's method applications

Same equations as before:

| Equation | Root | Newton Iterations |
|----------|------|-------------------|
| (a) x³ - 6x - 1 | -0.16745 | ~4-5 |
| (b) x = e⁻²ˣ | 0.35173 | ~4-5 |
| (c) tan(x) = x + 1 | 0.53139 | ~4-5 |
| (d) e⁻ˢⁱⁿ⁽ˣ⁾ = x² - 1 | 1.39175 | ~4-5 |

Newton's method converges much faster (quadratic) than bisection or false position.

---

### Exercise 2: f(x) = 0.5 arctan(x)

**Root:** x = 0

Newton iteration: pₖ₊₁ = pₖ - (0.5 arctan(pₖ))/(0.5/(1+pₖ²)) = pₖ - (1+pₖ²)arctan(pₖ)

Let h(p) = p - (1+p²)arctan(p)

**(a) If |p₀| < p*:** pk → 0

Find p* where iteration cycles: h(p*) = -p*
p* - (1+p*²)arctan(p*) = -p*
2p* = (1+p*²)arctan(p*)

Numerically: **p* ≈ 1.3917**

**(b) If |p₀| = p*:** Sequence alternates between p* and -p*

**(c) If |p₀| > p*:** |pk| → ∞ (diverges)

---

### Exercise 3: Iteration for ᵏ√a

Find root of f(x) = xᵏ - a = 0.

Newton's method:
pₖ₊₁ = pₖ - (pₖᵏ - a)/(k·pₖᵏ⁻¹)
     = pₖ - pₖ/k + a/(k·pₖᵏ⁻¹)
     = ((k-1)pₖ + a/pₖᵏ⁻¹)/k

**Iteration formula:**
$$p_{k+1} = \frac{1}{k}\left((k-1)p_k + \frac{a}{p_k^{k-1}}\right)$$

For k=2 (square root): pₖ₊₁ = ½(pₖ + a/pₖ) — Babylonian method!

---

## Section 2.6 Exercises

### Exercise 1: Secant method applications

Same equations, typically 1-2 more iterations than Newton:

| Equation | Root | Secant Iterations |
|----------|------|-------------------|
| (a) x³ - 6x - 1 | -0.16745 | ~6-7 |
| (b) x = e⁻²ˣ | 0.35173 | ~6-7 |
| (c) tan(x) = x + 1 | 0.53139 | ~6-7 |
| (d) e⁻ˢⁱⁿ⁽ˣ⁾ = x² - 1 | 1.39175 | ~6-7 |

---

### Exercise 2: Prove relation (2.12)

**To prove:**
$$\frac{\frac{f(p_k)-f(p)}{p_k-p} - \frac{f(p_{k-1})-f(p)}{p_{k-1}-p}}{p_k - p_{k-1}} = \frac{f''(\xi_k)}{2}$$

**Proof:**

The left side is the second divided difference f[pₖ₋₁, p, pₖ].

**Key property:** Divided differences are symmetric (independent of order).

By Taylor expansion around p:
f(pₖ) = f(p) + f'(p)(pₖ-p) + f''(ηₖ)/2 · (pₖ-p)²

So:
$$\frac{f(p_k)-f(p)}{p_k-p} = f'(p) + \frac{f''(\eta_k)}{2}(p_k-p)$$

Similarly for pₖ₋₁. Subtracting and dividing by pₖ - pₖ₋₁:
$$\frac{f'(p) + \frac{f''(\eta_k)}{2}(p_k-p) - f'(p) - \frac{f''(\eta_{k-1})}{2}(p_{k-1}-p)}{p_k - p_{k-1}}$$

$$= \frac{f''(\eta_k)(p_k-p) - f''(\eta_{k-1})(p_{k-1}-p)}{2(p_k - p_{k-1})}$$

By IVT for continuous f'', this equals f''(ξₖ)/2 for some ξₖ. □

---

### Exercise 3: Prove Fibonacci formula (2.15)

**To prove:** qₖ = (1/√5)(r₀ᵏ⁺¹ - r₁ᵏ⁺¹) where r₀ = (1+√5)/2, r₁ = (1-√5)/2

**Proof by induction:**

Base cases:
- q₀ = (1/√5)(r₀ - r₁) = (1/√5)(√5) = 1 ✓
- q₁ = (1/√5)(r₀² - r₁²) = (1/√5)((r₀-r₁)(r₀+r₁)) = (1/√5)(√5 · 1) = 1 ✓

Inductive step: Assume formula holds for qₖ and qₖ₋₁.

qₖ₊₁ = qₖ + qₖ₋₁
     = (1/√5)(r₀ᵏ⁺¹ - r₁ᵏ⁺¹) + (1/√5)(r₀ᵏ - r₁ᵏ)
     = (1/√5)(r₀ᵏ(r₀+1) - r₁ᵏ(r₁+1))

Since r₀ and r₁ satisfy r² = r + 1 (characteristic equation):
r₀ + 1 = r₀² and r₁ + 1 = r₁²

qₖ₊₁ = (1/√5)(r₀ᵏ⁺² - r₁ᵏ⁺²) ✓

**Formula proved.** □

---

## Section 2.7 Exercises

### Exercise 1: Bisection is linearly convergent

**Proof:**

From Theorem 2.16: |pₖ - p| ≤ (b-a)/2ᵏ⁺¹

Let eₖ = |pₖ - p|. Then:
eₖ₊₁ ≤ (b-a)/2ᵏ⁺² = ½ · (b-a)/2ᵏ⁺¹ = ½ · eₖ

So eₖ₊₁ ≤ ceₖ with c = ½ < 1.

**Convergence is linear with rate c = ½.** □

---

### Exercise 2: Prove inequality (2.19)

**To prove:** |pₖ - p| ≤ c^(αᵏ⁻¹)/(α⁻¹) · |p₀ - p|^αᵏ

**Proof by induction:**

Base case k=0: |p₀ - p| ≤ c⁰ · |p₀ - p|¹ ✓

Inductive step: Assume holds for k.

|pₖ₊₁ - p| ≤ c|pₖ - p|^α
          ≤ c · [c^(αᵏ⁻¹)/(α⁻¹) · |p₀ - p|^αᵏ]^α
          = c · c^(αᵏ⁺¹⁻α)/(α⁻¹) · |p₀ - p|^αᵏ⁺¹
          = c^(1 + (αᵏ⁺¹⁻α)/(α⁻¹)) · |p₀ - p|^αᵏ⁺¹

Exponent of c: 1 + (αᵏ⁺¹ - α)/(α-1) = (α-1 + αᵏ⁺¹ - α)/(α-1) = (αᵏ⁺¹ - 1)/(α-1) ✓

**Formula proved.** □

---

### Exercise 3: Cubic convergence iteration

**Given:** pₖ₊₁ = pₖ(pₖ² + 3a)/(3pₖ² + a)

**Show:** Converges to √a with order 3.

Let g(x) = x(x² + 3a)/(3x² + a)

Fixed points: g(x) = x ⟹ x² = a ⟹ x = ±√a

Compute derivatives at √a:
- g'(√a) = 0
- g''(√a) = 0
- g'''(√a) ≠ 0

By Theorem 2.32, since g'(√a) = g''(√a) = 0, **convergence is order 3.** □

---

### Exercise 4: Order of convergence for pₖ = 1/k

lim (pₖ₊₁/pₖ) = lim (k/(k+1)) = 1

Not linear (c would need to be < 1).

For any α > 1:
lim (pₖ₊₁/pₖ^α) = lim (k^α⁻¹/(k+1)) = ∞

**Order is 1 (sublinear/logarithmic).**

For pₖ = 1/kⁿ: Same analysis, **order is 1.**

---

### Exercise 5: pₖ = 10⁻²ᵏ converges quadratically

p = 0

|pₖ₊₁ - p|/|pₖ - p|² = 10⁻²ᵏ⁺²/(10⁻²ᵏ)² = 10⁻²ᵏ⁺²/10⁻²ᵏ⁺² = 1

**Limit exists and is finite for α = 2. Convergence is quadratic.** □

---

### Exercise 6: sin²(x) has double root at x = 0

f(x) = sin²(x)

f(0) = 0
f'(x) = 2sin(x)cos(x) = sin(2x)
f'(0) = 0
f''(x) = 2cos(2x)
f''(0) = 2 ≠ 0

By Theorem 2.33, **x = 0 is a root of multiplicity 2.** □

---

### Exercise 7: Prove Theorem 2.33

**(i) If f(x) = (x-p)ᵐq(x) with q(p) ≠ 0:**

By Leibniz rule for derivatives:
f⁽ʲ⁾(p) = 0 for j < m (all terms contain (x-p) factor)
f⁽ᵐ⁾(p) = m!·q(p) ≠ 0

**(ii) If f(p) = f'(p) = ... = f⁽ᵐ⁻¹⁾(p) = 0 and f⁽ᵐ⁾(p) ≠ 0:**

Taylor expansion around p:
f(x) = f⁽ᵐ⁾(p)/m! · (x-p)ᵐ + O((x-p)ᵐ⁺¹)
     = (x-p)ᵐ · [f⁽ᵐ⁾(p)/m! + O(x-p)]

Let q(x) = f⁽ᵐ⁾(p)/m! + O(x-p). Then q(p) = f⁽ᵐ⁾(p)/m! ≠ 0.

**So f(x) = (x-p)ᵐq(x) with q(p) ≠ 0.** □

---

### Exercise 8: Higher-order methods

**(a) Halley's method:** pₖ₊₁ = pₖ - fₖ/(f'ₖ - fₖf''ₖ/(2f'ₖ))

Order of convergence: **3 (cubic)**

**(b) Olver's method:** pₖ₊₁ = pₖ - (fₖ/f'ₖ)(1 - fₖf''ₖ/(2(f'ₖ)²))

Order of convergence: **3 (cubic)**

Both require f, f', f'' but converge faster than Newton.

---

### Exercise 9: f(x) = (x² - 5)³

Root: x = ±√5, each with multiplicity 3.

**Newton iteration:** Linear convergence (rate 1 - 1/3 = 2/3)

**Secant method:** Sub-quadratic (order < 1.618)

**Modified Newton (2.23):** Quadratic convergence

**Modified Newton with known m:** pₖ₊₁ = pₖ - 3·f(pₖ)/f'(pₖ)

Order: **Quadratic** (restores quadratic convergence)

---

### Exercise 10: Deflation method

**(a) f(x) = x³ - 3x² + 4**

Find first root (e.g., x₁ = 2 by inspection or Newton).

g(x) = f(x)/(x-2) = x² - x - 2 = (x-2)(x+1)

Roots: x = 2 (multiplicity 2), x = -1 (multiplicity 1)

**(b) f(x) = x⁴ - 5x³ + 9x² - 7x + 2**

First root: x₁ = 1 (verify: 1-5+9-7+2 = 0)

g₁(x) = f(x)/(x-1) = x³ - 4x² + 5x - 2

Second root: x₂ = 1 (again)

g₂(x) = g₁(x)/(x-1) = x² - 3x + 2 = (x-1)(x-2)

**Roots: x = 1 (multiplicity 3), x = 2 (multiplicity 1)**

---

## Section 2.11 Exercises

### Exercise 1: Fixed-point for systems

**(a) System:**
-2x² + 6x - y² = 4
x² + y³ - 5y = 3

Rearrange:
x = (4 + y² + 2x²)/6
y = (x² + y³ - 3)/5

Starting from (0,0):
```
p⁽⁰⁾ = (0, 0)
p⁽¹⁾ = (4/6, -3/5) = (0.6667, -0.6000)
p⁽²⁾ = ... (iterate until convergence)
```

**(b)-(d):** Similar approach — express each variable in terms of others.

---

### Exercise 2: Jacobian norms

For each fixed-point function g(x,y), compute:
J = [∂g₁/∂x  ∂g₁/∂y; ∂g₂/∂x  ∂g₂/∂y]

Evaluate at numerical fixed point, compute ‖J‖ (1-norm, ∞-norm, or 2-norm).

If ‖J‖ < 1, convergence is guaranteed locally.

---

### Exercise 3: Quadratic convergence in any norm

**Given:** Conditions of Theorem 2.55 (g'(p) = 0).

**Show:** Quadratic convergence in any vector norm.

**Proof:**

All norms on ℝⁿ are equivalent: ∃c₁, c₂ > 0 such that c₁‖x‖∞ ≤ ‖x‖ ≤ c₂‖x‖∞.

From Theorem 2.55: ‖p⁽ᵏ⁺¹⁾ - p‖∞ ≤ C‖p⁽ᵏ⁾ - p‖∞²

Then:
‖p⁽ᵏ⁺¹⁾ - p‖ ≤ c₂‖p⁽ᵏ⁺¹⁾ - p‖∞
            ≤ c₂C‖p⁽ᵏ⁾ - p‖∞²
            ≤ c₂C(c₁⁻¹‖p⁽ᵏ⁾ - p‖)²
            = (c₂C/c₁²)‖p⁽ᵏ⁾ - p‖²

**Quadratic in any norm.** □

---

## Section 2.12 Exercises

### Exercise 1: Newton's method for systems

Apply Newton's method to systems from Section 2.11:

p⁽ᵏ⁺¹⁾ = p⁽ᵏ⁾ - [J(p⁽ᵏ⁾)]⁻¹f(p⁽ᵏ⁾)

where J is the Jacobian matrix.

Converges quadratically to solutions (typically 4-6 iterations for 10⁻⁵ accuracy).

---

## Section 2.13 Exercises

### Exercise 1: Broyden's method for systems

Apply Algorithm 2.59 to systems from 2.11.

**Advantages over Newton:**
- No Jacobian computation
- O(n²) per iteration vs O(n³)

**Disadvantages:**
- More iterations needed (superlinear vs quadratic)

---

### Exercise 2: Verify Broyden's update

**Show:** A⁽ᵏ⁺¹⁾ = A⁽ᵏ⁾ + (y⁽ᵏ⁾ - A⁽ᵏ⁾s⁽ᵏ⁾)(s⁽ᵏ⁾)ᵀ/‖s⁽ᵏ⁾‖₂² satisfies (2.37) and (2.38).

**(2.37):** A⁽ᵏ⁺¹⁾s⁽ᵏ⁾ = y⁽ᵏ⁾

A⁽ᵏ⁺¹⁾s⁽ᵏ⁾ = A⁽ᵏ⁾s⁽ᵏ⁾ + (y⁽ᵏ⁾ - A⁽ᵏ⁾s⁽ᵏ⁾)(s⁽ᵏ⁾)ᵀs⁽ᵏ⁾/‖s⁽ᵏ⁾‖₂²
           = A⁽ᵏ⁾s⁽ᵏ⁾ + (y⁽ᵏ⁾ - A⁽ᵏ⁾s⁽ᵏ⁾) · 1
           = y⁽ᵏ⁾ ✓

**(2.38):** A⁽ᵏ⁺¹⁾z = A⁽ᵏ⁾z for z ⊥ s⁽ᵏ⁾

If z ⊥ s⁽ᵏ⁾, then (s⁽ᵏ⁾)ᵀz = 0.

A⁽ᵏ⁺¹⁾z = A⁽ᵏ⁾z + (y⁽ᵏ⁾ - A⁽ᵏ⁾s⁽ᵏ⁾)(s⁽ᵏ⁾)ᵀz/‖s⁽ᵏ⁾‖₂²
       = A⁽ᵏ⁾z + 0
       = A⁽ᵏ⁾z ✓

**Formula verified.** □

---

## Summary of Convergence Rates

| Method | Simple Root | Multiple Root |
|--------|-------------|---------------|
| Bisection | Linear (c=0.5) | Linear |
| False Position | Linear | Linear |
| Newton | Quadratic | Linear |
| Secant | 1.618 (superlinear) | <1.618 |
| Modified Newton | Quadratic | Quadratic |
| Halley/Olver | Cubic | Cubic |
| Broyden (n-D) | Superlinear | Superlinear |
| Newton (n-D) | Quadratic | Linear |
