%% input data
global rho0; %for the calculation of density

%read input file
dati=load('input/data.txt');
i=0;

%case
i=i+1; caso=dati(i);

%physical parameters
i=i+1; rho0=dati(i);        %water density [kg/m^3]
i=i+1; alpha=dati(i);       %thermal expansion coeff. [K^-1]
i=i+1; beta=dati(i);        %haline contraction coeff. [kg/g]
i=i+1; cp=dati(i);          %water heat capacity [J/kg/K]
i=i+1; DT=dati(i);          %diffusion coefficient temperature [m^2/s]
i=i+1; DS=dati(i);          %diffusion coefficient salinity [m^2/s]

%duration
i=i+1; tend=dati(i);        %final time (approx., in days)

%model parameters
i=i+1; dz=dati(i);          %vertical grid step [m]
i=i+1; lambdaT=dati(i);     %numerical Peclet [-] number for temperature [-]
i=i+1; sorting=dati(i);     %0=no_sorting, 1=sorting, 2=sorting without boundary cells (is1, is2)

%boundary conditions
i=i+1; bcT=dati(i);         %1=value, 2=flux(profile), 3=flux(imposed below) [temperature]
i=i+1; bcS=dati(i);         %1=value, 2=flux(profile), 3=flux(imposed below) [salinity]


%initial perturbation
i=i+1; Tpert=dati(i);       %initial perturbation temperature [K] (0=none)
i=i+1; Spert=dati(i);       %initial perturbation salinity [g/kg] (0=none)

%sorting parameters
i=i+1; is1=dati(i);         %is1 (number of fixed cells for sorting at the top)
i=i+1; is2=dati(i);         %is2 (number of fixed cells for sorting at the bottom)
%options
i=i+1; tpause=dati(i);      %duration of pause after each plot [s]
i=i+1; saveres=dati(i);     %1=save results and figures

%imposed fluxes
i=i+1; FHtop=dati(i);       %FH [mW/m^2] heat flux (top)
i=i+1; FHbot=dati(i);       %FH [mW/m^2] heat flux (bottom)
i=i+1; FStop=dati(i);       %FS [g/s/m^2] salt flux (top)
i=i+1; FSbot=dati(i);       %FS [g/s/m^2] salt flux (bottom)

%% constants
g=9.81; % g [m/s^2] gravity acceleration

%fixed parameters
rhocp=rho0*cp;

%% unit conversions
tend=tend*86400; %final time [s]

%imposed fluxes
fTtop=FHtop*1e-3/rhocp;     %FH/(rho*cp) [K*m/s] 
fTbot=FHbot*1e-3/rhocp;     %FH/(rho*cp) [K*m/s] 
fStop=FStop/rho0;           %FS/rho [g/kg m/s] 
fSbot=FSbot/rho0;           %FS/rho [g/kg m/s] 

%% set initial condition for the selected case

%name of the file where the initial data of the examined case are stored
filecase=['case',int2str(caso)]; 

%read cases
switch caso
    case 1
        %artificial test case
        zi=100+[0;1;9;10];   % z [m] actual vertical coordinate (elevation, pointing upwards)
        Hi=max(zi)-min(zi);    % H [m] maximum depth
        za=(zi-min(zi))/Hi;    % za [-] dimensionless vertical coordinate
        Ti=10-0.3*(za-0.5);   % T [°C] temperature
        Si=10-0.05*(za-0.5);  % S [g/kg] salinity
        Si(1)=10+0.08; Si(end)=10-0.08;
    case 2
        load(['input/',filecase],'zi','Ti','Si');
    otherwise
        display(['Case ',int2str(caso),' does not exist'])
        break
end

%% file names and folders

[status,message,messageid]=mkdir('res'); % folder for results
[status,message,messageid]=mkdir('fig'); % folder for figures

%save the case read from input 
save(['input/',filecase,'_input'],'zi','Ti','Si');
