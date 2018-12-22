% Solve Equation 3.20

% Get option parameters
format long
global q sigma T;

% Set problem parameters
% x_eff is x after deletion of the first and last elements.
% Thus x_eff represent all the internal points after we introduce the
% special base Phi_b.
global x_eff tau_v x dx
N=1000;
M=500;
xmin=-13;
xmax=10;
x=linspace(xmin,xmax,N+2)';
x_eff=x(2:length(x)-1); dx=x(2)-x(1);
tau_v=linspace(0,T*(sigma^2)/2,M+1); dtau=tau_v(2)-tau_v(1);

global w;
w=zeros(length(x_eff),length(tau_v));
b=w;

global Phi_b Beta Alpha;
% Get Boundary condition in general form.
Beta=@(tau) exp(0.5*(q+1)*xmax+0.25*((q+1)^2)*tau);
dBeta=@(tau) (0.25*(q+1)^2)*Beta(tau);
Alpha=@(tau) 0;
Phi_b=@(xx,tau) (Beta(tau)-Alpha(tau)).*((xx-xmin)/(xmax-xmin))+Alpha(tau);
% As a formal argument, xx here is to distinguish from x.

% Set initial condition.
Gamma=@(x) max(exp(x.*((1/2)*(q+1)))-exp((x.*((1/2)*(q-1)))),0);
w(:,1)=Gamma(x_eff)-Phi_b(x_eff,0);

% Set b as a matrix. 
Fun_b=@(xx,tau) ((xx-xmin)/(xmax-xmin))*dx*dBeta(tau);
for i=1:length(tau_v)
    b(:,i)=Fun_b(x_eff,tau_v(i));
    % See 'FEM-YWGN-20160422' P.3
end

% Get Matrix A&B. As of 5.11(b)(c)
Temp1=SetupB(N,dx)+(dtau/2)*SetupA(N,dx);
Temp3=SetupB(N,dx)-(dtau/2)*SetupA(N,dx);
Temp2=inv(Temp1);

% Solve for w
for i=2:length(tau_v)
    w(:,i)=Temp2*(Temp3*w(:,i-1)-(dtau/2)*(b(:,i)+b(:,i-1)));
end