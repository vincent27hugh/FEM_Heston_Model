function [Nodes_v]=GetNodes
% Get nodes value
global K x tau_v Phi_b w q
Base=zeros(length(x),length(tau_v));
for i=1:length(x)
    for k=1:length(tau_v)
        Base(i,k)=Phi_b(x(i),tau_v(k));
    end
end

tempz=zeros(1,length(tau_v));
Nodes_y=[tempz; w; tempz];
Nodes_y=Nodes_y+Base;

Nodes_v=Nodes_y;
tempAx=(-0.5)*(q-1)*x;
tempAtau=(-0.25)*((q+1)^2)*tau_v;
for i=1:length(x)
    for k=1:length(tau_v)
        Nodes_v(i,k)=(K*exp(tempAx(i)+tempAtau(k)))*Nodes_y(i,k);
    end
end
clear tempAx tempAtau Base