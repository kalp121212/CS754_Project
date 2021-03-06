function [patch_matrix,Omega,i] = patchmatcher(patch, j, k, frame_num, missing)
    [~,n1,n2,no_of_frames] = size(patch);
    
    patch = double(patch);
    
    MAD = sum(abs(patch- patch(:,j, k, frame_num)));%Mean of Absolute distances
    MAD = reshape(MAD, [n1*n2 no_of_frames]);
    
    [~, match_mat] = mink(MAD, 5); %Find the 5 most matching patches
    
    [j_mat, k_mat] = ind2sub([n1 n2], match_mat); %Finding the indices of the nearest patches
    
    matching_patches = [reshape(j_mat, [1 5*no_of_frames]); reshape(k_mat, [1 5*no_of_frames]);]; %Reshaping the indices for our use case
    
    patch_matrix = uint8(zeros(8*8,5*no_of_frames));
    Omega = false(8*8,5*no_of_frames);
    
    for i= 1:5*no_of_frames %Creating the patch matrix and the omega where is all the missing values
        patch_matrix(:,i) = patch(:,matching_patches(1,i),matching_patches(2,i),ceil(i/5));
        Omega(:,i) = missing(:,matching_patches(1,i),matching_patches(2,i),ceil(i/5));
    end    
    
    for i=1+5*(frame_num-1):5*frame_num %Finding our current patch
        if(matching_patches(:,i)==[j;k;])
            break;
        end
    end
end