function [population ] = GlobalPollination(population,Dimension,min,max,gbest,lambda,type_levy)
%------------------- the Global Scale and the Levy Flight-----------------
randn('state',sum(100*clock));

%% --------------------- Simplified  -----------------------------------------
if isequal(type_levy,'cs')

% --- calculate the lévy flight ---------------------------------------
actual = population;
VARIANCE =((gamma(1+lambda)*sin(pi*lambda/2))/((lambda*gamma((1+lambda)/2))*(2^((lambda-1)/2))))^(1/lambda);
STD = sqrt (VARIANCE); 
fact1= STD * randn(1,Dimension);
fact2= randn (1,Dimension);
step =fact1./(abs(fact2).^(1/lambda));
L=0.03*step.*(actual-gbest);
end



%% --------------------- MCculloch -----------------------------------------

if isequal(type_levy ,'MCculloch') 

%---- Mc Cullosh parameter --------------------------------
alpha = 1.5;
beta = 1;
c = 1;
delta = 0;

%---- calculate MC culosh  lévy flight ---------------------------------------
L = MCculloch_levy(alpha, beta, c, delta, 1, Dimension);

end



%% --------------------- Mantegna -----------------------------------------
if isequal(type_levy ,'mantegna') 
%---- Mantegna parameter --------------------------------
alpha = 1.5;
c = 1;

%---- calculate mantegna  lévy distribution ---------------------------------------
L = mantegna(alpha,c,1, Dimension);

end


%% --------------------- Rejection -----------------------------------------
if isequal(type_levy ,'rejection') 
%---- Rejection parameter --------------------------------
alpha = 0.2;
c = 1;


%--- calculate Rejection lévy distribution  ---------------------------------------
L = rejfast(alpha,c,1, Dimension);

end

%% --------------------- FPA  -----------------------------------------
if isequal(type_levy ,'fpa')  
%---- calculate the lévy flight ---------------------------------------
s0 = 0.01;
L = [];
actual = population;
VARIANCE =((gamma(1+lambda)*sin(pi*lambda/2))/((lambda*gamma((1+lambda)/2))*(2^((lambda-1)/2))))^(1/lambda);
STD = sqrt (VARIANCE); 
fact1= STD * randn(1,Dimension);
fact2= randn (1,Dimension);
step =fact1./(abs(fact2).^(1/lambda));
step = abs(step);

 
 while (abs(step) < abs(s0)) 
  VARIANCE =((gamma(1+lambda)*sin(pi*lambda/2))/((lambda*gamma((1+lambda)/2))*(2^((lambda-1)/2))))^(1/lambda);
  STD = sqrt (VARIANCE); 
  fact1= STD * randn(1,Dimension);%% 0.1% doubt because steel confirm the normal gaussian distribution in matlab
  fact2= randn (1,Dimension); %% 0.1% doubt because steel confirm the normal gaussian distribution in matlab
  step =fact1./(abs(fact2).^(1/lambda)); %% no poblem here to it's very clear
  end

%----- Genration of the real levy flight ---------------------------
 for i=1:Dimension
   FL = ((lambda  * gamma(lambda) * sind ((pi * lambda)/2))/pi) * (1/step(i)^(1+lambda)); %%  no problem here the secrete is in the step size see up 
   FL = 0.001 * FL .*(actual -gbest);
   L = [L FL];
 end

end


%% ---------------Compute the global pollination using one of the previous ditribution ---------------------------------------------------
% ------ calculate the global pollination ------------------------------
population = population + (L .* (population- gbest)) ;
%% ---------------------------------------------------------------------------
end

