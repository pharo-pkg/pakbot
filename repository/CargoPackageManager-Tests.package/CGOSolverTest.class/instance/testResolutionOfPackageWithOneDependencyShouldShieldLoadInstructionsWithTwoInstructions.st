tests
testResolutionOfPackageWithOneDependencyShouldShieldLoadInstructionsWithTwoInstructions

	| solver resolution repository instructions |
	repository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.
	repository savePackageVersion: self noDependenciesPackage.
	repository savePackageVersion: self oneDependencyPackage.
	
	solver := CGOSolver new.
	solver addRepository: repository.
	resolution := solver solvePackageNamed: #'OneDependency' version: '1'.
	
	instructions := resolution loadInstructions groups.
	self assert: instructions size equals: 2.
	
	self assert: instructions first packageVersions size equals: 1.
	self assert: instructions first packageVersions first equals: self noDependenciesPackage.
	
	self assert: instructions second packageVersions size equals: 1.
	self assert: instructions second packageVersions first equals: self oneDependencyPackage.