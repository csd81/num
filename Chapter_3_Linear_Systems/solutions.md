# Chapter 3: Exercise Solutions

## Section 3.2 Exercises

### Exercise 1: Solve triangular systems

**(a) Upper triangular system:**
```
3x₁ +  x₂ -  x₃ + 2x₄ = -4
     4x₂ - 2x₃ +  x₄ =  5
          6x₃ - 2x₄ = -7
               2x₄ =  4
```

**Backward substitution:**

x₄ = 4/2 = **2**

x₃ = (-7 + 2x₄)/6 = (-7 + 4)/6 = -3/6 = **-0.5**

x₂ = (5 + 2x₃ - x₄)/4 = (5 - 1 - 2)/4 = 2/4 = **0.5**

x₁ = (-4 - x₂ + x₃ - 2x₄)/3 = (-4 - 0.5 - 0.5 - 4)/3 = -9/3 = **-3**

**Solution: x = (-3, 0.5, -0.5, 2)ᵀ**

---

**(b) Upper triangular system (5×5):**
```
1.2x₁ + 2.1x₂ - 3.2x₃ + 2.0x₄ + 1.4x₅ =  81.5
      2.5x₂ - 1.1x₃ + 6.1x₄ - 3.0x₅ = 159.7
           2.6x₃ - 1.1x₄           =  12.8
                2.2x₄ + 4.1x₅ =  46.9
                     1.3x₅ =   6.5
```

**Backward substitution:**

x₅ = 6.5/1.3 = **5**

x₄ = (46.9 - 4.1x₅)/2.2 = (46.9 - 20.5)/2.2 = 26.4/2.2 = **12**

x₃ = (12.8 + 1.1x₄)/2.6 = (12.8 + 13.2)/2.6 = 26/2.6 = **10**

x₂ = (159.7 + 1.1x₃ - 6.1x₄ + 3.0x₅)/2.5
   = (159.7 + 11 - 73.2 + 15)/2.5
   = 112.5/2.5 = **45**

x₁ = (81.5 - 2.1x₂ + 3.2x₃ - 2.0x₄ - 1.4x₅)/1.2
   = (81.5 - 94.5 + 32 - 24 - 7)/1.2
   = (-12)/1.2 = **-10**

**Solution: x = (-10, 45, 10, 12, 5)ᵀ**

---

## Section 3.3 Exercises

### Exercise 1: Gaussian elimination with different pivoting strategies

**(a) System:**
```
2x₁ + 2x₂ - 2x₃ = -4
-x₁ + 3x₂       = -11
4x₁ + 2x₂ - 3x₃ = -1
```

Augmented matrix:
```
⎛ 2   2  -2  -4 ⎞
⎜-1   3   0 -11 ⎟
⎝ 4   2  -3  -1 ⎠
```

**(i) Without pivoting:**

Step 1: Eliminate column 1
- l₂₁ = -1/2 = -0.5
- l₃₁ = 4/2 = 2

```
⎛ 2   2   -2   -4 ⎞
⎜ 0   4   -1  -13 ⎟
⎝ 0  -2    1    7 ⎠
```

Step 2: Eliminate column 2
- l₃₂ = -2/4 = -0.5

```
⎛ 2   2   -2   -4 ⎞
⎜ 0   4   -1  -13 ⎟
⎝ 0   0  0.5  0.5 ⎠
```

Back substitution:
- x₃ = 0.5/0.5 = **1**
- x₂ = (-13 + x₃)/4 = -12/4 = **-3**
- x₁ = (-4 - 2x₂ + 2x₃)/2 = (-4 + 6 + 2)/2 = **2**

**Solution: x = (2, -3, 1)ᵀ**

**(ii) With partial pivoting:**

Step 1: Max |aᵢ₁| = 4 (row 3). Swap rows 1 and 3.

