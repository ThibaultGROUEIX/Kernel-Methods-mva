function [feature] = hog_feature_vector(im, Ncells, Nblocks)
%followed instructions from 'Histograms of Oriented Gradients for Human
%Detection'
%Navneet Dalal and Bill Triggs

im=double(im);

rows=size(im,1);
cols=size(im,2);
Ix=im; %Basic Matrix assignment
Iy=im; %Basic Matrix assignment

% Gradients in X and Y direction. Iy is the gradient in X direction and Iy
% is the gradient in Y direction
for i=1:rows-2
    Iy(i,:)=(im(i,:)-im(i+2,:));
end
for i=1:cols-2
    Ix(:,i)=(im(:,i)-im(:,i+2));
end

gauss=fspecial('gaussian',0.5 * Nblocks* Ncells); %% Initialized a gaussian filter with sigma=0.5 * block width.    


angle=atand(Ix./Iy); % Matrix containing the angles of each edge gradient
angle=imadd(angle,90); %Angles in range (0,180)
magnitude=sqrt(Ix.^2 + Iy.^2);

% figure,imshow(uint8(angle));
% figure,imshow(uint8(magnitude));

% Remove redundant pixels in an image. 
angle(isnan(angle))=0;
magnitude(isnan(magnitude))=0;

feature=[]; %initialized the feature vector
num_block_x = Nblocks;
num_block_y = Nblocks;
num_cell_x = Ncells;
num_cell_y = Ncells;
% Iterations for Blocks
for i = 0: rows/num_cell_x - 2
    for j= 0: cols/num_cell_y -2
        %disp([i,j])
        
        mag_patch = magnitude(num_cell_x*i+1 : num_cell_x*i+num_block_x*num_cell_x , num_cell_x*j+1 : num_cell_x*j+num_cell_x*num_block_x);
        mag_patch = imfilter(mag_patch,gauss);
        ang_patch = angle(num_cell_x*i+1 : num_cell_x*i+num_block_x*num_cell_x , num_cell_x*j+1 : num_cell_x*j+num_cell_x*num_block_x);
        
        block_feature= zeros(1,num_block_x * num_block_x * 9 );
        
        %Iterations for cells in a block
        for x= 0:(num_block_x-1)
            for y= 0:(num_block_y-1)
                angleA =ang_patch(num_cell_x*x+1:num_cell_x*x+num_cell_x, num_cell_x*y+1:num_cell_x*y+num_cell_x);
                magA   =mag_patch(num_cell_x*x+1:num_cell_x*x+num_cell_x, num_cell_x*y+1:num_cell_x*y+num_cell_x); 
                histr  = zeros(9,4,4);
                
                %Iterations for pixels in one cell
                for p=1:num_cell_x
                    for q=1:num_cell_x
                        p_real = x*num_cell_x + p;
                        q_real = y*num_cell_y + q;
                        [ap,bp] = computeLowerHistBin(p_real, num_cell_x);
                        [aq,bq] = computeLowerHistBin(q_real, num_cell_x);
                        poid_x = 1 - ( p_real-ap )/ num_cell_x;
                        poid_y = 1 - ( q_real-aq )/ num_cell_x;

                        alpha= angleA(p,q);
                        
                        % Binning Process (Bi-Linear Interpolation)
                            if alpha>10 && alpha<=30
                                histr(1,bp,bq)=histr(1,bp,bq)+ magA(p,q)*(30-alpha)/20 * poid_x * poid_y;
                                histr(2,bp,bq)=histr(2,bp,bq)+ magA(p,q)*(alpha-10)/20 * poid_x * poid_y;
                            elseif alpha>30 && alpha<=50
                                histr(2,bp,bq)=histr(2,bp,bq)+ magA(p,q)*(50-alpha)/20 * poid_x * poid_y;                 
                                histr(3,bp,bq)=histr(3,bp,bq)+ magA(p,q)*(alpha-30)/20 * poid_x * poid_y;
                            elseif alpha>50 && alpha<=70
                                histr(3,bp,bq)=histr(3,bp,bq)+ magA(p,q)*(70-alpha)/20 * poid_x * poid_y;
                                histr(4,bp,bq)=histr(4,bp,bq)+ magA(p,q)*(alpha-50)/20 * poid_x * poid_y;
                            elseif alpha>70 && alpha<=90
                                histr(4,bp,bq)=histr(4,bp,bq)+ magA(p,q)*(90-alpha)/20 * poid_x * poid_y;
                                histr(5,bp,bq)=histr(5,bp,bq)+ magA(p,q)*(alpha-70)/20 * poid_x * poid_y;
                            elseif alpha>90 && alpha<=110
                                histr(5,bp,bq)=histr(5,bp,bq)+ magA(p,q)*(110-alpha)/20 * poid_x * poid_y;
                                histr(6,bp,bq)=histr(6,bp,bq)+ magA(p,q)*(alpha-90)/20 * poid_x * poid_y;
                            elseif alpha>110 && alpha<=130
                                histr(6,bp,bq)=histr(6,bp,bq)+ magA(p,q)*(130-alpha)/20 * poid_x * poid_y;
                                histr(7,bp,bq)=histr(7,bp,bq)+ magA(p,q)*(alpha-110)/20 * poid_x * poid_y;
                            elseif alpha>130 && alpha<=150
                                histr(7,bp,bq)=histr(7,bp,bq)+ magA(p,q)*(150-alpha)/20 * poid_x * poid_y;
                                histr(8,bp,bq)=histr(8,bp,bq)+ magA(p,q)*(alpha-130)/20 * poid_x * poid_y;
                            elseif alpha>150 && alpha<=170
                                histr(8,bp,bq)=histr(8,bp,bq)+ magA(p,q)*(170-alpha)/20 * poid_x * poid_y;
                                histr(9,bp,bq)=histr(9,bp,bq)+ magA(p,q)*(alpha-150)/20 * poid_x * poid_y;
                            elseif alpha>=0 && alpha<=10
                                histr(1,bp,bq)=histr(1,bp,bq)+ magA(p,q)*(alpha+10)/20 * poid_x * poid_y;
                                histr(9,bp,bq)=histr(9,bp,bq)+ magA(p,q)*(10-alpha)/20 * poid_x * poid_y;
                            elseif alpha>170 && alpha<=180
                                histr(9,bp,bq)=histr(9,bp,bq)+ magA(p,q)*(190-alpha)/20 * poid_x * poid_y;
                                histr(1,bp,bq)=histr(1,bp,bq)+ magA(p,q)*(alpha-170)/20 * poid_x * poid_y;
                            end
                            
                            
                            %%%2
                                                    % Binning Process (Bi-Linear Interpolation)
                            if alpha>10 && alpha<=30
                                histr(1,bp + 1,bq)=histr(1,bp + 1,bq)+ magA(p,q)*(30-alpha)/20 * (1 - poid_x) * poid_y;
                                histr(2,bp + 1,bq)=histr(2,bp + 1,bq)+ magA(p,q)*(alpha-10)/20 * (1 - poid_x) * poid_y;
                            elseif alpha>30 && alpha<=50
                                histr(2,bp + 1,bq)=histr(2,bp + 1,bq)+ magA(p,q)*(50-alpha)/20 * (1 - poid_x) * poid_y;                 
                                histr(3,bp + 1,bq)=histr(3,bp + 1,bq)+ magA(p,q)*(alpha-30)/20 * (1 - poid_x) * poid_y;
                            elseif alpha>50 && alpha<=70
                                histr(3,bp + 1,bq)=histr(3,bp + 1,bq)+ magA(p,q)*(70-alpha)/20 * (1 - poid_x) * poid_y;
                                histr(4,bp + 1,bq)=histr(4,bp + 1,bq)+ magA(p,q)*(alpha-50)/20 * (1 - poid_x) * poid_y;
                            elseif alpha>70 && alpha<=90
                                histr(4,bp + 1,bq)=histr(4,bp + 1,bq)+ magA(p,q)*(90-alpha)/20 * (1 - poid_x) * poid_y;
                                histr(5,bp + 1,bq)=histr(5,bp + 1,bq)+ magA(p,q)*(alpha-70)/20 * (1 - poid_x) * poid_y;
                            elseif alpha>90 && alpha<=110
                                histr(5,bp + 1,bq)=histr(5,bp + 1,bq)+ magA(p,q)*(110-alpha)/20 * (1 - poid_x) * poid_y;
                                histr(6,bp + 1,bq)=histr(6,bp + 1,bq)+ magA(p,q)*(alpha-90)/20 * (1 - poid_x) * poid_y;
                            elseif alpha>110 && alpha<=130
                                histr(6,bp + 1,bq)=histr(6,bp + 1,bq)+ magA(p,q)*(130-alpha)/20 * (1 - poid_x) * poid_y;
                                histr(7,bp + 1,bq)=histr(7,bp + 1,bq)+ magA(p,q)*(alpha-110)/20 * (1 - poid_x) * poid_y;
                            elseif alpha>130 && alpha<=150
                                histr(7,bp + 1,bq)=histr(7,bp + 1,bq)+ magA(p,q)*(150-alpha)/20 * (1 - poid_x) * poid_y;
                                histr(8,bp + 1,bq)=histr(8,bp + 1,bq)+ magA(p,q)*(alpha-130)/20 * (1 - poid_x) * poid_y;
                            elseif alpha>150 && alpha<=170
                                histr(8,bp + 1,bq)=histr(8,bp + 1,bq)+ magA(p,q)*(170-alpha)/20 * (1 - poid_x) * poid_y;
                                histr(9,bp + 1,bq)=histr(9,bp + 1,bq)+ magA(p,q)*(alpha-150)/20 * (1 - poid_x) * poid_y;
                            elseif alpha>=0 && alpha<=10
                                histr(1,bp + 1,bq)=histr(1,bp + 1,bq)+ magA(p,q)*(alpha+10)/20 * (1 - poid_x) * poid_y;
                                histr(9,bp + 1,bq)=histr(9,bp + 1,bq)+ magA(p,q)*(10-alpha)/20 * (1 - poid_x) * poid_y;
                            elseif alpha>170 && alpha<=180
                                histr(9,bp + 1,bq)=histr(9,bp + 1,bq)+ magA(p,q)*(190-alpha)/20 * (1 - poid_x) * poid_y;
                                histr(1,bp + 1,bq)=histr(1,bp + 1,bq)+ magA(p,q)*(alpha-170)/20 * (1 - poid_x) * poid_y;
                            end
                            
                            %%%3
                            
                                                    % Binning Process (Bi-Linear Interpolation)
                            if alpha>10 && alpha<=30
                                histr(1,bp,bq + 1)=histr(1,bp,bq + 1)+ magA(p,q)*(30-alpha)/20 * poid_x * (1  - poid_y);
                                histr(2,bp,bq + 1)=histr(2,bp,bq + 1)+ magA(p,q)*(alpha-10)/20 * poid_x * (1  - poid_y);
                            elseif alpha>30 && alpha<=50
                                histr(2,bp,bq + 1)=histr(2,bp,bq + 1)+ magA(p,q)*(50-alpha)/20 * poid_x * (1  - poid_y);                 
                                histr(3,bp,bq + 1)=histr(3,bp,bq + 1)+ magA(p,q)*(alpha-30)/20 * poid_x * (1  - poid_y);
                            elseif alpha>50 && alpha<=70
                                histr(3,bp,bq + 1)=histr(3,bp,bq + 1)+ magA(p,q)*(70-alpha)/20 * poid_x * (1  - poid_y);
                                histr(4,bp,bq + 1)=histr(4,bp,bq + 1)+ magA(p,q)*(alpha-50)/20 * poid_x * (1  - poid_y);
                            elseif alpha>70 && alpha<=90
                                histr(4,bp,bq + 1)=histr(4,bp,bq + 1)+ magA(p,q)*(90-alpha)/20 * poid_x * (1  - poid_y);
                                histr(5,bp,bq + 1)=histr(5,bp,bq + 1)+ magA(p,q)*(alpha-70)/20 * poid_x * (1  - poid_y);
                            elseif alpha>90 && alpha<=110
                                histr(5,bp,bq + 1)=histr(5,bp,bq + 1)+ magA(p,q)*(110-alpha)/20 * poid_x * (1  - poid_y);
                                histr(6,bp,bq + 1)=histr(6,bp,bq + 1)+ magA(p,q)*(alpha-90)/20 * poid_x * (1  - poid_y);
                            elseif alpha>110 && alpha<=130
                                histr(6,bp,bq + 1)=histr(6,bp,bq + 1)+ magA(p,q)*(130-alpha)/20 * poid_x * (1  - poid_y);
                                histr(7,bp,bq + 1)=histr(7,bp,bq + 1)+ magA(p,q)*(alpha-110)/20 * poid_x * (1  - poid_y);
                            elseif alpha>130 && alpha<=150
                                histr(7,bp,bq + 1)=histr(7,bp,bq + 1)+ magA(p,q)*(150-alpha)/20 * poid_x * (1  - poid_y);
                                histr(8,bp,bq + 1)=histr(8,bp,bq + 1)+ magA(p,q)*(alpha-130)/20 * poid_x * (1  - poid_y);
                            elseif alpha>150 && alpha<=170
                                histr(8,bp,bq + 1)=histr(8,bp,bq + 1)+ magA(p,q)*(170-alpha)/20 * poid_x * (1  - poid_y);
                                histr(9,bp,bq + 1)=histr(9,bp,bq + 1)+ magA(p,q)*(alpha-150)/20 * poid_x * (1  - poid_y);
                            elseif alpha>=0 && alpha<=10
                                histr(1,bp,bq + 1)=histr(1,bp,bq + 1)+ magA(p,q)*(alpha+10)/20 * poid_x * (1  - poid_y);
                                histr(9,bp,bq + 1)=histr(9,bp,bq + 1)+ magA(p,q)*(10-alpha)/20 * poid_x * (1  - poid_y);
                            elseif alpha>170 && alpha<=180
                                histr(9,bp,bq + 1)=histr(9,bp,bq + 1)+ magA(p,q)*(190-alpha)/20 * poid_x * (1  - poid_y);
                                histr(1,bp,bq + 1)=histr(1,bp,bq + 1)+ magA(p,q)*(alpha-170)/20 * poid_x * (1  - poid_y);
                            end
                            
                            %%%%%4
                                   
                                                    % Binning Process (Bi-Linear Interpolation)
                            if alpha>10 && alpha<=30
                                histr(1,bp + 1,bq + 1)=histr(1,bp + 1,bq + 1)+ magA(p,q)*(30-alpha)/20 * (1  - poid_x) * (1  - poid_y);
                                histr(2,bp + 1,bq + 1)=histr(2,bp + 1,bq + 1)+ magA(p,q)*(alpha-10)/20 * (1  - poid_x) * (1  - poid_y);
                            elseif alpha>30 && alpha<=50
                                histr(2,bp + 1,bq + 1)=histr(2,bp + 1,bq + 1)+ magA(p,q)*(50-alpha)/20 * (1  - poid_x) * (1  - poid_y);                 
                                histr(3,bp + 1,bq + 1)=histr(3,bp + 1,bq + 1)+ magA(p,q)*(alpha-30)/20 * (1  - poid_x) * (1  - poid_y);
                            elseif alpha>50 && alpha<=70
                                histr(3,bp + 1,bq + 1)=histr(3,bp + 1,bq + 1)+ magA(p,q)*(70-alpha)/20 * (1  - poid_x) * (1  - poid_y);
                                histr(4,bp + 1,bq + 1)=histr(4,bp + 1,bq + 1)+ magA(p,q)*(alpha-50)/20 * (1  - poid_x) * (1  - poid_y);
                            elseif alpha>70 && alpha<=90
                                histr(4,bp + 1,bq + 1)=histr(4,bp + 1,bq + 1)+ magA(p,q)*(90-alpha)/20 * (1  - poid_x) * (1  - poid_y);
                                histr(5,bp + 1,bq + 1)=histr(5,bp + 1,bq + 1)+ magA(p,q)*(alpha-70)/20 * (1  - poid_x) * (1  - poid_y);
                            elseif alpha>90 && alpha<=110
                                histr(5,bp + 1,bq + 1)=histr(5,bp + 1,bq + 1)+ magA(p,q)*(110-alpha)/20 * (1  - poid_x) * (1  - poid_y);
                                histr(6,bp + 1,bq + 1)=histr(6,bp + 1,bq + 1)+ magA(p,q)*(alpha-90)/20 * (1  - poid_x) * (1  - poid_y);
                            elseif alpha>110 && alpha<=130
                                histr(6,bp + 1,bq + 1)=histr(6,bp + 1,bq + 1)+ magA(p,q)*(130-alpha)/20 * (1  - poid_x) * (1  - poid_y);
                                histr(7,bp + 1,bq + 1)=histr(7,bp + 1,bq + 1)+ magA(p,q)*(alpha-110)/20 * (1  - poid_x) * (1  - poid_y);
                            elseif alpha>130 && alpha<=150
                                histr(7,bp + 1,bq + 1)=histr(7,bp + 1,bq + 1)+ magA(p,q)*(150-alpha)/20 * (1  - poid_x) * (1  - poid_y);
                                histr(8,bp + 1,bq + 1)=histr(8,bp + 1,bq + 1)+ magA(p,q)*(alpha-130)/20 * (1  - poid_x) * (1  - poid_y);
                            elseif alpha>150 && alpha<=170
                                histr(8,bp + 1,bq + 1)=histr(8,bp + 1,bq + 1)+ magA(p,q)*(170-alpha)/20 * (1  - poid_x) * (1  - poid_y);
                                histr(9,bp + 1,bq + 1)=histr(9,bp + 1,bq + 1)+ magA(p,q)*(alpha-150)/20 * (1  - poid_x) * (1  - poid_y);
                            elseif alpha>=0 && alpha<=10
                                histr(1,bp + 1,bq + 1)=histr(1,bp + 1,bq + 1)+ magA(p,q)*(alpha+10)/20 * (1  - poid_x) * (1  - poid_y);
                                histr(9,bp + 1,bq + 1)=histr(9,bp + 1,bq + 1)+ magA(p,q)*(10-alpha)/20 * (1  - poid_x) * (1  - poid_y);
                            elseif alpha>170 && alpha<=180
                                histr(9,bp + 1,bq + 1)=histr(9,bp + 1,bq + 1)+ magA(p,q)*(190-alpha)/20 * (1  - poid_x) * (1  - poid_y);
                                histr(1,bp + 1,bq + 1)=histr(1,bp + 1,bq + 1)+ magA(p,q)*(alpha-170)/20 * (1  - poid_x) * (1  - poid_y);
                            end
                            
                            
                    end
                    
                end
                 histr = histr(1:end, 2:end-1, 2:end-1);
                 histr = [histr(1:end, 1, 1) ; histr(1:end, 1, 2); histr(1:end, 2, 1); histr(1:end, 2, 2)];
                                
                block_feature = block_feature + histr' ; % Concatenation of Four histograms to form one block feature
                                
            end
        end
        % Normalize the values in the block using L1-Norm
        block_feature=block_feature/sqrt(norm(block_feature)^2+.01);
        for z=1:length(block_feature)
            if block_feature(z)>0.2
                 block_feature(z)=0.2;
            end
        end
        block_feature=block_feature/sqrt(norm(block_feature, 2)^2+.01);  

        feature=[feature block_feature]; %Features concatenation
    end
end

feature(isnan(feature))=0; %Removing Infinitiy values

% Normalization of the feature vector using L2-Norm
% feature=feature/sqrt(norm(feature, 2)^2+.001);
% for z=1:length(feature)
%     if feature(z)>0.2
%          feature(z)=0.2;
%     end
% end
% feature=feature/sqrt(norm(feature, 2)^2+.001);  
% 


function [x1, b1] = computeLowerHistBin(x, binWidth)
% Bin index
width    = single(binWidth);
invWidth = 1./width;
bin      = floor(x.*invWidth - 0.5);

% Bin center x1
x1 = width * (bin + 0.5);

% add 2 to get to 1-based indexing
b1 = int32(bin + 2);

% toc;       
