Xtr=load('data/Xtr.csv');
Xte=load('data/Xte.csv');
Ytr=load('data/Ytr.mat');
Ytr=Ytr.Ytr;

%problem constants
n=length(Xtr);

%show(Xtr(2,:))


%compute f
for num=1:10  %on regarde si l'image correspond au chiffre num-1
    
    alpha=(K+lambda*n*eye(n))\Ytr(:,2);
    function [res]=f(im)
    res=zeros(10,1);
    gaussian_dist()
    end
end

%compute K
K=zeros(length(Xtr));


