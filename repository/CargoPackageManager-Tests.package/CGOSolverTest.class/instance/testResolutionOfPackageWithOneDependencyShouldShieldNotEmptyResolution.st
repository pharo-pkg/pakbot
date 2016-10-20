tests
testResolutionOfPackageWithOneDependencyShouldShieldNotEmptyResolution

	| solver resolution repository |
	repository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.
	repository savePackageVersion: self noDependenciesPackage.
	repository savePackageVersion: self oneDependencyPackage.
	
	solver := CGOSolver new.
	solver addRepository: repository.
	resolution := solver solvePackageNamed: #'OneDependency' version: '1'.
	
	self deny: resolution isEmpty.