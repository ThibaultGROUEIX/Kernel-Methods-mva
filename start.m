Xtr=load('data/Xtr.csv');
Xte=load('data/Xte.csv');
Ytr=load('data/Ytr.mat');
Ytr=Ytr.Ytr;

%problem constants
n=length(Xtr);

%show(Xtr(2,:))




%compute K

tic
sigma = 1;
K = compute_k(Xtr, sigma);
toc


%compute f

for num=1:10  %on regarde si l'image correspond au chiffre num-1
    
    alpha=(K+lambda*n*eye(n))\Ytr(:,2);
     [res]=f(im)
    res=zeros(10,1);
    gaussian_dist()
    
end
