function score=compute_score(n,alpha,Xte,Xtr,sigma,print)

score=zeros(length(Xte),10);  %proba que le ie testé est le chifre j
for digit=1:10 %for each digit 'digit-1'
    %compute probability vector
    if (print>0)
     [num2str(digit) 'e chiffre']
    end
    for i=1:length(Xte)
        a=alpha{digit}; %vector alpha
        x=Xte(i,:); %test image
        output=0;
        for j=1:n
            output=output+a(j)*gaussian_dist(x,Xtr(j,:), sigma);
        end
        if(print>0 && mod(j,1000)==0)
             ['image ' num2str(i)]
        end        
    end
    score(i,digit)=output;
    digit
end