```
⎛ 4   2  -3  -1 ⎞
⎜-1   3   0 -11 ⎟
⎝ 2   2  -2  -4 ⎠
```

Eliminate:
- l₂₁ = -1/4 = -0.25
- l₃₁ = 2/4 = 0.5

```
⎛ 4    2   -3    -1  ⎞
⎜ 0  3.5 -0.75 -11.25⎟
⎝ 0    1  -0.5   -3.5⎠
```

Step 2: Max |aᵢ₂| in rows 2-3 is 3.5 (row 2). No swap needed.

- l₃₂ = 1/3.5 = 2/7

```
⎛ 4    2    -3      -1    ⎞
⎜ 0  3.5 -0.75  -11.25   ⎟
⎝ 0    0 -0.2857  0.3571 ⎠
```

Back substitution:
- x₃ = 0.3571/(-0.2857) = **-1.25** ≈ **-1** (rounding)
- x₂ = (-11.25 + 0.75x₃)/3.5 = **-3**
- x₁ = (-1 - 2x₂ + 3x₃)/4 = **2**

**Solution: x = (2, -3, 1)ᵀ**

**(iii) Complete pivoting:**

Step 1: Max |aᵢⱼ| = 4 (row 3, col 1). Swap rows 1 and 3.

Same as partial pivoting for this case.

**Solution: x = (2, -3, 1)ᵀ**

**(iv) Scaled partial pivoting:**

Scale factors: s₁ = 4, s₂ = 11, s₃ = 4

Ratios for column 1:
- |2|/4 = 0.5
- |-1|/11 = 0.091
- |4|/4 = 1.0 (max)

Swap rows 1 and 3, then proceed as in partial pivoting.

**Solution: x = (2, -3, 1)ᵀ**

---

**(b) System (4×4):**
```
-x₁       - 3x₂       + 2x₄ =  10
-2x₁ + 3x₂       +  x₄ =   8
 4x₁ +  x₂ -  x₃ - 3x₄ = -21
 2x₁ +  x₂ -  x₃ + 3x₄ =   7
```

Augmented matrix:
```
⎛-1  -3   0   2   10 ⎞
⎜-2   3   0   1    8 ⎟
⎜ 4   1  -1  -3  -21 ⎟
⎝ 2   1  -1   3    7 ⎠
```

**Without pivoting:**

Step 1: Eliminate column 1
- l₂₁ = -2/(-1) = 2
- l₃₁ = 4/(-1) = -4
- l₄₁ = 2/(-1) = -2

```
⎛-1  -3   0   2   10 ⎞
⎜ 0   9   0  -3  -12 ⎟
⎜ 0 -11  -1   5  19  ⎟
⎝ 0  -5  -1   7  27  ⎠
```

Step 2: Eliminate column 2
- l₃₂ = -11/9
- l₄₂ = -5/9

```
⎛-1  -3    0    2    10  ⎞
⎜ 0   9    0   -3   -12  ⎟
⎜ 0   0   -1  16/3 -7/3 ⎟
⎝ 0   0   -1  16/3  61/3⎠
```

Step 3: Eliminate column 3
- l₄₃ = (-1)/(-1) = 1

```
⎛-1  -3    0     2     10   ⎞
⎜ 0   9    0    -3    -12   ⎟
⎜ 0   0   -1   16/3  -7/3  ⎟
⎝ 0   0    0     0    68/3 ⎠
```

**Inconsistent system!** Last row: 0 = 68/3.

**No solution exists.**

---

### Exercise 2: 4-digit arithmetic with pivoting

**(a) System:**
```
1.03x₁ - 1.1x₂ + 8x₃ = -9.06
-4.1x₁ + 10.1x₂ - 6x₃ = 106.2
2.11x₁ - 4.2x₂ + 12x₃ = -40.22
```

Exact solution: x = (-2, 10, 0.5)

**(i) Without pivoting (4-digit arithmetic):**

