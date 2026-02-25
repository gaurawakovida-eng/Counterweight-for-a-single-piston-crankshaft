# Rotational and Reciprocating Mass Balancing Optimization

## 📌 Project Overview
* **Objective:** Designed and optimized a counterweight system to achieve a specific balance factor (k=0.5) for a high-speed rotating mechanical linkage operating at 6000 rpm.
* **Problem:** At high speeds, reciprocating and rotating components generate massive inertia forces. Without counterweights, these "shaking forces" threaten structural integrity.
* **Context:** Collaborative academic project for the BSc in Engineering program at Széchenyi István University.

## ⚙️ My Specific Contributions
While the physical 3D CAD modeling was executed by a colleague, I was responsible for the mathematical modeling, software development, and the core conceptual design:
* **Custom Optimization Software (MATLAB):** Developed a program utilizing Taylor Series Expansion to convert physical displacement into harmonic functions (1st, 2nd, 4th, and 6th orders) according to the instructions provided.
* **Iterative Loop Design:** Programmed the software to treat complex shapes as point masses and iteratively test different Center of Gravity (COG) radii until the target balancing factor was found.
* **Conceptual Mechanical Design:** Directed the engineering logic for two counterweight types. I proposed the use of peripheral relief holes to maximize leverage while minimizing total rotating mass.

## 🛠️ Technical Tools & Concepts Applied
* **Software:** MATLAB (for numerical computing and optimization loop).
* **Applied Mechanics:** Dynamic balancing, inertia force dampening, and static moment calculations.
* **The k=0.5 Compromise:** Intentionally distributing vertical vibrations into the horizontal plane to prevent the system from "jumping" and ensuring smoother operation at 6000 rpm.

## 📊 Key Engineering Results
* **Type 1 (Steel Baseline):** Achieved the target with an 844g mass at a 37.36mm COG radius.
* **Type 2 (Tungsten Optimized):** Implemented my concept using 20mm tungsten rods. This pushed the COG radius to 41.4mm.
* **Final Efficiency:** The optimized Type 2 design achieved the target balance factor while reducing the total applied mass by 9.7% (80g reduction), improving engine responsiveness.

## 📁 Repository Contents
* `Balancing of crankshaft.pptx`: Comprehensive presentation detailing the mathematical approach, performance graphs, and CAD renders.
* `calculation.m`: The MATLAB script used to calculate the harmonic functions and optimize the mass radius.
