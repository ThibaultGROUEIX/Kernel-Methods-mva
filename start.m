Xtr=load('data/Xtr.csv');
Xte=load('data/Xte.csv');
Ytr=load('data/Ytr.mat');
Ytr=Ytr.Ytr;

%problem constants
n=length(Xtr);

%problem parameters
%show(Xtr(2,:))


%compute K

tic
sigma = 1;
K = compute_k(Xtr, sigma);
toc



%compute f

for num=1:10  %on regarde si l'image correspond au chiffre num-1
    alpha{num}=(K+lambda*n*eye(n))\Ytr(:,2);
end


%compute probability vector
for i=1:n
    x=Xte(i,:); %test image
    output=0;
    for j=1:n
        output=output+
    end
end


