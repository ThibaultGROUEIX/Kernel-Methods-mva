Xtr=load('data/Xtr.csv');
Xte=load('data/Xte.csv');
Ytr=load('data/Ytr.mat');
Ytr=Ytr.Ytr;

%normalize
%Xtr=normr(Xtr);

%problem parameters

validation=0;
rotate=false;
nrotate=0;

%validation set23

if (validation>0)
            Xval=Xtr(4001:5000,:);
            Xtr=Xtr(1:1000,:);
            Yval = Ytr(4001:5000,:);
            Ytr = Ytr(1:1000,:);
            if (~rotate)
               Xval = preprocess_training_set(Xval);
            end
end
%Xtr=augment(Xtr,7.47);  %data augmentation, rotation training set
%Ytr=[Ytr;Ytr;Ytr];

n=length(Xtr);
Xtr = preprocess_training_set(Xtr);
if (~rotate)
    Xte = preprocess_training_set(Xte);
end
lambda= 0.00004;
sigma = 50;

   
%problem parameters
K = compute_k(Xtr, sigma);

%compute alpha
for num=1:10  %on regarde si l'image correspond au chiffre num-1
    label=single(Ytr(:,2) == num-1)-single(Ytr(:,2)~=num-1);
    alpha{num}=(K+lambda*n*eye(n))\label;
end

disp('compute scores for the validation set')
score=compute_score(n,alpha,Xval,Xtr,sigma,1); %set last parameter to 1 to track progress
[~,attrib] = max(score, [], 2);
attrib = (attrib-1);
diff=(attrib-Yval(:,2)) == 0;
error =100 - 100* norm(single(diff),1)/1000
%        csvwrite('Yte',attrib);
% 
% 
disp('compute scores for the test set')
score=compute_score(n,alpha,Xte,Xtr,sigma,1); %set last parameter to 1 to track progress
[~,attrib]=max(score,[],2);
attrib = (attrib-1);
save('score_benchmark.mat','score');
csvwrite('Yte',attrib);
% 
% 
