tests
testResolutionOfPackageWithNoDependenciesShouldShieldLoadInstructionsWithSingleInstruction

	| solver resolution repository instructions |
	repository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.
	repository savePackageVersion: self noDependenciesPackage.
	
	solver := CGOSolver new.
	solver repositories: { repository }.
	resolution := solver solvePackageNamed: #'NoDependencies' version: '17'.
	
	instructions := resolution loadInstructions groups.
	self assert: instructions size equals: 1.
	self assert: instructions first packageVersions size equals: 1.
	self assert: instructions first packageVersions first equals: self noDependenciesPackage.