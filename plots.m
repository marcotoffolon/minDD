%% PLOTS
%blue: after reordering
%red: after diffusion
%cyan: initial

%-temperature
subplot(2,4,1);
hold off
plot(T_ini,z,'c');
ylim([zmin zmax]);
hold on;
plot(Td,z,'r');
plot(T,z,'b');
xlabel('T [°C]');
ylabel('z [m]');

%-salinity
subplot(2,4,2);
hold off
plot(S_ini,z,'c');
ylim([zmin zmax]);
hold on;
plot(Sd,z,'r');
plot(S,z,'b');
xlabel('S [g kg^{-1}]');

%-density
subplot(2,4,3);
hold off
plot(rho_ini,z,'c');
ylim([zmin zmax]);
hold on;
plot(rho,z,'b');
xlabel('\rho [kg m^{-3}]');

%-current time
subplot(2,4,7);
title(['t = ',num2str(t/86400),' days', ...
    ' (',int2str(k),'/',int2str(nt),')']);


%% fluxes

%-temperature
subplot(2,4,5);
hold off;
plot(FHd,zc,'r'); %diffusive
ylim([zmin zmax]);
hold on;
plot(FH,zc,'b'); %total
xlabel('F_H [W m^{-2}]');
ylabel('z [m]');

%-salinity
subplot(2,4,6);
hold off;
plot(FSd,zc,'r'); %diffusive
ylim([zmin zmax]);
hold on;
plot(FS,zc,'b'); %total
xlabel('F_S [g s^{-1} m^{-2}]');


%% other parameters

%positions
subplot(2,4,8);
hold off
plot((disp),z,'b');
ylim([zmin zmax]);
hold on;
xlabel('\Delta pos [m]');

%density ratio
subplot(2,4,4);
hold off;
plot(Rrho,zc,'b');
xlim([-1 10]);
ylim([zmin zmax]);
xlabel('R_{\rho} [-]');
hold on;