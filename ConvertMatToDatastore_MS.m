%% Load raw EEG image data 
data = load('child_mind_x_test_2s_24chan_raw.mat');
test_data = data.X_test;
n_samples = size(test_data, 3); % number of 2s samples of EEG data from 24 electrodes
outputDataDirectory = 'appasamy-sc\output';
% outputImageDataDirectory = fullfile (outputDataDirectory, 'images');
% mkdir (outputImageDataDirectory);
% outputLabelDataDirectory = fullfile (outputDataDirectory, 'textLabels');
% mkdir (outputLabelDataDirectory );
% 
%% Load Label data
label = load('child_mind_all_labels_test_2s_24chan_raw.mat');
test_label = label.Y_test;


%% Pad test data with zeros to bring to 224x224 size

zero_pad =  single(zeros(224,224,size(test_data,3)));
padded_data_ch1 = zero_pad;
padded_data_ch2 = zero_pad;
padded_data_ch3 = zero_pad;
padded_data_ch1(101:124,:,:) = zero_pad(101:124,:,:) + test_data(:,1:224,:); % take the first 224 samples
padded_data_ch2(101:124,:,:) = zero_pad(101:124,:,:) + test_data(:,17:240,:); % take the middle 224 samples
padded_data_ch3(101:124,:,:) = zero_pad(101:124,:,:) + test_data(:,33:256,:); % take the last 224 samples


%% convert to 3D image (equivalent to RGB channels)
image_data =[];
image_data(:,:,1,:) = padded_data_ch1;
image_data(:,:,2,:) = padded_data_ch2;
image_data(:,:,3,:) = padded_data_ch3;


%% Convert Data to 32 bit images for subject 1 (samples 1:81)

nSamples = 81;

for sample= 1:nSamples
    % Write to 32 bit image file
%     trainingData2DImageFileName = sprintf('sample%08d.tif', sample);
%     trainingData2DImageFileName = fullfile (outputImageDataDirectory,  trainingData2DImageFileName);
%    trainingData2DArray=trainingData3DArray(:,:,iDataPoint) ;    % 2d array from the training  .mat file 
%  


   write32bitTiff(padded_data_ch1(:,:,sample), 'subject1_ch1.tif');
   write32bitTiff(padded_data_ch2(:,:,sample), 'subject1_ch2.tif');
   write32bitTiff(padded_data_ch3(:,:,sample), 'subject1_ch3.tif');


%     % Write Label file
%     [l1, l2, l3, l4] = labelCellArray{1,:}; l1 = cell2mat(l1);
%     labelFileName = sprintf('sample%08d.txt', iDataPoint);
%     labelFileName = fullfile (outputLabelDataDirectory, labelFileName);
%     fLabelTextFilePtr = fopen (labelFileName, 'w');
%     fprintf (fLabelTextFilePtr , '%s,%d,%f,%f\n', l1, l2, l3, l4);
%     fclose(fLabelTextFilePtr);
%     
%     % Write to mat file
%     %trainingData2DFileName = sprintf('sample%08d.mat',iDataPoint);
%     %trainingData2DFileName = fullfile (outputDataDirectory,  trainingData2DFileName);
%     %save(trainingData2DFileName,'trainingData2DArray');   % writing the 2d array to a file
 end

