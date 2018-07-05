tests
testShouldGetEmptyLoadInstructionsWhenAskingToInstallAPackageAlreadyInstalled
	| solver resolution repository instructions |
	repository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.
	repository savePackageVersion: self noDependenciesPackage.
	
	solver := CGOSolver new.
	solver 
		repositories: { repository };
		installedPackages: { self noDependenciesPackage }.
	resolution := solver solvePackageNamed: #'NoDependencies' version: '17'.
	
	instructions := resolution loadInstructions groups.
	self assert: instructions size equals: 0.