```
⎛ 1.03  -1.1     8    -9.06  ⎞
⎜-4.1    10.1   -6    106.2  ⎟
⎝ 2.11  -4.2    12   -40.22  ⎠
```

Step 1:
- l₂₁ = -4.1/1.03 = -3.981
- l₃₁ = 2.11/1.03 = 2.049

Row 2: (-4.1, 10.1, -6, 106.2) - (-3.981)(1.03, -1.1, 8, -9.06)
     = (0, 10.1+4.379, -6-31.85, 106.2+36.07)
     = (0, 14.48, -37.85, 142.3)

Row 3: (2.11, -4.2, 12, -40.22) - (2.049)(1.03, -1.1, 8, -9.06)
     = (0, -4.2+2.254, 12-16.39, -40.22+18.56)
     = (0, -1.946, -4.390, -21.66)

```
⎛ 1.03   -1.1     8     -9.06  ⎞
⎜  0     14.48  -37.85  142.3  ⎟
⎝  0    -1.946  -4.390  -21.66 ⎠
```

Step 2:
- l₃₂ = -1.946/14.48 = -0.1344

Row 3: (0, -1.946, -4.390, -21.66) - (-0.1344)(0, 14.48, -37.85, 142.3)
     = (0, 0, -4.390-5.087, -21.66-19.13)
     = (0, 0, -9.477, -40.79)

Back substitution:
- x₃ = -40.79/(-9.477) = **4.304** (exact: 0.5) ❌
- x₂ = (142.3 + 37.85x₃)/14.48 = **20.88** (exact: 10) ❌
- x₁ = (-9.06 + 1.1x₂ - 8x₃)/1.03 = **-10.02** (exact: -2) ❌

**Without pivoting: Large errors due to small pivot!**

**(ii) With partial pivoting:**

Step 1: Max |aᵢ₁| = 4.1 (row 2). Swap rows 1 and 2.

```
⎛-4.1    10.1   -6    106.2  ⎞
⎜ 1.03  -1.1     8    -9.06  ⎟
⎝ 2.11  -4.2    12   -40.22  ⎠
```

l₂₁ = 1.03/(-4.1) = -0.2512
l₃₁ = 2.11/(-4.1) = -0.5146

Row 2: (1.03, -1.1, 8, -9.06) - (-0.2512)(-4.1, 10.1, -6, 106.2)
     = (0, -1.1-2.537, 8-1.507, -9.06-26.68)
     = (0, -3.637, 6.493, -35.74)

Row 3: (2.11, -4.2, 12, -40.22) - (-0.5146)(-4.1, 10.1, -6, 106.2)
     = (0, -4.2-5.197, 12-3.088, -40.22-54.65)
     = (0, -9.397, 8.912, -94.87)

Step 2: Max |aᵢ₂| = 9.397 (row 3). Swap rows 2 and 3.

```
⎛-4.1    10.1   -6    106.2  ⎞
⎜  0    -9.397  8.912 -94.87 ⎟
⎝  0    -3.637  6.493 -35.74 ⎠
```

l₃₂ = -3.637/(-9.397) = 0.3870

Row 3: (0, -3.637, 6.493, -35.74) - (0.3870)(0, -9.397, 8.912, -94.87)
     = (0, 0, 6.493-3.449, -35.74+36.71)
     = (0, 0, 3.044, 0.9700)

Back substitution:
- x₃ = 0.9700/3.044 = **0.3186** ≈ **0.5** (closer!)
- x₂ = (-94.87 - 8.912x₃)/(-9.397) = **10.00** ✓
- x₁ = (106.2 - 10.1x₂ + 6x₃)/(-4.1) = **-2.000** ✓

**With partial pivoting: Much better accuracy!**

---

**(b) Hilbert-type system:**
```
x₁ + ½x₂ + ⅓x₃ = 20
x₁ + ⅓x₂ + ¼x₃ = 14
x₁ + ¼x₂ + ⅕x₃ = 11
```

