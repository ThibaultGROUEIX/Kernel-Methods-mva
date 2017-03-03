function score=compute_score_rotate(n,alpha,Xte,Xtr,sigma,print,nrotate)


score=zeros(size(Xte,1),10);  %proba que le ie testé est le chifre j

%rotate images
for j=1:size(Xte,1)
    anglestep=round(30/(nrotate-1));
    xtest=reshape(Xte(j,:),28,28);
    count=0;
    for step=-15:anglestep:anglestep*(nrotate-1)-15
             count=count+1;
             anglerot=step;
             xrotate2828=imrotate(xtest,anglerot,'crop');
             xrotate{count,j}=compute_histograms(reshape(xrotate2828,1,28*28));
    end
end
['rotated images computed']


for digit=1:10 %for each digit 'digit-1'
    tic
    %compute probability vector
    for i=1:size(Xte,1)
        a=alpha{digit}; %vector alpha
        output=zeros(nrotate,1);
        for j=1:n
            x=Xtr(j,:); %train histogramme
            for k=1:size(xrotate,1)
                output(k)=output(k)+a(j)*gaussian_dist(x,(xrotate{k,i}),sigma);
            end
        end
        [finaloutput,check]=max(output);
%         if(print>0 && mod(j,1000)==0)
%              ['image ' num2str(i)]
%         end  
        score(i,digit)=finaloutput;
        if (mod(i,1000)==0)
          %  i
        end
    end
     if (print>0)
     [num2str(digit) 'e chiffre computed in ' num2str(toc) ' seconds.']

     end
    score;
    save('scorepartiel.mat','score');
end