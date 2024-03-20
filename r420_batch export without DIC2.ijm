// merge without DIC
// DIC should be the last channel

directory = getDirectory("Choose directory! "); 

filelist = getFileList(directory) 
for (i = 0; i < lengthOf(filelist); i++) {
	//open(directory +filelist [i] );
	run("Bio-Formats Windowless Importer", "open=[" + directory + filelist[i] + "] color_mode=Composite");
	filename =File.nameWithoutExtension;
	getDimensions(width, height, channels, slices, frames);
	
// Determine active channels based on channel count
    if (channels == 3) {
        activeChannels = "110";
    } else if (channels == 4) {
        activeChannels = "1110";
    } else if (channels == 5) {
        activeChannels = "11110";
    } else {
        print("Unsupported number of channels: " + channels);
        continue; // Skip processing this file
    }
	
// Check if there is more than 1 slice	
	if (slices > 1) {
	run("Z Project...", "projection=[Max Intensity]");
	Property.set("CompositeProjection", "Sum");
	Stack.setDisplayMode("composite");
	Stack.setActiveChannels(activeChannels);
	run("Stack to RGB");
	saveAs("Tiff", directory + filename);
	run("Close All");
	}
	else {
	
	Property.set("CompositeProjection", "Sum");
	Stack.setDisplayMode("composite");
	Stack.setActiveChannels(activeChannels);
	run("Stack to RGB");
	saveAs("Tiff", directory + filename);
	run("Close All");
	}
}	

