function [image] = compute_histograms(input)

input = (reshape(input,28,28));
lvl = graythresh(input);
img = im2bw(input,lvl);
img = input;
% figure;
% 
% subplot(1,2,1)
% imshow(input)
% 
% subplot(1,2,2)
% imshow(processedImage)
% %définir des patches sur l'image
% %calculer le gradient sur ces patche
% % en faire l'histograms
% % 
% img = processedImage;
% pause
%extractHOGFeatures
% Extract HOG features and HOG visualization
% hog_4x4 = hog_feature_vector(img,4,2);
% hog_7x7 = hog_feature_vector(img,7,2);
% hog_14x14 = hog_feature_vector(img,14,2);

[hog_4x4, vis4x4] = extractHOGFeatures(img,'CellSize',[4 4], 'Numbins', 9);
[hog_7x7, vis7x7] = extractHOGFeatures(img,'CellSize',[7 7], 'Numbins', 9);
[hog_14x14, vis14x14] = extractHOGFeatures(img,'CellSize',[14 14], 'Numbins', 9);
% size(hog_4x4)
% size(hog_14x14)
% size(hog_7x7)
% 
% %Show the original image
% figure;
% subplot(2,3,1:3); imshow(img);
% 
% %Visualize the HOG features
% subplot(2,3,4);
% plot(vis4x4);
% title({'CellSize = [4 4]'; ['Feature length = ' num2str(length(hog_4x4))]});
% 
% subplot(2,3,5);
% plot(vis7x7);
% title({'CellSize = [7 7]'; ['Feature length = ' num2str(length(hog_7x7))]});
% 
% subplot(2,3,6);
% plot(vis14x14);
% title({'CellSize = [14x14]'; ['Feature length = ' num2str(length(hog_14x14))]});
image =  [  hog_14x14(1,:),  hog_7x7(1,:), hog_4x4(1,:) ]  ;
%image =  [ hog_14x14(1,:), hog_7x7(1,:), *  hog_4x4(1,:) ]  ;
%size(image);
end