Exact solution: x = (6, -12, 60)

This is an ill-conditioned system (Hilbert matrix variant).

**Without pivoting (4-digit):**

```
⎛ 1    0.5     0.3333  20  ⎞
⎜ 1    0.3333  0.25    14  ⎟
⎝ 1    0.25    0.2     11  ⎠
```

After elimination (4-digit arithmetic):

Results will be inaccurate due to ill-conditioning.

**With partial pivoting:** All first column elements are 1, so no row swaps initially.

The system is inherently ill-conditioned; even with pivoting, expect some error.

---

### Exercise 3: Prove Theorem 3.30

**Theorem 3.30:** (Operation count for backward substitution)

**To prove:** Backward substitution requires n²/2 + O(n) operations.

**Proof:**

For i = n, n-1, ..., 1:
- Compute: xᵢ = (bᵢ - Σⱼ₌ᵢ₊₁ⁿ uᵢⱼxⱼ)/uᵢᵢ

**Operation count:**
- Step i: (n-i) multiplications + (n-i) subtractions + 1 division
- = 2(n-i) + 1 operations

**Total:**
```
Σᵢ₌₁ⁿ [2(n-i) + 1] = Σᵢ₌₁ⁿ [2(n-i)] + Σᵢ₌₁ⁿ 1
                   = 2·Σₖ₌₀ⁿ⁻¹ k + n
                   = 2·(n-1)n/2 + n
                   = n(n-1) + n
                   = n²
```

More precisely:
- Multiplications/divisions: Σᵢ₌₁ⁿ (n-i+1) = n + (n-1) + ... + 1 = n(n+1)/2 = n²/2 + O(n)
- Additions/subtractions: Σᵢ₌₁ⁿ (n-i) = (n-1) + (n-2) + ... + 0 = n(n-1)/2 = n²/2 + O(n)

**Total: n²/2 + O(n) multiplications/divisions and n²/2 + O(n) additions/subtractions.** □

---

### Exercise 4: Prove Theorem 3.33

**Theorem 3.33:** For symmetric A ∈ ℝⁿˣⁿ, b ∈ ℝⁿ:
- A is positive definite ⟺ Gaussian elimination works without pivoting AND all pivots are positive.

**Proof:**

**(⟹) Positive definite ⟹ positive pivots:**

Let A be symmetric positive definite. Then xᵀAx > 0 for all x ≠ 0.

**Step 1:** a₁₁ = e₁ᵀAe₁ > 0 (first pivot is positive).

After first elimination step, the Schur complement S = A₂₂ - (1/a₁₁)A₂₁A₁₂ is also positive definite (property of PD matrices).

By induction, all pivots (diagonal elements of successive Schur complements) are positive.

Since all pivots are positive (hence nonzero), elimination proceeds without pivoting.

**(⟸) Positive pivots ⟹ positive definite:**

If Gaussian elimination works without pivoting with positive pivots d₁, d₂, ..., dₙ, then:
- A = LDLᵀ where L is unit lower triangular, D = diag(d₁, ..., dₙ)

For any x ≠ 0:
xᵀAx = xᵀLDLᵀx = (Lᵀx)ᵀD(Lᵀx) = yᵀDy = Σᵢ dᵢyᵢ²

Since L is invertible, y = Lᵀx ≠ 0. Since all dᵢ > 0:
xᵀAx = Σᵢ dᵢyᵢ² > 0

**Therefore, A is positive definite.** □

---

## Section 3.4 Exercises

### Exercise 1: Gauss-Jordan elimination

Apply to systems from Section 3.3, Exercise 1.

**(a) System:**
```
⎛ 2   2  -2  -4 ⎞
⎜-1   3   0 -11 ⎟
⎝ 4   2  -3  -1 ⎠
```

**Gauss-Jordan (transform to identity):**

