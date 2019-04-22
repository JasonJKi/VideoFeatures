classdef VideoIterator < handle
   
    properties
        feature
        
        name
        param
        paramLabel
        methodName
        numFeatures
        numFrames
        
        video
        
        indexer
    end
    
    properties (Access = private, Hidden = true)
        frameIndex = 1
        featureFieldNames 
    end
        
    methods
        function feature = get(this)
            feature = this.feature;
        end

        function this = VideoIterator(feature, numFrames)
            this.feature = feature;
            this.name = feature.NAME;
            this.param = feature.param;
            this.numFeatures = feature.numOutputs;
            this.paramLabel = feature.paramLabel;
            this.numFrames = numFrames;
            this.methodName = feature.methodName;
            reset(this)
        end
        
        function addFrame(this, frame)
             if this.frameIndex == 1
                this.video = this.allocateOutputMemory(frame, this.numFrames);
                this.indexer = this.createIndexer(this.video);
             end    
            
            iFrame = this.frameIndex;
            
            this.video(this.indexer{:}, iFrame) = frame;
            
            this.frameIndex = iFrame + 1;
        end
        
        function reset(this)
            this.frameIndex = 1;
        end
        
    end
    
    methods (Static = true)
        
        function output = allocateOutputMemory(input, numFrames)
                [height, width, numFeatures] = size(input);
                output = zeros(height, width, numFeatures, numFrames, 'single');
        end
    
       function colons = createIndexer(video)
           numDims = numel(size(video));
           colons = repmat({':'},1,numDims-1); 
       end
        
    end
end