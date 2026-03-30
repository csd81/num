LEGACY EXAMPLES - Original (Buggy) Files
==========================================

This folder contains the original example files from Chapter 2 before they were
debugged, annotated, and reorganized into section-specific subdirectories.

These files are kept for historical reference and contain the following bugs:
- Use of & instead of && in while/if conditions with scalar operands
- In fixed-point iteration: uses abs(g(x)-x) > tolerance instead of abs(x_new - x_old) > tolerance
- In Newton's method (scalar): was incorrectly a copy of the n-dimensional version

The corrected, annotated versions of these files are now located in:
- section_2.2_fixed_point_iteration/
- section_2.3_bisection/
- section_2.4_newtons_method/
- section_2.5_secant_false_position/
- section_2.7_newton_n_dimensions/
- section_2.8_broydens_method/

Each file now includes:
- Comprehensive header comments with algorithm description
- Convergence analysis
- Inline comments for every formula and decision point
- Proper bug fixes and parameter descriptions
