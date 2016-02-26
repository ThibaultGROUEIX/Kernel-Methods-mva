Xtr=load('data/Xtr.csv');
Xte=load('data/Xte.csv');
Ytr=load('data/Ytr.mat');
Ytr=Ytr.Ytr;

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