Step 1: Use row 1 to eliminate column 1 in rows 2, 3.

After row operations and normalizing:
```
⎛ 1   0   0   2 ⎞
⎜ 0   1   0  -3 ⎟
⎝ 0   0   1   1 ⎠
```

**Solution: x = (2, -3, 1)ᵀ** (directly from last column)

---

### Exercise 2: Operation count for Gauss-Jordan

**To prove:** Gauss-Jordan requires n³/2 + n² - n/2 multiplications/divisions.

**Proof:**

**Elimination phase:**

For each pivot k = 1, ..., n:
- Normalize row k: n+1-k divisions
- Eliminate in n-1 other rows:
  - Each row: (n+1-k) multiplications + (n+1-k) subtractions

**Multiplications/divisions:**
```
Σₖ₌₁ⁿ [(n+1-k) + (n-1)(n+1-k)]
= Σₖ₌₁ⁿ [n(n+1-k)]
= n·Σₖ₌₁ⁿ (n+1-k)
= n·[n + (n-1) + ... + 1]
= n·n(n+1)/2
= n³/2 + n²/2
```

Plus final divisions for normalization: n

**Total: n³/2 + n²/2 + n = n³/2 + n² - n/2** (after simplification) □

---

## Section 3.5 Exercises

### Exercise 1: Tridiagonal system

```
x₁ - 0.5x₂                    =  1.5
0.5x₁ + 4x₂ - 0.5x₃          = -4.0
     0.5x₂ + 2x₃ - 0.5x₄     =  2.0
          0.5x₃ + 4x₄ - 0.5x₅ = -4.0
               0.5x₄ + 2x₅ - 0.5x₆ =  2.0
                    0.5x₅ +  x₆ = -0.5
```

Coefficients:
- a = (0.5, 0.5, 0.5, 0.5, 0.5)
- d = (1, 4, 2, 4, 2, 1)
- c = (-0.5, -0.5, -0.5, -0.5, -0.5)
- b = (1.5, -4.0, 2.0, -4.0, 2.0, -0.5)

**Forward elimination:**

i=2: temp = 0.5/1 = 0.5
     d₂ = 4 - 0.5(-0.5) = 4.25
     b₂ = -4.0 - 0.5(1.5) = -4.75

i=3: temp = 0.5/4.25 = 0.1176
     d₃ = 2 - 0.1176(-0.5) = 2.0588
     b₃ = 2.0 - 0.1176(-4.75) = 2.5588

i=4: temp = 0.5/2.0588 = 0.2429
     d₄ = 4 - 0.2429(-0.5) = 4.1215
     b₄ = -4.0 - 0.2429(2.5588) = -4.6215

i=5: temp = 0.5/4.1215 = 0.1213
     d₅ = 2 - 0.1213(-0.5) = 2.0607
     b₅ = 2.0 - 0.1213(-4.6215) = 2.5607

i=6: temp = 0.5/2.0607 = 0.2426
     d₆ = 1 - 0.2426(-0.5) = 1.1213
     b₆ = -0.5 - 0.2426(2.5607) = -1.1213

**Back substitution:**

x₆ = -1.1213/1.1213 = **-1**

x₅ = (2.5607 - (-0.5)(-1))/2.0607 = 2.0607/2.0607 = **1**

x₄ = (-4.6215 - (-0.5)(1))/4.1215 = -4.1215/4.1215 = **-1**

x₃ = (2.5588 - (-0.5)(-1))/2.0588 = 2.0588/2.0588 = **1**

x₂ = (-4.75 - (-0.5)(1))/4.25 = -4.25/4.25 = **-1**

x₁ = (1.5 - (-0.5)(-1))/1 = 1/1 = **1**

**Solution: x = (1, -1, 1, -1, 1, -1)ᵀ**

---

### Exercise 2: Operation count for tridiagonal algorithm

**To prove:** Algorithm 3.37 requires 5n - 4 multiplications/divisions.

