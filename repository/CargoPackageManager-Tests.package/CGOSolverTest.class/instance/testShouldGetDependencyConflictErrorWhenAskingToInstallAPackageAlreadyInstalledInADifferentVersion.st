tests
testShouldGetDependencyConflictErrorWhenAskingToInstallAPackageAlreadyInstalledInADifferentVersion
	| solver repository installedPackage |
	repository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.
	installedPackage := self noDependenciesPackage
		instVarNamed: 'version' put: '19' asSemanticVersion;
		yourself.
	repository savePackageVersion: installedPackage.
	
	solver := CGOSolver new.
	solver 
		repositories: { repository };
		installedPackages: { installedPackage }.
	
	self 
		should: [ solver solvePackageNamed: #'NoDependencies' version: '17' ]
		raise: CGODependencyConflictError