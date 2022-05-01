function [denoised_patch] = fixed_point_iteration(patch_matrix,Omega,tau,iters,find,no_of_frames)
    Q=double(zeros(size(patch_matrix)));
    var_avg=0.00;
    for i=1:8*8
        temp = patch_matrix(i,:);
        var_avg=var_avg + var(double(temp(Omega(i,:))));  
    end
    var_avg = var_avg / 64;
    p = sum(Omega,'all')/(64*5*no_of_frames);
    myu = (8 + sqrt(5*no_of_frames))*sqrt(p*var_avg);
    
    for i=1:iters
        R = Q - tau*(Q-double(patch_matrix)).*Omega;
        [U,Sigma,V] = svd(R);
        Sigma = Sigma-tau*myu;
       
        Q_temp = U * max(Sigma,0)* V'; %Soft shrinkage

        if (norm(Q-Q_temp,'fro')<0.00001)
            break;
        end

        Q = Q_temp;
    end
    denoised_patch = Q(:,find);
end