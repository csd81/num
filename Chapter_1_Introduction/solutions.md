# Chapter 1: Exercise Solutions

## Section 1.2 Exercises

### Exercise 1: Convert decimal numbers to binary form

**(a) 57**
```
57 ÷ 2 = 28 remainder 1
28 ÷ 2 = 14 remainder 0
14 ÷ 2 =  7 remainder 0
 7 ÷ 2 =  3 remainder 1
 3 ÷ 2 =  1 remainder 1
 1 ÷ 2 =  0 remainder 1
```
Reading remainders from bottom: **57 = (111001)₂**

**(b) -243**
First find binary of 243:
```
243 ÷ 2 = 121 remainder 1
121 ÷ 2 =  60 remainder 1
 60 ÷ 2 =  30 remainder 0
 30 ÷ 2 =  15 remainder 0
 15 ÷ 2 =   7 remainder 1
  7 ÷ 2 =   3 remainder 1
  3 ÷ 2 =   1 remainder 1
  1 ÷ 2 =   0 remainder 1
```
243 = (11110011)₂

For 8-bit two's-complement: -243 = 2⁸ - 243 = 256 - 243 = 13 = (00001101)₂

But since 243 > 127, we need at least 9 bits for magnitude. Using 9 bits:
-243 = 2⁹ - 243 = 512 - 243 = 269 = **(100001101)₂** (two's-complement)

**(c) 0.25**
```
0.25 × 2 = 0.5  → digit 0
0.5  × 2 = 1.0  → digit 1
```
**0.25 = (0.01)₂**

**(d) 35.27**
Integer part: 35 = (100011)₂

Fractional part 0.27:
```
0.27 × 2 = 0.54 → 0
0.54 × 2 = 1.08 → 1
0.08 × 2 = 0.16 → 0
0.16 × 2 = 0.32 → 0
0.32 × 2 = 0.64 → 0
0.64 × 2 = 1.28 → 1
0.28 × 2 = 0.56 → 0
0.56 × 2 = 1.12 → 1
0.12 × 2 = 0.24 → 0
0.24 × 2 = 0.48 → 0
0.48 × 2 = 0.96 → 0
0.96 × 2 = 1.92 → 1
...
```
**35.27 ≈ (100011.010001010001...)₂**

---

### Exercise 2: Convert binary numbers to decimal form

**(a) (101101)₂**
```
1×2⁵ + 0×2⁴ + 1×2³ + 1×2² + 0×2¹ + 1×2⁰
= 32 + 0 + 8 + 4 + 0 + 1 = 45
```
**(101101)₂ = 45**

**(b) (0.10011)₂**
```
1×2⁻¹ + 0×2⁻² + 0×2⁻³ + 1×2⁻⁴ + 1×2⁻⁵
= 0.5 + 0 + 0 + 0.0625 + 0.03125 = 0.59375
```
**(0.10011)₂ = 0.59375**

**(c) (1010.01101)₂**
```
Integer: 1×2³ + 0×2² + 1×2¹ + 0×2⁰ = 8 + 0 + 2 + 0 = 10
Fraction: 0×2⁻¹ + 1×2⁻² + 1×2⁻³ + 0×2⁻⁴ + 1×2⁻⁵
        = 0 + 0.25 + 0.125 + 0 + 0.03125 = 0.40625
```
**(1010.01101)₂ = 10.40625**

---

### Exercise 3: Two's-complement representation proof

**To prove:** The two's-complement of a negative integer -I can be computed by:
1. Take binary form of |I|
2. Flip all bits (0→1, 1→0)
3. Add 1

**Proof:**

Let I be a positive integer with m-bit binary representation. The two's-complement definition states:
$$C_2(-I) = 2^m - I$$

Now consider the bit-flipping operation. If I has binary representation with bits $b_{m-1}b_{m-2}...b_1b_0$, then:
$$I = \sum_{i=0}^{m-1} b_i 2^i$$

After flipping all bits, we get:
$$\text{flipped} = \sum_{i=0}^{m-1} (1-b_i) 2^i = \sum_{i=0}^{m-1} 2^i - \sum_{i=0}^{m-1} b_i 2^i = (2^m - 1) - I$$

Adding 1:
$$(2^m - 1) - I + 1 = 2^m - I = C_2(-I)$$

This proves the method is correct. □

---

### Exercise 4: Subtraction using two's-complement

**To show:** $I_1 - I_2$ can be computed as $I_1 + C_2(I_2)$ taking last m bits.

**Proof:**

Let $I_1, I_2$ be m-bit positive integers. By definition:
$$C_2(I_2) = 2^m - I_2 \quad \text{(for the representation of } -I_2\text{)}$$

Computing $I_1 + C_2(I_2)$:
$$I_1 + (2^m - I_2) = I_1 - I_2 + 2^m$$

Taking the last m bits is equivalent to computing modulo $2^m$:
$$(I_1 - I_2 + 2^m) \mod 2^m = (I_1 - I_2) \mod 2^m$$

If $I_1 \geq I_2$, then $0 \leq I_1 - I_2 < 2^m$, so the result is exactly $I_1 - I_2$.

If $I_1 < I_2$, the result is the two's-complement representation of the negative number $I_1 - I_2$.

This shows subtraction can be performed as addition with two's-complement. □

---

### Exercise 5: Prove Theorem 1.10

**Theorem:** For base b with t mantissa digits:
$$\varepsilon_m = \begin{cases} 2^{-t}, & \text{if } b = 2 \\ b^{1-t}, & \text{if } b \neq 2 \end{cases}$$

**Proof:**

Machine epsilon is the difference between 1 and the next larger machine number.

**Case b = 2:**
In binary, 1 = (1.000...0)₂ × 2⁰ with t mantissa bits.
The next machine number is (1.000...01)₂ × 2⁰ where the last bit is 1.
This equals $1 + 2^{-t}$.
Therefore, $\varepsilon_m = (1 + 2^{-t}) - 1 = 2^{-t}$.

**Case b ≠ 2:**
In base b, 1 = (1.000...0)ᵦ × b⁰ with t mantissa digits.
The next machine number is (1.000...1)ᵦ × b⁰ where the last digit is 1.
The last position represents $b^{-(t-1)} = b^{1-t}$.
Therefore, $\varepsilon_m = (1 + b^{1-t}) - 1 = b^{1-t}$. □

---

### Exercise 6: Machine epsilon code

```python
def find_machine_epsilon():
    """Find machine epsilon for floating-point arithmetic."""
    eps = 1.0
    while 1.0 + eps > 1.0:
        eps = eps / 2.0
    return eps * 2  # Last value where 1 + eps > 1

# For single precision (using numpy float32):
import numpy as np

def find_machine_epsilon_float32():
    eps = np.float32(1.0)
    while np.float32(1.0) + eps > np.float32(1.0):
        eps = np.float32(eps / 2.0)
    return np.float32(eps * 2)

# Results:
print(f"Double precision ε_m ≈ {find_machine_epsilon()}")
print(f"Expected: 2^(-52) ≈ {2**(-52)}")
print(f"Single precision ε_m ≈ {find_machine_epsilon_float32()}")
print(f"Expected: 2^(-23) ≈ {2**(-23)}")
```

**Expected output:**
- Double precision: εₘ ≈ 2.22×10⁻¹⁶ (= 2⁻⁵²)
- Single precision: εₘ ≈ 1.19×10⁻⁷ (= 2⁻²³)

---

### Exercise 7: Exact digits in double precision

Double precision uses t = 52 mantissa bits (plus 1 implicit leading bit = 53 significant bits).

Machine epsilon: εₘ = 2⁻⁵²

For decimal exact digits n, we need:
$$\frac{1}{2} \cdot 2^{-52} \leq \frac{1}{2} \cdot 10^{1-n}$$

Simplifying:
$$2^{-52} \leq 10^{1-n}$$
$$-52 \log_{10}(2) \leq 1 - n$$
$$n \leq 1 + 52 \log_{10}(2)$$
$$n \leq 1 + 52 \times 0.30103 = 1 + 15.65 = 16.65$$

**Answer:** Double precision is exact in **15-16 decimal digits** (typically quoted as 15-16 significant decimal digits).

---

### Exercise 8: Exact digits proof

**To show:** If x and x̃ agree in first m+1 digits, then x̃ approximates x with at least m exact digits.

**Proof:**

Let $x = (x_0.x_1x_2...x_m x_{m+1}...) \times 10^k$ and $\tilde{x} = (x_0.x_1x_2...x_m \tilde{x}_{m+1}...) \times 10^k$.

The difference is:
$$|x - \tilde{x}| = |0.00...0(x_{m+1}-\tilde{x}_{m+1})(x_{m+2}-\tilde{x}_{m+2})...| \times 10^k$$

where there are m zeros after the decimal point.

The maximum possible difference occurs when digits differ maximally:
$$|x - \tilde{x}| \leq 0.00...0999... \times 10^k < 0.00...1 \times 10^k = 10^{-m} \times 10^k$$

(since the difference is less than 1 in the (m+1)-th position)

The relative error:
$$\frac{|x - \tilde{x}|}{|x|} < \frac{10^{-m} \times 10^k}{x_0 \times 10^k} = \frac{10^{-m}}{x_0} \leq 10^{-m}$$

(since $x_0 \geq 1$)

For m exact digits, we need relative error ≤ ½ × 10¹⁻ᵐ.

Since $10^{-m} = 10 \times 10^{-(m+1)} < \frac{1}{2} \times 10^{1-m}$ for m ≥ 1, the approximation has at least m exact digits. □

---

## Section 1.3 Exercises

### Exercise 1: Error analysis

Given: x = 3.50, y = 10.00, x̃ = 3.47, ỹ = 10.02

**Error bounds:**
- Δx = |3.50 - 3.47| = 0.03
- Δy = |10.00 - 10.02| = 0.02
- δx = 0.03/3.50 = 0.00857 (0.857%)
- δy = 0.02/10.00 = 0.002 (0.2%)

**(a) 3x + 7y**

Estimated absolute error:
$$\Delta_{3x+7y} = 3\Delta_x + 7\Delta_y = 3(0.03) + 7(0.02) = 0.09 + 0.14 = 0.23$$

Exact values: 3(3.50) + 7(10.00) = 10.5 + 70 = 80.5
Approximate: 3(3.47) + 7(10.02) = 10.41 + 70.14 = 80.55
Actual error: |80.5 - 80.55| = 0.05 ✓ (within bound 0.23)

**(b) 4xy/(x+y)**

Let f = 4xy/(x+y).

Exact: 4(3.50)(10.00)/(13.50) = 140/13.50 = 10.370...
Approximate: 4(3.47)(10.02)/(13.49) = 139.0776/13.49 = 10.310...
Actual error: |10.370 - 10.310| = 0.060

Using error propagation (quotient rule):
Relative error ≈ δₓ + δᵧ + δ₍ₓ₊ᵧ₎ ≈ 0.00857 + 0.002 + max(δₓ, δᵧ) ≈ 0.0126

Estimated absolute error ≈ 10.37 × 0.0126 ≈ 0.13 ✓

**(c) x²**

Estimated absolute error: Δₓ² ≈ 2x·Δx = 2(3.50)(0.03) = 0.21

Exact: 3.50² = 12.25
Approximate: 3.47² = 12.0409
Actual error: |12.25 - 12.0409| = 0.2091 ✓

**(d) y³**

Estimated absolute error: Δᵧ³ ≈ 3y²·Δy = 3(100)(0.02) = 6

Exact: 10.00³ = 1000
Approximate: 10.02³ = 1006.012
Actual error: |1000 - 1006.012| = 6.012 ✓

**(e) 1/y**

Estimated absolute error: Δ₁/ᵧ ≈ Δy/y² = 0.02/100 = 0.0002

Exact: 1/10.00 = 0.1
Approximate: 1/10.02 = 0.0998...
Actual error: |0.1 - 0.0998| = 0.0002 ✓

---

### Exercise 2: Error bound for f(x)

**Given:** |x - x̃| ≤ Δₓ, |f'(x)| ≤ M for all x.

**To estimate:** Absolute error |f(x) - f(x̃)|

**Solution using Lagrange's Mean Value Theorem:**

By the Mean Value Theorem, there exists ξ between x and x̃ such that:
$$f(x) - f(\tilde{x}) = f'(\xi)(x - \tilde{x})$$

Taking absolute values:
$$|f(x) - f(\tilde{x})| = |f'(\xi)| \cdot |x - \tilde{x}|$$

Since |f'(ξ)| ≤ M and |x - x̃| ≤ Δₓ:
$$|f(x) - f(\tilde{x})| \leq M \cdot \Delta_x$$

**Answer:** The absolute error bound is **M · Δₓ**.

---

## Section 1.4 Exercises

### Exercise 1: Loss of significance analysis

**(a) ln x - 1**

- **Problem:** When ln x ≈ 1, i.e., x ≈ e ≈ 2.718
- **Solution:** Use Taylor expansion around x = e:
  $$\ln x - 1 = \ln x - \ln e = \ln(x/e) = \ln(1 + \frac{x-e}{e})$$
  For x close to e, use: $\ln(1+u) \approx u - u^2/2 + u^3/3 - ...$ where $u = \frac{x-e}{e}$

**(b) √(x+4) - 2**

- **Problem:** When x+4 ≈ 4, i.e., x ≈ 0
- **Solution:** Rationalize:
  $$\sqrt{x+4} - 2 = \frac{(\sqrt{x+4}-2)(\sqrt{x+4}+2)}{\sqrt{x+4}+2} = \frac{x+4-4}{\sqrt{x+4}+2} = \frac{x}{\sqrt{x+4}+2}$$

**(c) sin x - x**

- **Problem:** When x ≈ 0 (since sin x ≈ x for small x)
- **Solution:** Use Taylor series:
  $$\sin x - x = -\frac{x^3}{3!} + \frac{x^5}{5!} - \frac{x^7}{7!} + ...$$

**(d) 1 - cos x**

- **Problem:** When x ≈ 0 (since cos x ≈ 1 for small x)
- **Solution:** Use identity or Taylor series:
  $$1 - \cos x = 2\sin^2(x/2)$$
  Or: $1 - \cos x = \frac{x^2}{2!} - \frac{x^4}{4!} + \frac{x^6}{6!} - ...$

**(e) (1 - cos x)/sin x**

- **Problem:** When x ≈ 0 (both numerator and denominator approach 0)
- **Solution:** Use trigonometric identity:
  $$\frac{1-\cos x}{\sin x} = \frac{2\sin^2(x/2)}{2\sin(x/2)\cos(x/2)} = \tan(x/2)$$

**(f) (cos x - e⁻ˣ)/x**

- **Problem:** When x ≈ 0 (both cos x and e⁻ˣ approach 1)
- **Solution:** Use Taylor series:
  $$\cos x = 1 - \frac{x^2}{2!} + \frac{x^4}{4!} - ...$$
  $$e^{-x} = 1 - x + \frac{x^2}{2!} - \frac{x^3}{3!} + ...$$
  $$\cos x - e^{-x} = x - x^2 + \frac{x^3}{3!} + ...$$
  $$\frac{\cos x - e^{-x}}{x} = 1 - x + \frac{x^2}{6} + ...$$

---

### Exercise 2: 4-digit arithmetic summation

**Expression:** 2.274 + 12.04 + 0.4233 + 0.1202 + 0.2204

**(a) Original order (left to right):**

```
2.274 + 12.04 = 14.314 → 14.31 (4 digits)
14.31 + 0.4233 = 14.7333 → 14.73 (4 digits)
14.73 + 0.1202 = 14.8502 → 14.85 (4 digits)
14.85 + 0.2204 = 15.0704 → 15.07 (4 digits)
```
**Result: 15.07**

**(b) Sorted in increasing order: 0.1202 + 0.2204 + 0.4233 + 2.274 + 12.04**

```
0.1202 + 0.2204 = 0.3406 → 0.3406 (4 digits)
0.3406 + 0.4233 = 0.7639 → 0.7639 (4 digits)
0.7639 + 2.274 = 3.0379 → 3.038 (4 digits)
3.038 + 12.04 = 15.078 → 15.08 (4 digits)
```
**Result: 15.08**

**Exact sum:** 2.274 + 12.04 + 0.4233 + 0.1202 + 0.2204 = 15.0779

**Comparison:**
- Original order: 15.07 (error = 0.0079)
- Sorted order: 15.08 (error = 0.0021)

**Conclusion:** Sorting in increasing order gives a more accurate result (smaller rounding error accumulation).

---

## Summary of Key Techniques

| Problem | Technique |
|---------|-----------|
| Subtracting close numbers | Use algebraic manipulation or Taylor series |
| Quadratic formula (b² ≫ 4ac) | Use alternative formula with 2c in numerator |
| Small angle trigonometry | Use Taylor series or trig identities |
| Summation | Add from smallest to largest magnitude |
| Factorials/powers | Rearrange as products to avoid overflow |
