function Xres=augment(Xtr,angle)

Xres=Xtr;
n=size(Xtr,1);
for i=1:n
    im=reshape(Xtr(i,:),28,28);
    Xres(n+i,:)=reshape(imrotate(im,angle,'crop'),1,28*28);
    Xres(2*n+i,:)=reshape(imrotate(im,-angle,'crop'),1,28*28);
end