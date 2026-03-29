# Chapter 1: Introduction

## Summary

This chapter introduces the fundamental concepts of numerical analysis, including error sources, stability, and computer arithmetic.

### 1.1 Main Objectives of Numerical Analysis

**Purpose:** Numerical analysis provides exact or approximate solutions to mathematical problems using basic arithmetic operations (addition, subtraction, multiplication, division).

**Scientific Computation Process:**
```
Physical Problem → Mathematical Model → Numerical Solution
```

**Sources of Error:**
- **Inherited Error:**
  - *Modeling error* – simplification of physical reality
  - *Measurement error* – approximate parameter values from measurements
- **Computational Error:**
  - *Truncation error* – using approximate formulas (e.g., Taylor polynomials)
  - *Rounding error* – finite-digit storage of real numbers

**Stability Concepts:**
- **Well-conditioned problem:** Small changes in parameters → small changes in solution
- **Ill-conditioned problem:** Small changes in parameters → large changes in solution
- **Stable algorithm:** Rounding errors don't significantly affect results
- **Unstable algorithm:** Rounding errors accumulate rapidly (e.g., recursive sequence zₙ in Example 1.3)

**Algorithm Complexity:**
- **Time complexity:** Number of arithmetic operations (multiplications/divisions counted separately)
- **Space complexity:** Memory storage requirements
- **Horner's Method:** Efficient polynomial evaluation using only n multiplications and n additions for degree n

### 1.2 Computer Representation of Numbers

**Integer Representation:**
- **Sign-magnitude:** Uses sign bit + magnitude (two representations of zero)
- **Two's-complement:** Preferred method; subtraction becomes addition; single zero representation

**Floating-Point Representation (IEEE 754):**
| Precision | Bits | Exponent Range | Approximate Range |
|-----------|------|----------------|-------------------|
| Single    | 32   | -127 to 127    | 10⁻³⁸ to 10³⁸     |
| Double    | 64   | -1023 to 1023  | 10⁻³⁰⁸ to 10³⁰⁸   |

**Machine Epsilon (εₘ):** Smallest power of 2 where 1 + εₘ > 1
- Single precision: εₘ = 2⁻²³ ≈ 1.19×10⁻⁷ (exact in ~7 decimal digits)
- Double precision: εₘ = 2⁻⁵² ≈ 2.22×10⁻¹⁶ (exact in ~16 decimal digits)

**Error Definitions:**
- **Absolute error:** |x - x̃|
- **Relative error:** |x - x̃| / |x|
- **Exact in n digits:** Relative error ≤ ½ × b¹⁻ⁿ

### 1.3 Error Analysis

**Error Propagation in Arithmetic Operations:**

| Operation | Absolute Error Bound | Relative Error Bound |
|-----------|---------------------|---------------------|
| Addition  | Δx + Δy             | max{δₓ, δᵧ}         |
| Subtraction | Δx + Δy           | (xδₓ + yδᵧ)/(x-y)   |
| Multiplication | xΔy + yΔx      | δₓ + δᵧ             |
| Division  | (xΔy + yΔy)/(y-Δy)  | (δₓ + δᵧ)/(1-δᵧ)    |

**Loss of Significance:** Occurs when subtracting nearly equal numbers, causing dramatic increase in relative error. Example: 12.47534 - 12.47325 loses 4 digits of accuracy.

### 1.4 Consequences of Floating-Point Arithmetic

**Common Problems and Solutions:**

1. **Loss of Significance in Quadratic Formula:**
   - Problem: √(b² - 4ac) ≈ |b| causes subtraction of close numbers
   - Solution: Use alternative formula x = 2c / (-b ∓ √(b² - 4ac))

2. **Trigonometric Expressions:**
   - cos²x - sin²x near x = π/4 → use cos(2x) instead

3. **Taylor Series Approximation:**
   - eˣ - 1 near x = 0 → use x + x²/2! + x³/3! + ...

4. **Overflow Avoidance:**
   - Compute aⁿ/n! as product: (a/n) × (a/(n-1)) × ... × (a/1)

5. **Summation Order:**
   - Add numbers in increasing order of magnitude to minimize rounding errors
   - Floating-point addition is not commutative numerically

---

## Key Takeaways

1. Always analyze truncation error before implementing a numerical algorithm
2. Check problem conditioning – ill-conditioned problems amplify input errors
3. Avoid subtracting nearly equal numbers (loss of significance)
4. Use algebraically equivalent but numerically stable formulas
5. Sum numbers from smallest to largest magnitude
6. Understand your computer's floating-point representation and its limitations
