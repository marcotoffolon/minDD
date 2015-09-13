%% initial reference profiles
global T0 S0; %for the calculation of density

% vertical coordinate with the assigned dz
za=(zi-min(zi))/(max(zi)-min(zi)); %dimensionless vertical coordinate
z=(min(zi):dz:max(zi)); 
if(size(z,1)==1)
    z=z'; % (the system works with column vectors)
end
n=length(z); %number of grid points

% resample the vertical profiles
T=interp1(zi,Ti,z);
S=interp1(zi,Si,z);

% new range
zmin=min(z);
zmax=max(z);
H=zmax-zmin;

% initial positions of particles
col=(1:n);

% centered vertical coordinate (for fluxes)
zc=(z(1:end-1)+z(2:end))/2;

% reference values
S0=mean(S);
T0=mean(T);

% thermpophysical properties
rho=funct_density(T,S,alpha,beta);
Rrho=funct_Rrho(T,S,alpha,beta); %parameter R_rho [-]

% initial profiles
T_ini=T;
S_ini=S;
rho_ini=rho;

%% plot
scrsz=get(0,'ScreenSize');
fig_ini=figure('position',[50 100 scrsz(3)-100 scrsz(4)-200]);

%temperature
subplot(1,4,1);
plot(T,z,'b');
ylim([zmin zmax]);
xlabel('T [°C]');
ylabel('z [m]');

%salinity
subplot(1,4,2);
plot(S,z,'b');
ylim([zmin zmax]);
xlabel('S [g/kg]');

%density
subplot(1,4,3);
plot(rho,z,'b');
ylim([zmin zmax]);
xlabel('\rho [kg/m^3]');

%R_rho
subplot(1,4,4);
plot(Rrho,zc,'b');
ylim([zmin zmax]);
xlim([-1 10]);
xlabel('R_{\rho} [-]');


%% save data and figure of initial profile
save(['res/',filecase,'_ini'],'z','T_ini','S_ini','rho_ini');
if(saveres==1)
    saveas(fig_ini,['fig/',filecase,'_ini.png'],'png');
end
