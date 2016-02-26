function [dist]= gaussian_dist(V1, V2, sigma)
    a = norm(V1-V2,2);
    dist = exp(-a*a/sigma)
end