%-- "mass" cumulate at different levels
% calculated using trapezoidal rule

% "mass" of temperature
mT=cumsum((T(1:end-1)+T(2:end))/2)*dz;  
% "mass" of salinity
mS=cumsum((S(1:end-1)+S(2:end))/2)*dz;

rhoc=(rho(1:end-1)+rho(2:end))/2; %density at the centred grid
% "mass" of density (real mass per unit surface)
mrho=cumsum(rhoc)*dz; 
