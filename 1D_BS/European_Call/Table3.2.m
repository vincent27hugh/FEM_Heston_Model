function res=NumRes(~)
global K r T sigma x Nodes_v tau_v;
s_res=(80:5:150)';
x_res=log((1/K)*s_res);
y_res_fem=interp1(x,Nodes_v(:,length(tau_v)),x_res,'pchip');
[y_exact,~]=blsprice(s_res,K,r,T,sigma);
RE=(y_res_fem-y_exact)./y_exact;
res=[s_res y_res_fem y_exact RE];
return