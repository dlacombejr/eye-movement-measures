function [area]=area_calc(x,y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [area]=area_calc(x,y)
% Calculates amount of screen area viewed
%
% INPUT ARGUMENTS:
%   x:              column vector with the x-coordinate of the i-th fixation
%   y:              column vector with the y-coordinate of the i-th fixation
% OUTPUT ARGUMENTS:
%   area:           single element giving area of viewed space in pixels^2
%
% (c) 2014 D.C. LaCombe, Jr.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % find the max and min of both x and y coordinates
% extremes=[min(x),min(y),max(x),max(y)];
% 
% % calculate the height and length of the area
% height=extremes(4)-extremes(2);
% length=extremes(3)-extremes(1);
% 
% % calculate the area
% area=height*length;

%% 
[rr, cc] = meshgrid(1:1280,1:1024);
master_area=zeros(1024,1280);
for i=1:size(x)
    C=sqrt((rr-x(i)).^2+(cc-y(i)).^2)<=20;
    master_area=master_area+C;
end
master_area=master_area>0;
area=sum(sum(master_area));