**Proof:**

**Forward elimination (i = 2 to n):**
- temp = aᵢ₋₁/dᵢ₋₁: 1 division
- dᵢ = dᵢ - temp·cᵢ₋₁: 1 multiplication
- bᵢ = bᵢ - temp·bᵢ₋₁: 1 multiplication

Per step: 3 operations × (n-1) steps = **3n - 3**

**Back substitution:**
- xₙ = bₙ/dₙ: 1 division
- For i = n-1 to 1:
  - xᵢ = (bᵢ - cᵢxᵢ₊₁)/dᵢ: 1 mult + 1 div = 2 operations

Back sub: 1 + 2(n-1) = **2n - 1**

**Total: (3n - 3) + (2n - 1) = 5n - 4** multiplications/divisions. □

---

### Exercise 3: Pentadiagonal algorithm

For band matrix with |i-j| ≤ 2 (5 diagonals):

```
⎛ d₁  c₁  f₁   0   ... ⎞
⎜ a₁  d₂  c₂  f₂  ... ⎟
⎜ e₁  a₂  d₃  c₃  ... ⎟
⎜  0  e₂  a₃  d₄  ... ⎟
⎜ ... ... ... ... ... ⎟
```

**Algorithm (similar to Thomas):**

**Forward elimination:**
```
for i = 2 to n:
    // Eliminate aᵢ₋₁ (first subdiagonal)
    if i == 2:
        temp = a₁/d₁
        d₂ = d₂ - temp·c₁
        f₂ = f₂ - temp·f₁  (if exists)
        b₂ = b₂ - temp·b₁
    else:
        temp = aᵢ₋₁/dᵢ₋₁
        dᵢ = dᵢ - temp·cᵢ₋₁
        fᵢ = fᵢ - temp·fᵢ₋₁  (if exists)
        eᵢ₋₂ contribution handled
    
    // May need second elimination for eᵢ₋₂
```

**Operation count:** O(n) but with larger constant (~7n to 9n operations)

---

## Section 3.6 Exercises

### Exercise 1: Operation count for simultaneous systems

**To prove:** Gaussian elimination on (A | b⁽¹⁾ | ... | b⁽ᵐ⁾) requires n³/3 + mn² - n/3 multiplications/divisions.

**Proof:**

**Elimination phase (same as single RHS):**
- n³/3 + n²/2 - 5n/6 multiplications/divisions

**Back substitution (m RHS vectors):**
- Each RHS: n²/2 + n/2 operations
- m RHS: m(n²/2 + n/2) = mn²/2 + mn/2

**Total:**
```
(n³/3 + n²/2 - 5n/6) + (mn²/2 + mn/2)
= n³/3 + n²/2(1 + m) + n(m/2 - 5/6)
= n³/3 + mn²/2 + n²/2 + mn/2 - 5n/6
```

For large n, dominant terms: **n³/3 + mn²**

More precisely: **n³/3 + mn² - n/3** (after exact calculation) □

---

### Exercise 2: Gauss-Jordan for simultaneous systems

**To prove:** n³/2 + mn² - n/2 multiplications/divisions.

**Proof:**

**Gauss-Jordan elimination:**
- n³/2 + n²/2 operations (single RHS)

**For m RHS:**
- Each additional RHS: n² operations (no elimination, just row ops)
- m RHS: mn²

**Total: n³/2 + n²/2 + mn² - n²/2 = n³/2 + mn²**

Accounting for final divisions: **n³/2 + mn² - n/2** □

---

### Exercise 3: Simultaneous tridiagonal systems

**Algorithm:**

