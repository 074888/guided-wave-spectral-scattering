# guided-wave-spectral-scattering
Fast spectral-method-based solver for guided wave dispersion and scattering  in anisotropic multilayer composite structures.

The proposed framework is capable of solving guided wave scattering
from complex reinforced structures, such as stiffeners and geometric
discontinuities, as illustrated above.

By combining Chebyshev spectral discretization with modal matching,
both dispersion characteristics and scattering matrices can be
computed efficiently for a wide range of composite structures.

<img width="750" height="320" alt="image" src="https://github.com/user-attachments/assets/a0b0d221-4c35-42a2-ad00-245ee4015a18" />

In addition, the method is not limited to local reinforced geometries.
It can be systematically extended to guided wave analysis in
anisotropic and multilayer plates, circumferential wave propagation
in cylindrical structures, and plate–cylinder coupled configurations.
  <img width="480" height="410" alt="image" src="https://github.com/user-attachments/assets/ecec38aa-c48c-4014-aa96-d2764b670ee4" />

# Guided Wave Spectral Scattering

This repository provides a spectral-method-based framework for solving
guided wave **dispersion**, **complex wavenumbers**, and **scattering**
in anisotropic and multilayer composite structures.

The method combines **Chebyshev spectral discretization** with
**modal matching**, enabling fast and accurate computation of
guided wave scattering in complex structures such as:

- Stepped plates
- Multilayer anisotropic laminates
- Circumferential stepped pipes
- Plate–pipe coupled structures
- Γ-shaped and stiffened plates

Compared with FEM-based approaches, the proposed method achieves
significantly higher computational efficiency while maintaining
excellent accuracy.

---

## Features

- Spectral-method-based dispersion solver
- Complex wavenumber and full-field (displacement & stress) calculation
- Modal matching for scattering matrix computation
- Support for anisotropic and multilayer composite structures
- FEM validation (COMSOL) and reference comparison (DC software)

---

## Background

This code is developed based on the methodology presented in the
author's Master's thesis:

> **"Spectral-Method-Based Study on Guided Wave Scattering in Composite Structures"**

The implementation focuses on **engineering-oriented guided wave analysis**
for structural health monitoring (SHM) and non-destructive evaluation (NDE).

---

## Requirements

- MATLAB (R2020a or later recommended)
- No external toolboxes required (unless explicitly stated)

---

## Notes

- This repository focuses on **forward modeling** of guided wave scattering.
- Local material perturbations (e.g., delamination, micro-cracks) are
  not explicitly modeled in the current implementation.
- The code is intended for research and engineering evaluation purposes.

---

## License

This project is provided for academic and research use.
Please cite the related work if you use this code in publications.

