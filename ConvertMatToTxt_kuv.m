%% Load raw EEG image data 
trainingData3DFileName=load('D:\EEGLab\Examples\data\child_mind_x_train_2s_24chan_raw.mat')
trainingData3DArray = trainingData3DFileName.X_train;
nDataPoint = size(trainingData3DArray, 3);
outputDataDirectory = 'D:\EEGLab\Examples\output_kuv';
outputImageDataDirectory = fullfile (outputDataDirectory, 'images');
mkdir (outputImageDataDirectory);
outputLabelDataDirectory = fullfile (outputDataDirectory, 'textLabels');
mkdir (outputLabelDataDirectory );

%% Load Label data
trainLabelFile = load('child_mind_all_labels_train_2s_24chan_raw.mat');
labelCellArray = trainLabelFile.Y_train;

nDataPoint = 10;

for iDataPoint= 1:nDataPoint
    % Write to 32 bit image file
    trainingData2DImageFileName = sprintf('sample%08d.tif', iDataPoint);
    trainingData2DImageFileName = fullfile (outputImageDataDirectory,  trainingData2DImageFileName);
    trainingData2DArray=trainingData3DArray(:,:,iDataPoint) ;    % 2d array from the training  .mat file 
    write32bitTiff(single(trainingData2DArray), trainingData2DImageFileName);
    
    % Write Label file
    [l1, l2, l3, l4] = labelCellArray{1,:}; l1 = cell2mat(l1);
    labelFileName = sprintf('sample%08d.txt', iDataPoint);
    labelFileName = fullfile (outputLabelDataDirectory, labelFileName);
    fLabelTextFilePtr = fopen (labelFileName, 'w');
    fprintf (fLabelTextFilePtr , '%s,%d,%f,%f\n', l1, l2, l3, l4);
    fclose(fLabelTextFilePtr);
    
    % Write to mat file
    %trainingData2DFileName = sprintf('sample%08d.mat',iDataPoint);
    %trainingData2DFileName = fullfile (outputDataDirectory,  trainingData2DFileName);
    %save(trainingData2DFileName,'trainingData2DArray');   % writing the 2d array to a file
end




