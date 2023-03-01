function [final_area,transmitters,coverage,overcoverage,ratio,fitness] = VISUAL_ALL(population,Dimension,radius_1,radius_2,radius_3,GRID_SIZE_X,GRID_SIZE_Y,DIRECTIVE_XY,SQUARE_XY,mask_1,mask_2,mask_3)
alpha = 2; %% d'apres le site http://oplink.lcc.uma.es/problems/rnd.html
k = 0.5;
coverage = 0;
overcoverage =0;
fitness =0;
transmitters = 0;
ratio = 0;
GRID_SIZE_Y_ORIG =GRID_SIZE_Y;
GRID_SIZE_X_ORIG =GRID_SIZE_X;
final_area = zeros(GRID_SIZE_Y,GRID_SIZE_X);
activate_y = 0;
activate_x = 0;
decal_y = 0;
decal_x = 0;
ALL_Y_X = [];
for i=1:Dimension
if  population(i) ~= 0
transmitters =transmitters + 1;
activate_y = 0;
activate_x = 0;
decal_y = 0;
decal_x = 0;
GRID_SIZE_Y  = GRID_SIZE_Y_ORIG;
GRID_SIZE_X  = GRID_SIZE_X_ORIG;
%% IF THE SQUARED ANETNNA IS USED 
if population(i) == 1
Y = SQUARE_XY(i,1);
X = SQUARE_XY(i,2);
mask = mask_1;
radius = radius_1;
ALL_Y_X = [ALL_Y_X;Y X];
end
%% -- ------- IF THE CIRCLE ANETNNA IS USED 
if population(i) == 2
Y = DIRECTIVE_XY(i,1);
X = DIRECTIVE_XY(i,2);
mask = mask_2;
radius = radius_2;
ALL_Y_X = [ALL_Y_X;Y X];
end
%% ----------- IF THE DIRECTIVE ANETNNA IS USED 
if population(i) == 3
Y = DIRECTIVE_XY(i,1);
X = DIRECTIVE_XY(i,2);
mask = mask_3;
radius = radius_3;
ALL_Y_X = [ALL_Y_X;Y X];
end
%% ------ Processing the new image -------------------------------
%% if the Y is smaller than the radius
if ((Y - radius) <= 0)
   decal_y = abs(Y - radius) + 1;
   GRID_SIZE_Y = GRID_SIZE_Y + decal_y ;
   GRID_SIZE_X = GRID_SIZE_X;
   Y = radius + 1;
   activate_y = 1;
end
%% if the Y + radius is greater than the GRID_SIZE_Y + radius
if ((Y + radius) > GRID_SIZE_Y)
    decal_y = ((Y+radius)- GRID_SIZE_Y);
    GRID_SIZE_Y = GRID_SIZE_Y + decal_y ;
    GRID_SIZE_X = GRID_SIZE_X;
    Y = GRID_SIZE_Y - radius;
    activate_y = 2;
end
%% if the X is smaller than the radius
if ((X - radius) <= 0)
    decal_x = abs(X - radius) + 1;
    GRID_SIZE_Y = GRID_SIZE_Y ;
    GRID_SIZE_X = GRID_SIZE_X + decal_x;
    X = radius + 1;
    activate_x = 3;
end
%% if the X + radius is greater than the GRID_SIZE_X + radius
if ((X + radius) > GRID_SIZE_X)
    decal_x = ((X+radius)- GRID_SIZE_X);
    GRID_SIZE_Y = GRID_SIZE_Y ;
    GRID_SIZE_X = GRID_SIZE_X + decal_x;
    X = GRID_SIZE_X - radius;
    activate_x = 4;
end
%% ----- stamp  the image processed with the corresponding mask -----------
area = zeros(GRID_SIZE_Y,GRID_SIZE_X);
area((Y - radius):(Y + radius),(X - radius):(X + radius)) = area((Y - radius):(Y + radius),(X - radius):(X + radius)) | mask(:,:);
%% extract the right image form the proceessed image 
if activate_y == 1 & activate_x == 3
    area = area((decal_y+1):GRID_SIZE_Y,(decal_x+1):GRID_SIZE_X);
end
if activate_y == 2 & activate_x == 3
   area = area(1:(GRID_SIZE_Y - decal_y),(decal_x+1):GRID_SIZE_X);
end
if activate_y == 1 & activate_x == 4
    area = area((decal_y+1):GRID_SIZE_Y,1:(GRID_SIZE_X - decal_x));
end
if activate_y == 2 & activate_x == 4
    area = area(1:(GRID_SIZE_Y - decal_y),1:(GRID_SIZE_X - decal_x));
end

if activate_y == 1 & activate_x == 0
    area = area((decal_y+1):GRID_SIZE_Y,1:GRID_SIZE_X);
end
if activate_y == 2 & activate_x == 0
   area = area(1:(GRID_SIZE_Y - decal_y),1:GRID_SIZE_X);
end
if activate_y == 0 & activate_x == 3
   area = area(1:GRID_SIZE_Y,(decal_x+1):GRID_SIZE_X);
end
if activate_y == 0 & activate_x == 4
   area = area(1:GRID_SIZE_Y,1:(GRID_SIZE_X - decal_x));
end
%% SUM of the processed areas -------------------------
final_area = final_area + area;
area =[];
end
end

%% To calculate coverage and over coverage ------------------------
coverage = find(final_area == 1);
coverage = length(coverage);
overcoverage = find(final_area > 0 & final_area ~= 1);
overcoverage = length(overcoverage);
%% ----- To identify the BS location ------------------------------
siz = size(ALL_Y_X);
for i=1:siz(1)
       X = ALL_Y_X(i,2);
       Y = ALL_Y_X(i,1);
       final_area(Y,X) =  10000;
end
%% -------------- Attribution of the color -------------------------------
final_area(final_area ~= 0 & final_area ~= 1 & final_area ~= 10000) = 150 - (final_area(final_area ~= 0 & final_area ~= 1 & final_area ~= 10000)*20);
final_area(final_area == 0) = 255;
final_area(final_area == 1) = 150;
final_area(final_area == 10000) = 0;
%% comuting the fitness ----------------------------------
fitness =(((coverage+overcoverage) / (GRID_SIZE_X * GRID_SIZE_Y))* 100)^alpha;
fitness = fitness /  transmitters;
%% comuting the percentage of coverage ----------------------------------
ratio = ((coverage+overcoverage) / (GRID_SIZE_X * GRID_SIZE_Y))* 100;
if ratio < 0
    ratio = 0;
end
end

