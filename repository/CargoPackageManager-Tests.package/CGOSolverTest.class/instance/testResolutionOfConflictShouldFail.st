tests
testResolutionOfConflictShouldFail

	| solver repository |
	repository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.
	repository savePackageVersion: self noDependenciesPackage.
	repository savePackageVersion: self noDependenciesPackageBigger.
	repository savePackageVersion: self oneDependencyPackageBigger.
	repository savePackageVersion: self packageWithManyDependencies.
	
	solver := CGOSolver new.
	solver addRepository: repository.
	self should: [solver solvePackageNamed: #'ManyDependencies' version: '1.0'] raise: CGODependencyConflictError