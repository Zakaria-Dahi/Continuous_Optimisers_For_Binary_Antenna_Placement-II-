function [ population ] = LocalPollination(population,indiv,Dimension,min,max,w )
randn('state',sum(100*clock));

%%  Walk included in the local pollination  
 walk = rand* (1); 

%% generate randomly  the position I J included in the local pollination 
 j = 1 + randi (indiv - 1);
 k =  1 + randi (indiv - 1);
 
 while (j == w)
      j = 1 + randi (indiv - 1);
 end
 while (k == w)
      k =  1 + randi (indiv - 1);
 end

population(w,:)=  population(w,:) +  (walk * (population(j,:) - population(k,:)));

end

