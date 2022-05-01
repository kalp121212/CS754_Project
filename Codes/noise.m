%Equation (10) of the paper

function [noise_output] = noise(vid, sigma, kappa, s)
    noise_output = double(vid);
    np = poissrnd(kappa*noise_output) - kappa*noise_output; %Poisson Noise
    ng = sigma*randn(size(vid)); %Gaussian Noise
    noise_output = uint8(noise_output + np + ng);
    
    %Adding Impulsive noise with prob s
    noise_output = imnoise(noise_output,'salt & pepper',s);  
end