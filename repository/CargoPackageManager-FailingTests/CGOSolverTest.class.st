Class {
	#name : #CGOSolverTest,
	#superclass : #CGOTest,
	#category : 'CargoPackageManager-FailingTests-Solver'
}

{ #category : #helpers }
CGOSolverTest >> defaultSourcePackageVersion [
	^ CGOMonticelloHostedPackageVersion 
		repositoryUrl: 'http://smalltalkhub.com/mc/Foo/Bar/main'
		packageName: 'no-file-specified' 
		versionString: 'JohnDoe.0'
]

{ #category : #helpers }
CGOSolverTest >> noDependenciesPackage [
	
	^ CGOPackageVersion newFrom: 
		( Dictionary new
			add: #package -> #'NoDependencies';
			add: #version -> '17';
			add: #dependencies -> #();
			add: #provisions -> #();
			add: #description -> 'no dependencies';
			add: #sourcePackageVersion -> self defaultSourcePackageVersion;
			add: #platformRequirements -> #();
			add: #timestamp -> DateAndTime now;
			yourself )
]

{ #category : #helpers }
CGOSolverTest >> noDependenciesPackageBiggerVersion [
	
	^ CGOPackageVersion newFrom: 
		( Dictionary new
			add: #package -> #'NoDependencies';
			add: #version -> '18';
			add: #dependencies -> #();
			add: #provisions -> #();
			add: #description -> 'no dependencies';
			add: #sourcePackageVersion -> self defaultSourcePackageVersion;
			add: #platformRequirements -> #();
			add: #timestamp -> DateAndTime now;
			yourself )
]

{ #category : #helpers }
CGOSolverTest >> oneDependencyPackage [
	
	^ CGOPackageVersion newFrom: 
		( Dictionary new
			add: #package -> #'OneDependency';
			add: #version -> '1.0';
			add: #dependencies ->  { #'NoDependencies' -> #('=17') };
			add: #provisions -> #();
			add: #description -> 'no dependencies';
			add: #sourcePackageVersion -> self defaultSourcePackageVersion;
			add: #platformRequirements -> #();
			add: #timestamp -> DateAndTime now;
			yourself )
]

{ #category : #helpers }
CGOSolverTest >> oneDependencyPackageBiggerVersion [
	
	^ CGOPackageVersion newFrom: 
		( Dictionary new
			add: #package -> #'OneDependency';
			add: #version -> '1.0';
			add: #dependencies ->  { #'NoDependencies' -> #('=18') };
			add: #provisions -> #();
			add: #description -> 'no dependencies';
			add: #sourcePackageVersion -> self defaultSourcePackageVersion;
			add: #platformRequirements -> #();
			add: #timestamp -> DateAndTime now;
			yourself )
]

{ #category : #helpers }
CGOSolverTest >> packageWithManyDependencies [
	
	^ CGOPackageVersion newFrom: 
		( Dictionary new
			add: #package -> #'ManyDependencies';
			add: #version -> '1.0';
			add: #dependencies ->  { #'OneDependency' -> #('=1.0.0') . #'NoDependencies' -> #('=17') };
			add: #provisions -> #();
			add: #description -> 'no dependencies';
			add: #sourcePackageVersion -> self defaultSourcePackageVersion;
			add: #platformRequirements -> #();
			add: #timestamp -> DateAndTime now;
			yourself )
]

{ #category : #tests }
CGOSolverTest >> testResolutionOfConflictShouldFail [

	| solver repository |
	repository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.
	repository savePackageVersion: self noDependenciesPackage.
	repository savePackageVersion: self noDependenciesPackageBiggerVersion.
	repository savePackageVersion: self oneDependencyPackageBiggerVersion.
	repository savePackageVersion: self packageWithManyDependencies.
	
	solver := PBSolver new.
	solver repositories: { repository }.
	self should: [solver solvePackageNamed: #'ManyDependencies' version: '1.0'] raise: CGODependencyConflictError
]

{ #category : #tests }
CGOSolverTest >> testResolutionOfPackageWithManyDependenciesShouldShieldManyLoadInstructions [

	| solver resolution repository instructions |
	repository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.
	repository savePackageVersion: self noDependenciesPackage.
	repository savePackageVersion: self oneDependencyPackage.
	repository savePackageVersion: self packageWithManyDependencies.
	
	solver := PBSolver new.
	solver repositories: { repository }.
	resolution := solver solvePackageNamed: 'ManyDependencies' version: '1.0'.
	
	instructions := resolution loadInstructions groups.
	self assert: instructions size equals: 3.
	
	self assert: instructions first packageVersions size equals: 1.
	self assert: instructions first packageVersions first equals: self noDependenciesPackage.
	
	self assert: instructions second packageVersions size equals: 1.
	self assert: instructions second packageVersions first equals: self oneDependencyPackage.

	self assert: instructions third packageVersions size equals: 1.
	self assert: instructions third packageVersions first equals: self packageWithManyDependencies.
]

{ #category : #tests }
CGOSolverTest >> testResolutionOfPackageWithManyDependenciesShouldShieldNotEmptyResolution [

	| solver resolution repository |
	repository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.
	repository savePackageVersion: self noDependenciesPackage.
	repository savePackageVersion: self oneDependencyPackage.
	repository savePackageVersion: self packageWithManyDependencies.
	
	solver := PBSolver new.
	solver repositories: { repository }.
	resolution := solver solvePackageNamed: 'ManyDependencies' version: '1.0'.
	
	self deny: resolution isEmpty.
]

{ #category : #tests }
CGOSolverTest >> testResolutionOfPackageWithNoDependenciesShouldShieldLoadInstructionsWithSingleInstruction [

	| solver resolution repository instructions |
	repository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.
	repository savePackageVersion: self noDependenciesPackage.
	
	solver := PBSolver new.
	solver repositories: { repository }.
	resolution := solver solvePackageNamed: #'NoDependencies' version: '17'.
	
	instructions := resolution loadInstructions groups.
	self assert: instructions size equals: 1.
	self assert: instructions first packageVersions size equals: 1.
	self assert: instructions first packageVersions first equals: self noDependenciesPackage.
]

{ #category : #tests }
CGOSolverTest >> testResolutionOfPackageWithNoDependenciesShouldShieldNotEmptyResolution [

	| solver resolution repository |
	repository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.
	repository savePackageVersion: self noDependenciesPackage.
	
	solver := PBSolver new.
	solver repositories: { repository }.
	resolution := solver solvePackageNamed: #'NoDependencies' version: '17'.
	
	self deny: resolution isEmpty.
]

{ #category : #tests }
CGOSolverTest >> testResolutionOfPackageWithOneDependencyShouldShieldLoadInstructionsWithTwoInstructions [

	| solver resolution repository instructions |
	repository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.
	repository savePackageVersion: self noDependenciesPackage.
	repository savePackageVersion: self oneDependencyPackage.
	
	solver := PBSolver new.
	solver repositories: { repository }.
	resolution := solver solvePackageNamed: #'OneDependency' version: '1'.
	
	instructions := resolution loadInstructions groups.
	self assert: instructions size equals: 2.
	
	self assert: instructions first packageVersions size equals: 1.
	self assert: instructions first packageVersions first equals: self noDependenciesPackage.
	
	self assert: instructions second packageVersions size equals: 1.
	self assert: instructions second packageVersions first equals: self oneDependencyPackage.
]

{ #category : #tests }
CGOSolverTest >> testResolutionOfPackageWithOneDependencyShouldShieldNotEmptyResolution [

	| solver resolution repository |
	repository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.
	repository savePackageVersion: self noDependenciesPackage.
	repository savePackageVersion: self oneDependencyPackage.
	
	solver := PBSolver new.
	solver repositories: { repository }.
	resolution := solver solvePackageNamed: #'OneDependency' version: '1'.
	
	self deny: resolution isEmpty.
]

{ #category : #tests }
CGOSolverTest >> testResolutionOfUnexistentPackageVersionShouldFail [

	| solver |
	solver := PBSolver new.
	self should: [ solver solvePackageNamed: #'Unexistent' version: '1.0' ] raise: CGOPackageNotFoundError
]

{ #category : #tests }
CGOSolverTest >> testShouldGetDependencyConflictErrorWhenAskingToInstallAPackageAlreadyInstalledInADifferentVersion [
	| solver repository installedPackage |
	repository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.
	installedPackage := self noDependenciesPackage
		instVarNamed: 'version' put: '19' asSemanticVersion;
		yourself.
	repository savePackageVersion: installedPackage.
	
	solver := PBSolver new.
	solver 
		repositories: { repository };
		installedPackages: { installedPackage }.
	
	self 
		should: [ solver solvePackageNamed: #'NoDependencies' version: '17' ]
		raise: CGODependencyConflictError
]

{ #category : #tests }
CGOSolverTest >> testShouldGetEmptyLoadInstructionsWhenAskingToInstallAPackageAlreadyInstalled [
	| solver resolution repository instructions |
	repository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.
	repository savePackageVersion: self noDependenciesPackage.
	
	solver := PBSolver new.
	solver 
		repositories: { repository };
		installedPackages: { self noDependenciesPackage }.
	resolution := solver solvePackageNamed: #'NoDependencies' version: '17'.
	
	instructions := resolution loadInstructions groups.
	self assert: instructions size equals: 0.
]

{ #category : #tests }
CGOSolverTest >> testShouldNotGetAlreadyInstalledPackagesInLoadInstructionsWhenResolutionInvolvesManyPackages [
	| solver resolution repository instructions |
	repository := CGODirectoryPackageRepository newInDirectory: FileSystem memory root.
	repository savePackageVersion: self noDependenciesPackage.
	repository savePackageVersion: self oneDependencyPackage.
	repository savePackageVersion: self packageWithManyDependencies.
	
	solver := PBSolver new.
	solver 
		repositories: { repository };
		installedPackages: { self noDependenciesPackage }.
	resolution := solver solvePackageNamed: 'ManyDependencies' version: '1.0'.
	
	instructions := resolution loadInstructions groups.
	self assert: instructions size equals: 2.
	
	self assert: instructions first packageVersions size equals: 1.
	self assert: instructions first packageVersions first equals: self oneDependencyPackage.

	self assert: instructions second packageVersions size equals: 1.
	self assert: instructions second packageVersions first equals: self packageWithManyDependencies.
]
