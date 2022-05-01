function image_filtered = adaptive_median_filter(image,s_max)
        [n1,n2] = size(image);
        image_filtered = image;
        for i = 1:n1
            for j = 1:n2
                s = min([s_max,i-1,j-1,n1-i,n2-j]);
                %first level
                for k = 0:s
                    S = image(i-k:i+k,j-k:j+k);
                    xmed = median(S,'all');
                    xmin = min(S,[],'all');
                    xmax = max(S,[],'all');
                    
                    Tminus = xmed - xmin;
                    Tplus = xmax - xmed;
                    if (Tminus > 0 && Tplus > 0)
                        break;
                    end
                end
                %second level
                Uminus = image(i,j)-xmin;
                Uplus = xmax-image(i,j);
                if (Uminus <= 0 || Uplus <= 0)
                    image_filtered(i,j)=xmed;
                end
            end
        end
end