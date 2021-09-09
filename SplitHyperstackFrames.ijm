// This ijm script prompts to open a hyperstack file, then split the time frames into 
// individual tif files. 

setBatchMode(true);
hyperStackPath = File.openDialog("Select the Hyperstack file to be splitted");
run("Bio-Formats (Windowless)", "open=[" +
hyperStackPath + 
"]");
baseName = File.getNameWithoutExtension(hyperStackPath);

dir = File.getParent(hyperStackPath);
splittedDir = dir + File.separator + "FramesSplitted";

if (!File.exists(splittedDir)) {
	File.makeDirectory(splittedDir);
}

Stack.getDimensions(width, height, channels, slices, frames);
numOfTimePoints = frames; 
for (i = 1; i <= frames ; i++) {
	Stack.setPosition(1, 1, i);
	run("Reduce Dimensionality...", "channels slices keep");
	saveAs("Tiff", 
			splittedDir + File.separator +
			baseName + "frame-" + 
			String.pad(i, 3) + 
			".tif");
	run("Close");
}
run("Close All");
setBatchMode(false);
exit("Splitting Completed");
