# FracFit
FracFit is a Matlab Toolbox for fitting space and time fractional models to hydrology data (e.g. breakthrough curves).
This version uses the external STABLE package available from http://robustanalysis.com/ for computing alpha stable PDFs and CDFs.  A future version of FracFit will use freely available stable routines.  The Optimization toolbox is also required for performing nonlinear least squares.

Contact: James F. Kelly
         Department of Statistics and Probability
         Michigan State University
         East Lansing, MI 48823
         email: kellyja8@stt.msu.edu

FracFit has been tested under MATLAB 7.10 (r2010) under Windows 7.

DISCLAIMER: This version is under development and many of the models have not been tested.  The "cbtc_fit" routine has not been tested using the "frac_mobile" models.  The "tempered_stable" model is not functional.

DATA: FracFit currently supports: 1. BTC data and 2. continuous injection BTC (CBTC) data.
Support for 3. snapshot data (e.g. MADE) will be added in the future.

diogo_cbtc: Continuous injection BTCs (CBTCs) provided by Diogo Bolster, Notre Dame.    
haggerty: Mountain Stream data provided by Roy Haggerty, Oregon State University.  
red_cedar_exp3: Red Cedar River provided by Phanikumar Mantha, MSU.

MODELS: A space-fractional model (fADE) and a time-fractional (fractional mobile/immobile) model
has been implemented.  

frac_mobile: PDF/CDF and objective functions for the fractional mobile/immobile models:
  frac_mobile = (gamma, v, beta)
  frac_mobile_diffusion = (gamma, v, beta, D)
  
spatial_fade: Spatial fractional advection dispersion equation (fade) models:
  spatial_fade = (alpha, beta, v, D)
  spatial_fade_negskew = (alpha,v,D).  beta = -1.
  ade = (v,D).  alpha = 2 and beta = 0.

tempered_stable: Tempered alpha-stable distribution model (not implemented)    

test_scripts: These scripts recreate published results.  Besides providing an example for the
user, these scripts serve as an rudimentary QA suite.  Copy a test script to the head directory before running.  

plot_bolster.m:  Fits CBTC data in Figure 2 in McInnis, Bolster et. al., ENVIRONMENTAL ENGINEERING SCIENCE 
Volume 31, Number 12, 2014 using the spatial_fade model  

plot_chakraborty_2009.m: Fits BTC data in Figure 4, panel 2 in Chakroborty, Meerschaert, and Lim, WRR:45, 2009
using the spatial_fade model

plot_schumer_2003.m: Fits BTC data in Figure 6 in Schumer et. al., WRR 39, Vol 2003 using frac_mobile_diffusion   

misc: Misc files used for development by JFK.


