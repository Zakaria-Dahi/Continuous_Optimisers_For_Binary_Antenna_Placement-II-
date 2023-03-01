function [population] = AM_Function(populationAM,indiv,Dimension,germ)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
population = ones(indiv,Dimension);
for  w=1:indiv
for j=1:Dimension
         population(w,j) =  sind(2 * pi *  (germ(j) - populationAM(w,1)) * populationAM(w,2) * cosd(2 * pi * (germ(j) - populationAM(w,1)) *  populationAM(w,3))) + populationAM(w,4);  
           if population(w,j) >= 0
               population(w,j) =  1;
           else
               population(w,j) = 0;
           end
end
end
        
end