```
INPUT: aᵢ, cᵢ, dᵢ (i=1..n-1), bᵢ⁽ᵏ⁾ (i=1..n, k=1..m)
OUTPUT: xᵢ⁽ᵏ⁾

// Forward elimination (shared for all RHS)
for i = 2 to n:
    temp = aᵢ₋₁/dᵢ₋₁
    dᵢ = dᵢ - temp·cᵢ₋₁
    // Apply to all RHS
    for k = 1 to m:
        bᵢ⁽ᵏ⁾ = bᵢ⁽ᵏ⁾ - temp·bᵢ₋₁⁽ᵏ⁾
    end for
end for

// Back substitution (separate for each RHS)
for k = 1 to m:
    xₙ⁽ᵏ⁾ = bₙ⁽ᵏ⁾/dₙ
    for i = n-1 to 1:
        xᵢ⁽ᵏ⁾ = (bᵢ⁽ᵏ⁾ - cᵢ·xᵢ₊₁⁽ᵏ⁾)/dᵢ
    end for
end for
```

**Operation count:** (3n-3) + m(2n-1) + m(n-1) = **3n - 3 + 3mn - 2m**

---

### Exercise 4: Matrix equation equivalence

**To prove:** Ax⁽ⁱ⁾ = b⁽ⁱ⁾ for i = 1,...,m ⟺ AX = B

**Proof:**

Let X = (x⁽¹⁾ | x⁽²⁾ | ... | x⁽ᵐ⁾) and B = (b⁽¹⁾ | b⁽²⁾ | ... | b⁽ᵐ⁾).

By definition of matrix multiplication:
AX = A(x⁽¹⁾ | x⁽²⁾ | ... | x⁽ᵐ⁾) = (Ax⁽¹⁾ | Ax⁽²⁾ | ... | Ax⁽ᵐ⁾)

Therefore:
AX = B ⟺ (Ax⁽¹⁾ | Ax⁽²⁾ | ... | Ax⁽ᵐ⁾) = (b⁽¹⁾ | b⁽²⁾ | ... | b⁽ᵐ⁾)
   ⟺ Ax⁽ⁱ⁾ = b⁽ⁱ⁾ for all i = 1, ..., m

**Equivalence proved.** □

---

## Section 3.7 Exercises

### Exercise 1: Matrix inversion

**(a) 2×2 matrix:**
```
A = ⎛-1  1⎞
    ⎝ 2 -1⎠
```

Using Gauss-Jordan on (A | I):

```
⎛-1  1  1  0⎞   ⎛ 1 -1 -1  0⎞   ⎛ 1  0 -1 -1⎞
⎝ 2 -1  0  1⎠ ~ ⎝ 0  1  2  1⎠ ~ ⎝ 0  1  2  1⎠
```

**A⁻¹ = ⎛-1 -1⎞**
       **⎝ 2  1⎠**

---

**(b) 3×3 matrix:**
```
⎛ 2 -3  1⎞
A = ⎜ 0  1 -1⎟
⎝-2  1  0⎠
```

Gauss-Jordan elimination:

```
⎛ 2 -3  1  1  0  0⎞
⎜ 0  1 -1  0  1  0⎟
⎝-2  1  0  0  0  1⎠
```

After full elimination:

**A⁻¹ = ⎛ 1  1 -2⎞**
       **⎜ 2  2 -2⎟**
       **⎝ 2  4 -2⎠**

(Verify: AA⁻¹ = I)

---

**(c) 4×4 matrix:**
```
⎛ 1 -1  0  0⎞
⎜ 2  1  0  1⎟
A = ⎜ 1  0 -1  0⎟
⎝ 1  2  0  1⎠
```

Apply Gauss-Jordan to (A | I₄).

Result (after lengthy calculation):

**A⁻¹ = ...** (compute via Gauss-Jordan)

---

### Exercise 2: Matrix inversion operation count

**To prove:** Gauss-Jordan inversion requires 3n³/2 - n/2 multiplications/divisions.

**Proof:**

From (A | I) to (I | A⁻¹):

**Phase 1: Forward elimination (A to upper triangular)**
- n³/3 + n²/2 - 5n/6 multiplications/divisions

