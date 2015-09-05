function [roi_array]=roi_generator(roi_factor,x_size,y_size,x_start,y_start)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%   [roi_array]=roi_generator(roi_factor,x_size,y_size,x_start,y_start)
% 
% Returns an nx4 matrix, where n is equal to the total number of rois.
% Each column corresponds to the left, right, top, and bottom coordinates,
% respectively. 
%
% INPUT ARGUMENTS:
%   roi_factor: factor by which to divide each screen dimension 
%   x_size:     length of x-dimension of screen in pixels
%   y_size:     length of y-dimension of screen in pixels
%   x_start:    start x-coordinate
%   y_start:    start y-coordinate
% OUTPUT ARGUMENTS:
%   roi_array:  an nx4 array with the left, right, top, and bottom
%               coordinates of the roi, respectively
% 
% 
% (c) 2014 D.C. LaCombe, Jr. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% determine bin sizes for each dimension
bin_size=min([x_size,y_size])/roi_factor;

% determine number of rois
x_num_roi=x_size/bin_size;
y_num_roi=y_size/bin_size;
n=x_num_roi*y_num_roi;

if isinteger(x_num_roi) || isinteger(y_num_roi)
    error('rois do not fit into screen space');
end

% initialize roi_array at zero and counter at one
roi_array=zeros(n,4);
array_counter=1;

% initialize roi coordinates at top left corner
x_count_1=x_start;
x_count_2=x_count_1+bin_size;
y_count_1=y_start;
y_count_2=y_count_1-bin_size;

% calculate rois for array space from left to right
for i=1:y_num_roi
    for j=1:x_num_roi
        roi_array(array_counter,:)=[x_count_1, x_count_2, y_count_1, y_count_2];
        x_count_1=x_count_1+bin_size;
        x_count_2=x_count_2+bin_size;
        array_counter=array_counter+1;
    end
    x_count_1=x_start;
    x_count_2=x_count_1+bin_size;
    y_count_1=y_count_1-bin_size;
    y_count_2=y_count_2-bin_size;
end
