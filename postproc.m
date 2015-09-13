% post processing
%------------------------------------------------------------------------%
% select a given time step and plot results
%------------------------------------------------------------------------%

clear all; clc;
close all;
fclose all;

display('minDD - post processing');
display('select case and time in the script');

%---select case
caso=1;
%---select time (days)
t=1000;

%% read data

%data available for the case
filecase=['case',int2str(caso)]; 
filek=load(['res/',filecase,'_k.txt']);
kk=filek(:,2);      %counter
tk=filek(:,3);
[m,i]=min(abs(tk-t)); %select time closest to request
kfile=filek(i,1);   %file index
k=kk(i);
t=tk(i)*86400;      %t [s]

%% load results
load(['res/',filecase,'_ini.mat']);
load(['res/',filecase,'_param.mat']);
load(['res/',filecase,'_',int2str(kfile),'.mat']);


%- standard plots
scrsz=get(0,'ScreenSize');
fig_main=figure('position',[50 100 scrsz(3)-100 scrsz(4)-200]);
subplot(2,4,7);
plot([0 0],[0 0],'c')
hold on
plot([0 0],[0 0],'r')
plot([0 0],[0 0],'b')
hold on;
legend('initial','diffusion','sorting');

plots;
