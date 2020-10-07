function [ansx,mpart]=missingdata(X,p)
%X:資料 , p missing rate

rng('shuffle');
%rng('default')
ix = random('unif',0,1,size(X))<0.1*(p*0.1);
tx=X;
tx(ix)=NaN;
ansx=tx;
mpart=(ix==1);
end
