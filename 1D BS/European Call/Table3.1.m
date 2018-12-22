function res=NodesTest(~)
% This function compare FEM solution with BS Solution at nodes of x domain

global x K r T sigma Nodes_v tau_v;

x_test=x(500:10:length(x)-300);
y_test=x_test; index=x_test;
for i=1:length(x_test)
    index(i)=find(x==x_test(i));
    y_test(i)=Nodes_v(index(i),length(tau_v));
end
s_test=K*exp(x_test);
[y_exact,~]=blsprice(s_test,K,r,T,sigma);
RE=(y_test-y_exact)./y_exact;
res=[s_test y_test y_exact RE];
return