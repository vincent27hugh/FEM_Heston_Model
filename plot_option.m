function [MW,MVq]=plot_option(VW,K)
global N M Nodesn y v v0 S0 
MW=zeros(N+1,M+1);
for i = 1:Nodesn
    b=floor((i-1)/(N+1))+1;
    a=mod(i-1,N+1)+1;
    MW(a,b)=VW(i);
end
MW=MW';

MVq=interp2(v(:,1),y(1,:),MW,v0,log(S0/K),'cubic');
disp('Option Price is: '),disp(MVq);
figure;
mesh(v(:,1),y(1,:),MW);
xlabel('Var');ylabel('log(S/K)');zlabel('OptionPrice');
title('European Call');