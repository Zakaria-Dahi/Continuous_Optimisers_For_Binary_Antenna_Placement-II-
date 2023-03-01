function [ population ] = GeneratePopulation(indiv)
%% Generate the initial population -------------
randn('state',sum(100*clock));
population = rand(indiv,4);
%% ---------------------------------------------
end

