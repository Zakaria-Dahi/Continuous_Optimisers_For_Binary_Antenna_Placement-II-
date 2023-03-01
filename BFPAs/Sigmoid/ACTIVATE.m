function [ BINARY_VECT ] = ACTIVATE( population,RANDOM_POPULATION,Dimension)
BINARY_VECT = [];
  for i=1:Dimension
     shot = 1/(1+exp(-population(i)));
     if RANDOM_POPULATION(i) < shot
         BINARY_VECT = [BINARY_VECT,1];
     else
         BINARY_VECT = [BINARY_VECT,0];
     end
  end

end

