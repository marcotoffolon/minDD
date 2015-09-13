# minDD
[min]imal model for [D]ouble [D]iffusion
--- 
Version 1.0.0 - September 2015
---
"Likely the simplest model to simulate the formation and evolution of double-diffusive staircases" (Toffolon et al., 2015)

Provided by Marco Toffolon
Department of Civil, Environmental, and Mechanical Engineering, University of Trento (Italy)
email contact: marco.toffolon@unitn.it

This is a user-friendly version, with a simpler pre- and post-processing than the original source code used in the paper below, but the computational kernel is the same.

Reference:
Toffolon, M., A. Wüest, and T. Sommer (2015), Minimal model for double diffusion and its application to
Kivu, Nyos, and Powell Lake, J. Geophys. Res. Oceans, 120, doi:10.1002/2015JC010970

-INSTRUCTIONS-
The code is written in Matlab. 
1. The file "main.m" is the script that calls the other subroutines to simulate the formation of a double-diffusive staircase using a simple one-dimensional approach. The scripts contain several comments that should help understanding.
2. The folder /input/ contains the main input file "data.txt" and the test case (see also "input_prep.m").
3. The results are written in the folders /res/ (outputs) and /fig/ (figures). The folders available in this version contain an example.
4. A simple post-processing, which reproduces the standard plots for a selected time step, is provided in the script "postproc.m".
