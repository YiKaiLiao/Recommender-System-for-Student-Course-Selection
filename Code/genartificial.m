rng('shuffle')
%產生人工資料
% r=[];
%  t=normrnd(randi([60 85],1,1),randi([5 15],1,1),[1,100]);
%  r=[r ;t];
% for i=1:9
%     t2=sigmoid(zscore(t+rand(1,100)*var(t)));
%     r=[r ;t2]
%  %t=t+randi([1 floor(std(t))],1,100);
%  %rr=randi([1 floor(var(t)^0.5)],1,100);
%  %a=randi([1,5]);
% end

%c1d10n=r';

%  t=normrnd(randi([60 85],1,1),randi([5 15],1,1),[1,100]);
%  r3=[t];
% for i=1:9
%  %t=normrnd(randi([60 85],1,1),randi([5 15],1,1),[1,100]);
%  %t=t+randi([10 floor(std(t))],1,100);
%  rr=randi([1 floor(std(t))],1,100);
%  a=randi([1,5]);
%  r3 =[r3 ;a*(t+rr)]; 
% end
r2=[];
%  c1d10=r3';
 t1=normrnd(60,randi([5 15],1,1),[1,100]);
t2=normrnd(67,randi([5 15],1,1),[1,100]);
t3=normrnd(83,randi([5 15],1,1),[1,100]);
t4=normrnd(73,randi([5 15],1,1),[1,100]);
t5=normrnd(78,randi([5 15],1,1),[1,100]);
 r2=[t1;t2;t3;t4;t5];

% for i=1:5
%   t=normrnd(randi([60 85],1,1),randi([5 15],1,1),[1,100]);
%   r2=[r2 ;t];
% end
for i=1:5
 %t=normrnd(randi([60 85],1,1),randi([5 15],1,1),[1,100]);
 %t=t+randi([10 floor(std(t))],1,100);
 t=lineartr(r2(1,:))+lineartr(r2(2,:))+lineartr(r2(3,:))+lineartr(r2(4,:))+lineartr(r2(5,:));
 %rr=std(t)*rand(1,100);
 %a=randi([1,5]);
 r2 =[r2 ;t+std(t)*rand(1,100)]; 
end
 c5d10l=r2';
%  for i=1:5
%   t=normrnd(randi([60 85],1,1),randi([5 15],1,1),[1,100]);
%   r2=[r2 ;t];
% end
r3=r2;
%sigmoid(zscore(r3(:,i)))
for i=6:10
 %t=normrnd(randi([60 85],1,1),randi([5 15],1,1),[1,100]);
 %t=t+randi([10 floor(std(t))],1,100);
 %t=nonlineartr(r2(1,:))+nonlineartr(r2(2,:))+nonlineartr(r2(3,:))+nonlineartr(r2(4,:))+nonlineartr(r2(5,:));
 %t=sigmoid(zscore(r3(i,:)));
 t=nonlineartr(r3);
 %rr=std(t)*rand(1,100);
 %a=randi([1,5]);
  r3(i,:)=t+std(t)*rand(1,100);
end
 c5d10n=r3';

% for i=6:10
%    t= r6(:,1)*(rand)+r6(:,2)*(rand)+r6(:,3)*(rand)+r6(:,4)*(rand)+r6(:,5)*(rand);
% r6(:,i)=t+rand(100,1);
% end
% r6=normrnd(randi([60 85],1,1),randi([5 15],1,1),[1,100])
% r =[r ;normrnd(70,10,[1,100])];
% r =[r ;normrnd(60,8,[1,100])];
% r =[r ;normrnd(56,15,[1,100])];
% r =[r ;normrnd(80,5,[1,100])];
% r =[r ;normrnd(75,7,[1,100])];
%r5(:,1:5) = r(:,1);
%r4(:,1)=r4(:,1)*1000;
% c=1;
% for i=6:10
% r6(:,i) = sigmoid(zscore(r5(:,c)))*100;
% c=c+1;
% st=std(r5(:,i));
% r5(:,i)=r5(:,i)+rand(100,1)*(st^0.5)+1;
% end
% for i=2:10
% %r6(:,i) = r6(:,1)*(rand)+r6(:,2)*(rand)+r6(:,3)*(rand)+r6(:,4)*(rand)+r6(:,5)*(rand);
% %st=std(r6(:,i));
% t=r6(1,:)*(rand);
% t=t+rand(1,100)*std(t);
% r6=[r6 ; t];
% 
% c=c+1;
% %r6(:,i)=r6(:,i)+rand(100,1)*(st^0.5)+1;
% end
% r1(:,7) = exp(-(r(:,2)*0.01))*100;
% r1(:,8) = exp(-(r(:,3)*0.01))*100;
% r1(:,9) = exp(-(r(:,4)*0.01))*100;
% r1(:,10) = exp(-(r(:,5)*0.01))*100;
function ans=nonlineartr(t)
%ans=sigmoid(zscore(t*(rand)+std(t)*rand(1,size(t,2))));
%ans=sigmoid(zscore(t(1,:)*(rand)+t(2,:)*(rand)+t(3,:)*(rand)+t(4,:)*(rand)+t(5,:)*(rand)));
ans=sigmf2(t(1,:),[rand() mean(t(1,:))])+sigmf2(t(2,:),[rand() mean(t(2,:))])+sigmf2(t(3,:),[rand() mean(t(3,:))])...
    +sigmf2(t(4,:),[rand() mean(t(4,:))])+sigmf2(t(5,:),[rand() mean(t(5,:))]);
end
function ans=lineartr(t)
%ans=t*(rand)+std(t)*rand(1,size(t,2));
ans=t*(rand);
end
