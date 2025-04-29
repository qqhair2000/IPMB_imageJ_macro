directory = getDirectory("");

// print(title);
list = getFileList(directory);
for (i = 0; i < list.length; i++) {
filePath = directory + list[i];
print("正在處理: " + filePath);
// open(filePath);
// open in bio-format
run("Bio-Formats Windowless Importer", "open=[filePath]");
title = getTitle();

// cellpose segmentation 
run("Cellpose ...", "env_path=C:\\Users\\user\\miniforge3\\envs\\cellpose env_type=conda model=cyto3 model_path=path\\to\\own_cellpose_model diameter=100 ch1=3 ch2=1 additional_flags=--use_gpu");

// label image to roi manager
run("Label image to ROIs", "rm=[RoiManager[size=120, visible=true]]");

// measure average intensity
selectImage(title);
run("Set Measurements...", "area mean display redirect=None decimal=2");
roiManager("Measure");
roiManager("multi-measure append");
run("Summarize");

// create flatten jpg
selectImage(title);
run("Arrange Channels...", "new=13");
Stack.setChannel(1); //run("Brightness/Contrast...");
run("Enhance Contrast", "saturated=0.35");
Stack.setChannel(2);
run("Enhance Contrast", "saturated=0.35");
run("Make Composite");
roiManager("Show All");
run("Flatten", "stack");
saveAs("jpeg","C:\\Users\\user\\Desktop\\20250409-pTM83 DC 17hr for lipid oxidation\\New folder\\" + title + ".jpg"); 

//output excel
selectWindow("Results");
saveAs("Results", "C:\\Users\\user\\Desktop\\20250409-pTM83 DC 17hr for lipid oxidation\\New folder\\" + title + ".csv");
run("Clear Results");
roiManager("Delete");
run("Close All");
}