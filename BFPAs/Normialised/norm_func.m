function [population] = norm_func(Dimension,population_norm,population)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

BETA = max(population_norm);
ALPHA = min(population_norm);
temp = ((population_norm) + ALPHA) / (BETA + abs(ALPHA));

for i=1:Dimension
    if temp(i) >= 0.5
       population(i) =  1;
    else
       population(i) =  0;
    end
end
end


