%% preparation of matrix linear system

%--temperature
diagT=zeros(n,1);upT=zeros(n-1,1);lowT=zeros(n-1,1);
BT=zeros(n,1);
%tridiagonal matrix
diagT(1:n)=1+2*lambdaT;
upT(1:n-1)=-lambdaT;
lowT(1:n-1)=-lambdaT;

%--salinity
diagS=zeros(n,1);upS=zeros(n-1,1);lowS=zeros(n-1,1);
BS=zeros(n,1);
%tridiagonal matrix
diagS(1:n)=1+2*lambdaS;
upS(1:n-1)=-lambdaS;
lowS(1:n-1)=-lambdaS;

%% boundary conditions
if(bcT==1) %Dirichlet
    %matrix
    diagT(1)=1; upT(1)=0;
    diagT(n)=1; lowT(n-1)=0;
    %known term
    BT(1)=T(1);
    BT(n)=T(n);
elseif(bcT>=2) %Neumann
    %matrix
    diagT(1)=1; upT(1)=-1;
    diagT(n)=-1; lowT(n-1)=1;
    %known term
    BT(1)=phiTbc1*dz/DT;
    BT(n)=phiTbc2*dz/DT;
end
if(bcS==1) %Dirichlet
    %matrix
    diagS(1)=1; upS(1)=0;
    diagS(n)=1; lowS(n-1)=0;
    %known term
    BS(1)=S(1);
    BS(n)=S(n);
elseif(bcS>=2) %Neumann
    %matrix
    diagS(1)=1; upS(1)=-1;
    diagS(n)=-1; lowS(n-1)=1;
    %known term
    BS(1)=phiSbc1*dz/DS;
    BS(n)=phiSbc2*dz/DS;
end

%% temporal cycle

ntpt=1; %initial step for plotting
ampl=2; %amplification of step for plotting
tic
for k=1:nt
    t=t+dt;
    %--diffusion step: linear system
    BS(2:n-1)=S(2:n-1);
    S=funct_thomas(diagS,upS,lowS,BS);
    BT(2:n-1)=T(2:n-1);
    T=funct_thomas(diagT,upT,lowT,BT);

    %--calculate density
    rho=funct_density(T,S,alpha,beta);
    %variables after the diffusion step
    Td=T;
    Sd=S;
    
    %--sorting
    %if sorting=0 : only diffusion
    %otherwise : reordering of unstable regions
    if(sorting==1)
        %sorting the whole column
        [rho,is]=sort(rho,'descend');
        T=T(is);
        S=S(is);
        col=col(is);
    elseif(sorting==2)
        %sorting the column with the exception of the two boudanry layers
        pp=rho(is1:end-is2);
        [pp,is]=sort(pp,'descend');
        rho=[rho(1:is1-1);pp;rho(end-is2+1:end)];
        pp=T(is1:end-is2);
        T=[T(1:is1-1);pp(is);T(end-is2+1:end)];
        pp=S(is1:end-is2);
        S=[S(1:is1-1);pp(is);S(end-is2+1:end)];
        pp=col(is1:end-is2);
        col=[col(1:is1-1) pp(is) col(end-is2+1:end)];
    end
    
    if(mod(k,ntpt)==0)
        %plotting the results at given times
        ntpt=min(ntp,floor(ntpt*ampl));
        fluxes_params;
        drawnow
        if(tpause>0)
            pause(tpause);
        end
    end
    colp=col;   %update positions
    
end
toc