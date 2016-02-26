Xtr=load('data/Xtr.csv');
Xte=load('data/Xte.csv');
Ytr=load('data/Ytr.mat');
Ytr=Ytr.Ytr;

%problem constants
n=length(Xtr);

%problem parameters
lambda= 1;
sigma = 1;

%show(Xtr(2,:))


%compute K

tic
K = compute_k(Xtr, sigma);
save('K.mat','K');
toc



%compute alpha
for num=1:10  %on regarde si l'image correspond au chiffre num-1
    alpha{num}=(K+lambda*n*eye(n))\Ytr(:,2);
end

%compute scores
score=compute_score(n,alpha,Xte,Xtr,sigma,1); %set last parameter to 1 to track progress
attrib=max(score);


