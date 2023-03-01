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

for h=1:Dimension
             %% ------ calculate the local pollination ------------------------------
             population(w,h)=  population(w,h) +  (walk * (population(j,h) - population(k,h)));
             
             %% ------- if the individual doesn't respect the bounds ------------------
             if (population(w,h) > max)
                  population(w,h) = max;
             end
             if (population(w,h) < min)
                  population(w,h) = min;
             end
end

end

