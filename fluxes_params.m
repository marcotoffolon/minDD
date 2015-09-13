%constants
dtp=ntp*dt;

%calculate integrals of the variables
calc_mass;

%% FLUXES and PARAMETERS

%-temperature
fTd=-DT*diff(Td)/dz; %diffusive flux
fT1=fTd(1); %diffusive flux at the bottom
fT=fT1-(mT-mTp)/dtp; %"mass" flux along z
fT2=fT(end);
%heat flux
FH=rhocp.*fT;
FHd=rhocp*fTd;

%-salinity
fSd=-DS*diff(Sd)/dz; %diffusive flux
fS1=fSd(1); %diffusive flux at the bottom
fS=fS1-(mS-mSp)/dtp; %"mass" flux along z
fS2=fS(end);
%salt mass flux
FS=rho0*fS;
FSd=rho0*fSd;

%-density ratio
Rrho=funct_Rrho(T,S,alpha,beta);

%-displacements
disp=(col-colp)*dz; % vertical movements [m]

%update
mTp=mT; mSp=mS; mrhop=mrho;

%% PLOTS
plots; %all plots

%% save data & figures
if(saveres==1)
    kfile=kfile+1;
    fprintf(fidk,'%i %i %f \r\n',kfile,k,t/86400);
    saveas(fig_main,['fig/',filecase,'_',int2str(kfile),'.png'],'png');
    save(['res/',filecase,'_',int2str(kfile),'.mat'] ...
        ,'z','T','S','rho','Rrho' ...
        ,'Td','Sd','FH','FS','FHd','FSd','disp');
end