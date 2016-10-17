tests
testResolutionOfPackageWithManyDependenciesShouldShieldManyLoadInstructions

	| solver resolution repository instructions |
	repository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.
	repository savePackageVersion: self noDependenciesPackage.
	repository savePackageVersion: self oneDependencyPackage.
	repository savePackageVersion: self packageWithManyDependencies.
	
	solver := CGOSolver new.
	solver addRepository: repository.
	resolution := solver solvePackageNamed: 'ManyDependencies' version: '1.0'.
	
	instructions := resolution loadInstructions groups.
	self assert: instructions size equals: 3.
	
	self assert: instructions first packageVersions size equals: 1.
	self assert: instructions first packageVersions first equals: self noDependenciesPackage.
	
	self assert: instructions second packageVersions size equals: 1.
	self assert: instructions second packageVersions first equals: self oneDependencyPackage.

	self assert: instructions third packageVersions size equals: 1.
	self assert: instructions third packageVersions first equals: self packageWithManyDependencies.