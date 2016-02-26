function [K]= compute_k(Xtr, sigma)
    K = zeros(length(Xtr), length(Xtr));
    for i = 1:length(Xtr)
        for j= 1:i
            K(i,j) =  gaussian_dist(Xtr(i,:), Xtr(j,:), sigma);
            K(j,i) = K(i,j);
        end
    end
end