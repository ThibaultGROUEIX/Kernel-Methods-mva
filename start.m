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
K = zeros(length(Xtr), length(Xtr));
for i = 1:length(Xtr)
    i
    for j= 1:i
        K(i,j) =  gaussian_dist(Xtr(i,:), Xtr(j,:), sigma);
        K(j,i) = K(i,j);
    end
end
toc


%compute f

for num=1:10  %on regarde si l'image correspond au chiffre num-1
    
    alpha=(K+lambda*n*eye(n))\Ytr(:,2);
     [res]=f(im)
    res=zeros(10,1);
    gaussian_dist()
    
end
