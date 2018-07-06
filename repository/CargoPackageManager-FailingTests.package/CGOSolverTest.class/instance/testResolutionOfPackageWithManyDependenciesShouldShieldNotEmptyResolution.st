tests
testResolutionOfPackageWithManyDependenciesShouldShieldNotEmptyResolution

	| solver resolution repository |
	repository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.
	repository savePackageVersion: self noDependenciesPackage.
	repository savePackageVersion: self oneDependencyPackage.
	repository savePackageVersion: self packageWithManyDependencies.
	
	solver := CGOSolver new.
	solver repositories: { repository }.
	resolution := solver solvePackageNamed: 'ManyDependencies' version: '1.0'.
	
	self deny: resolution isEmpty.