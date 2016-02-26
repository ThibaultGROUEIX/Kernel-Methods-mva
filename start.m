Xtr=load('data/Xtr.csv');
Xte=load('data/Xte.csv');
Ytr=load('data/Ytr.mat');
Ytr=Ytr.Ytr;

%show(Xtr(2,:))

%compute K
K=zeros(length(Xtr));

