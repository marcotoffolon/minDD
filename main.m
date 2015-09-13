% minDD -----------------------------------------------------------------%
% MINimal model for Double Diffusion ------------------------------------%
%------------------------------------------------------------------------%
%------------------------------------------------------------------------%
%
% These scripts represent a basic version of the model 
% that was used in the publication cited below.
% The numerical kernel is identical, but the 
% pre- and post-processing is much simpler in this version.
%
%------------------------------------------------------------------------%
% REFERENCE to be used when citing the model:
%
% Toffolon, M., A. Wüest, T. Sommer, Minimal model for double diffusion 
% and its application to Kivu, Nyos and Powell Lake, J. Geophys. Res, 120,
% doi:10.1002/2015JC010970
%
%------------------------------------------------------------------------%
% AUTHOR:
%
% Marco Toffolon
% Department of Civil, Environmental and Mechanical Engineering, 
% University of Trento, Italy. (marco.toffolon@unitn.it)
%
%------------------------------------------------------------------------%
% 
% VERSION: 1.0.0 (September 2015)
%
%------------------------------------------------------------------------%

clear all; clc;
close all;
fclose all;

display('minDD - MINimal model for Double Diffusion');
display('version 1.0.0');

%% CODE 

% pre-processing
input_prep;         % read input data and prepare all variables
%------------------------------------------------------------------------%
% INPUT:    \input\data.txt
%           (\input\caseX.mat)
% OUTPUT:   \input\caseX_input.mat
%------------------------------------------------------------------------%

% build initial profiles
initial_profiles;   % define and plot the reference profiles
%------------------------------------------------------------------------%
% OUTPUT:   figure 1
%           \fig\caseX_ini.png      (if saveres=1)
%           \res\caseX_ini.mat      (if saveres=1)
%------------------------------------------------------------------------%

% setup of the model
setup;             % set all the parameters for the model
%------------------------------------------------------------------------%
% OUTPUT:   \res\caseX_param.mat    (if saveres=1)
%------------------------------------------------------------------------%

% DD kernel
numerical_solution;     % solve the diffusion equation and reordering
%------------------------------------------------------------------------%
% OUTPUT:   figure 2 (redrawn at each plotting time step)
%           \fig\caseX_Y.png        (if saveres=1)
%           \res\caseX_Y.mat        (if saveres=1)
%------------------------------------------------------------------------%

fclose all; %close all files

display('The end');
