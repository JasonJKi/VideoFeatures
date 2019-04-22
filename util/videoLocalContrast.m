function localContrast = videoLocalContrast(video,kern)    

if ndims(video) > 3
    [height, width, nChannels, nFrames] = size(video);
else
    [height, width, nFrames] = size(video);
    nChannels = 1;
end

if nargin < 2
    kern=ones(round(height/10));
end
dataType = 'single';
localContrast=zeros(height,width,nFrames,dataType);
for i =1:nFrames
    if nChannels > 1
        frame = rgb2gray(video(:,:,:,i));
    else
        frame = video(:,:,i);
    end
    img = single(frame);
    bg = single(conv2(img,kern,'same'));
    bg(isnan(bg)) = 0;
    localContrast(:,:,i) = abs((img - bg) ./ bg);
end