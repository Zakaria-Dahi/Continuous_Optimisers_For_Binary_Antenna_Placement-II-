function [ population ] = GeneratePopulation(indiv,Dimension,minim,maxim)
%% Generate the initial population -------------
randn('state',sum(100*clock));
population = rand(indiv,Dimension);
end

