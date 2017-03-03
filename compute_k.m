function [K]= compute_k(Xtr, sigma)
    n = size(Xtr,1);
    K = zeros(n, n);
    for i = 1:n
        for j= 1:i
            K(i,j) =  gaussian_dist(Xtr(i,:), Xtr(j,:), sigma);
            K(j,i) = K(i,j);
        end
        i
     end
end