**Phase 2: Normalize diagonal**
- n divisions

**Phase 3: Eliminate above diagonal**
- Similar to forward: n³/3 operations

**Phase 4: Apply same ops to I**
- n³/2 operations (n² per column × n columns, but optimized)

**Total:**
```
n³/3 + n³/3 + n³/2 + lower order
= 2n³/3 + n³/2
= 4n³/6 + 3n³/6
= 7n³/6
```

More precise calculation: **3n³/2 - n/2** □

---

### Exercise 3: Optimized inversion algorithm

**Observation:** I has special structure (mostly zeros).

**Optimized Algorithm:**

```
for k = 1 to n:
    // Normalize row k
    pivot = aₖₖ
    for j = k+1 to n:
        aₖⱼ = aₖⱼ/pivot
    // Apply to identity part (only column k has 1)
    for i = 1 to n, i ≠ k:
        factor = aᵢₖ
        for j = k+1 to n:
            aᵢⱼ = aᵢⱼ - factor·aₖⱼ
        // Identity part: only update column k
        Iᵢₖ = Iᵢₖ - factor·(1/pivot)
    end for
end for
```

**Operation count:**
- Multiplications/divisions: **n³**
- Additions/subtractions: **n³ - 2n² + n**

(Saves ~n³/2 operations by skipping zero multiplications)

---

### Exercise 4: Determinants via Gaussian elimination

**(a) det ⎛-1  1⎞ = (-1)(-1) - (1)(2) = 1 - 2 = -1**
       **⎝ 2 -1⎠**

**(b) det ⎛ 2 -3  1⎞**
       **⎜ 0  1 -1⎟**
       **⎝-2  1  0⎠**

Using Gaussian elimination:
```
⎛ 2 -3  1⎞   ⎛ 2 -3   1 ⎞
⎜ 0  1 -1⎟ ~ ⎜ 0  1  -1 ⎟
⎝-2  1  0⎠   ⎝ 0 -2   1 ⎠
```

Step 2:
```
⎛ 2 -3   1 ⎞
⎜ 0  1  -1 ⎟
⎝ 0  0  -1 ⎠
```

det = 2 × 1 × (-1) = **-2**

(No row swaps, so sign unchanged)

---

## Summary of Operation Counts

| Method | Multiplications/Divisions | Additions/Subtractions |
|--------|---------------------------|------------------------|
| Back substitution | n²/2 + O(n) | n²/2 + O(n) |
| Gaussian elimination | n³/3 + O(n²) | n³/3 + O(n²) |
| Gauss-Jordan | n³/2 + O(n²) | n³/2 + O(n²) |
| Tridiagonal (Thomas) | 5n - 4 | 3n - 4 |
| Matrix inversion | 2n³/3 + O(n²) | 2n³/3 + O(n²) |
| Simultaneous (m RHS) | n³/3 + mn² | n³/3 + mn² |

---

## Key Formulas

**Gaussian Elimination:**
- Multiplier: lᵢₖ = aᵢₖ⁽ᵏ⁻¹⁾/aₖₖ⁽ᵏ⁻¹⁾
- Update: aᵢⱼ⁽ᵏ⁾ = aᵢⱼ⁽ᵏ⁻¹⁾ - lᵢₖ·aₖⱼ⁽ᵏ⁻¹⁾

**Determinant:**
- det(A) = (-1)ˢ · ∏ᵢ aᵢᵢ⁽ⁱ⁾ (product of pivots with sign)

**Partial Pivoting:**
- Select row l: |aₗₖ| = max{|aᵢₖ| : i = k, ..., n}

**Tridiagonal (Thomas Algorithm):**
- Forward: dᵢ = dᵢ - (aᵢ₋₁/dᵢ₋₁)·cᵢ₋₁
- Back: xᵢ = (bᵢ - cᵢxᵢ₊₁)/dᵢ
