tests
testCanGetLatestVersionOfVirtualPackage
	| repository package |
	repository := self greaseSCMPackageMetadata.
	(repository instVarNamed: 'packageVersions') 
		add: (CGOVirtualPackageVersion fromString: 'Grease-Slime@1.0').
		
	package := repository 
		latestVersionOfPackage: 'Grease-Slime'
		suitableForEnvironment: #('pharo5.x').
	self
		assert: package name
		equals: 'Grease-Slime@1.0.0'