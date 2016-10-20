tests
testResolutionOfPackageWithNoDependenciesShouldShieldNotEmptyResolution

	| solver resolution repository |
	repository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.
	repository savePackageVersion: self noDependenciesPackage.
	
	solver := CGOSolver new.
	solver addRepository: repository.
	resolution := solver solvePackageNamed: #'NoDependencies' version: '17'.
	
	self deny: resolution isEmpty.