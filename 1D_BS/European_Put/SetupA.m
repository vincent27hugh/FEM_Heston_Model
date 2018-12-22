function StiffnessM=SetupA(N,h)
A=zeros(N,N);
temp = [-1,2,-1];
for i=2:N-1
    A(i,i-1:i+1)=temp;
end
A(1,1:2)=[2,-1];
A(N,N-1:N)=[-1,2];

A=(1/h)*A;

StiffnessM=A;
return