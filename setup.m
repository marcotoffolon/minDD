%--- setup for numerical solution ---

%derived parameters
tau=DS/DT;
lambdaS=tau*lambdaT; %Peclet number for salinity 
dt=lambdaT*dz^2/DT;
nt=ceil(tend/dt); %number of time steps
dtplot=30*86400; %period [s] for calc. fluxes, params + plots (approx 1 month)
ntp=dtplot/dt; i=2; ntp=ceil(ntp/10^i)*10^i;
nt=ceil(nt/ntp)*ntp;

%% boundary conditions
if(bcT==3)
    %imposed flux
    phiTbc1=fTbot;
    phiTbc2=fTtop;
elseif(bcT==2)
    %directly imposed on the basis of the initial profile
    phiTbc1=-DT*(T(2)-T(1))/dz;
    phiTbc2=-DT*(T(n)-T(n-1))/dz;
else
    phiTbc1=nan;
    phiTbc2=nan;
end
if(bcS==3)
    %imposed flux
    phiSbc1=fSbot;
    phiSbc2=fStop;
elseif(bcS==2)
    %directly imposed on the basis of the initial profile
    phiSbc1=-DS*(S(2)-S(1))/dz;
    phiSbc2=-DS*(S(n)-S(n-1))/dz;
else
    phiSbc1=nan;
    phiSbc2=nan;
end

%% initial perturbation
T(2:end-1)=T(2:end-1)+Tpert*(rand(n-2,1)-0.5);
S(2:end-1)=S(2:end-1)+Spert*(rand(n-2,1)-0.5);

%initialize temporary variables
Td=T; Sd=S; %variables to compute diffusive fluxes
calc_mass; %initial "mass" (to compute total fluxes)
mTp=mT; mSp=mS; mrhop=mrho;
colp=col;

%% plot and save profiles at time 0
%open file with output times
fidk=fopen(['res/',filecase,'_k.txt'],'w');
fprintf(fidk,'%s \r\n','% kfile, k, time [days]');
k=0;
t=0;
kfile=0;

%-- main figure
fig_main=figure('position',[50 100 scrsz(3)-100 scrsz(4)-200]);
%add legend to plots
%blue: after reordering (sorting), red: after diffusion, cyan: initial
subplot(2,4,7);
plot([0 0],[0 0],'c')
hold on
plot([0 0],[0 0],'r')
plot([0 0],[0 0],'b')
hold on;
legend('initial','diffusion','sorting');

%fluxes and parameters at initial conditions
fluxes_params; %calculate values & plot them

%-- save all parameters of the simulation and initial profiles
save(['res/',filecase,'_param'] ...
    ,'z','za','zc','S','T','zmin','zmax' ...
    ,'rho','alpha','beta','cp','rho0','rhocp' ...
    ,'T0','S0','Rrho','n' ...
    ,'lambdaT','lambdaS','tau','DT','DS','dt' ...
    ,'nt','dtplot','ntp' ...
    ,'Tpert','Spert','bcT','bcS' ...
    ,'phiTbc1','phiTbc2','phiSbc1','phiSbc2' ...
    );

