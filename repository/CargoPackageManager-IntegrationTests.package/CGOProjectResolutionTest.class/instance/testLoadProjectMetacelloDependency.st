tests
testLoadProjectMetacelloDependency

	| ongoingProject testRegistry |
	<expectedFailure>
	
	testRegistry := CGOPackageRegistry new.
	
	ongoingProject := CGOOngoingProject example.
	testRegistry register: ongoingProject.
	
	ongoingProject addDependency:
		(CGOMetacelloConfigurationProjectDependency 
			configuration: 'CargoTestExample'
			repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
			version: '1.0').

	Cargo new
		registry: testRegistry;
		package: ongoingProject name version: ongoingProject version asString;
		install.
		
	self assert: (Smalltalk globals hasClassNamed: 'ConfigurationOfCargoTestExample').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPackageA').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPackageB').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPackageC').
	self assert: (Smalltalk globals hasClassNamed: 'ClassInPackageD').
	
	self assert: (Smalltalk globals at: 'ClassInPackageA' asSymbol) version equals: 1.
	self assert: (Smalltalk globals at: 'ClassInPackageB' asSymbol) version equals: 1.
	self assert: (Smalltalk globals at: 'ClassInPackageC' asSymbol) version equals: 1.
	self assert: (Smalltalk globals at: 'ClassInPackageD' asSymbol) version equals: 1.