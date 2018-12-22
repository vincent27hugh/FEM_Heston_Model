close all;
clear all;
% Vanilla Call Option
tic

global ksi kappa rho theta S0 v0 T r q 
K=110;% Call Strike
eta=1;

S0=100; v0=0.25;
ksi = 0.4;
kappa = 1.0;rho=-0.7;theta=0.09;
T=1;% Maturity time
r=0.05;% interest rate
q=0.01;% dividend

% Spatial Resolution
global N M NT h1 h2 dtau
N=100;M=100;NT=100;
h1=1/N;h2=1/M;dtau=T/NT;
global  vmin vmax ymin ymax
vmin=0.0;vmax=3;
ymin=-2;ymax=2;

VW=Solve(K,eta); 

[RES,OptionPrice]=plot_option(VW,K);

csvwrite('Resultlist.csv',RES);
csvwrite('OptionPrice.csv',OptionPrice);


toc
load gong.mat;
sound(y);