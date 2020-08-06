clc;
clear all;

I = imread('leaf1.png'); %select picture
%I = imread('leaf2.png');


smooth = imgaussfilt(I,3.6);

grayImg=rgb2gray(smooth);

threshImg=grayImg > 205;
%figure, imshow(threshImg);

ConnComp = bwconncomp(threshImg);

pixelCount = cellfun(@numel,ConnComp.PixelIdxList); %To apply function to each cell in cell array

objectCounter= ConnComp.NumObjects;

count=1;
currentLeaves=0;

while(count<objectCounter+1)
   if(pixelCount(count)>=50&&pixelCount(count)<=1500)
   
       [x y]=ind2sub(size(threshImg),ConnComp.PixelIdxList{count});    

 maxValueX = x(1);
 for ix = 1:length(x)
    if x(ix) > maxValueX
        maxValueX = x(ix);
    end
 end
 
 maxValueY = y(1);
 for iy = 1:length(y)
    if y(iy) > maxValueY
        maxValueY = y(iy);
    end
 end
 
 minValueX = x(1);
 for iix = 1:length(x)
    if x(iix) < minValueX
        minValueX = x(iix);
    end
 end
 
 minValueY = y(1);
 for iiy = 1:length(y)
    if y(iiy) < minValueY
        minValueY = y(iiy);
    end
 end

    scanImage1 = imcrop(I,[minValueY-30 minValueX-30 maxValueY-(minValueY-30) maxValueX-(minValueX-30)]);
    
    currentLeaves=currentLeaves+1;
    
    color = {'magenta'};
    marked = insertMarker(I,[y x],'color',color);  % Marks founded leaves on image to show which ones are detected.
    figure;imshow(marked);
   
   end
   count=count+1;
end

foundedLeaves = 'Total number of leaves is:';
fprintf('%s', foundedLeaves,'',num2str(currentLeaves),' ') ;