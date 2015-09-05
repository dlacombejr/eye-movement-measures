function [fix_map]=fixMap(x,y,length,width)

x(x==0)=1;
y(y==0)=1;

x=round(x);
y=round(y);

% empty scene to index
img=zeros(width,length);
for i=1:size(x)
    img(y(i),x(i))=1;
end
map=conv2(img, fspecial('gaussian', 200, 30),'same');
map=downsample(map,10);
map=downsample(map',10)';
fix_map=map;
end
