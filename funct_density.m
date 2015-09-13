function rho=funct_density(T,S,alpha,beta)
global rho0 T0 S0

rho=rho0.*(1-alpha.*(T-T0)+beta.*(S-S0));

end