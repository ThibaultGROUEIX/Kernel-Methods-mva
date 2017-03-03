function [X] = preprocess_training_set(Xtr)

    n = length(Xtr);
    for i = 1:n
        im=Xtr(i,:);
        im=reshape(im,28,28);
        X(i,:) = compute_histograms(im);
    end
end