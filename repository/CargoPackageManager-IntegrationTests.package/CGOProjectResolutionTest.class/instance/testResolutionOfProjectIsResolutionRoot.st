tests
testResolutionOfProjectIsResolutionRoot

	| testRegistry resolution projectOne |
	testRegistry := CGOPackageRegistry new.	
	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	resolution := projectOne resolve.
	
	self assert: resolution root equals: (resolution resolutionFor: projectOne)