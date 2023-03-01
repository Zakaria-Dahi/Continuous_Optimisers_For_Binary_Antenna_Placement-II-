function x = rejfast(alpha, c, M, N)

 % REJFAST.M
 % Stable random number generator, based on rejection method

 
 % Errortraps:
 if (alpha <= 0 | alpha > 2)
     disp('Valid range for alpha is (0;2].')
     x = NaN * zeros(1,N);
     return
 end
 if (c <= 0)
     disp('c must be positive.')
     x = NaN * zeros(1,N);
     return
 end
 if (M <= 0)
     disp('M must be positive.') 
    x = NaN * zeros(1,N);
     
 end
 if nargin < 4
     N=1;
 end
 if (N <= 0)
     disp('N must be positive.')
     x = NaN;
     return
 end

 step=0.2;
 fx = pdf('unif',[-M:step:M], alpha, c);
 x2M = pdf('unif',0, alpha, c);
 x = zeros(1,N);
 for k = 1:N;
     x2 = x2M+1;
     x(k) = 0;
     while(x2 > fx(1+floor((x(k)+step/2+M)/step)))
         x(k) = 2*M*rand-M;
         x2 = rand*x2M;
     end
 end 
 end
