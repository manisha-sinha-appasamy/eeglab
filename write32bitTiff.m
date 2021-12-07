function write32bitTiff(imgdata, filename)
t = Tiff(filename, 'a');
tagstruct.ImageLength = size(imgdata,1);
tagstruct.ImageWidth = size(imgdata,2);
tagstruct.Photometric = 1;
tagstruct.BitsPerSample = 32;
tagstruct.SamplesPerPixel = 1;
tagstruct.Software = 'appasamy-sc';
tagstruct.SampleFormat = 3;
tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
t.setTag(tagstruct);

t.write(single(imgdata(:,:,1)));
t.close();  
