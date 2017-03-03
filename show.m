function []=show(im)
k=min(size(im));
m=round(sqrt(k));
n=ceil(sqrt(k));
figure;
for i=1:k
    subplot(m,n,i);
    imagesc(reshape(im(i,:),28,28))
end