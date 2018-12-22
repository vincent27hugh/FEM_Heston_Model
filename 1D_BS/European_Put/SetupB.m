function MassM=SetupB(N,h)
B=zeros(N,N);
temp = [1,4,1];
for i=2:N-1
    B(i,i-1:i+1)=temp;
end
B(1,1:2)=[4,1];
B(N,N-1:N)=[1,4];

B=(h/6)*B;

MassM=B;
return