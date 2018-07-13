tests
testResolutionOfProjectIsResolutionRoot

	| testRegistry resolution projectOne |
	testRegistry := CGOPackageRegistry new.	
	
	projectOne := testRegistry newProjectNamed: 'ProjectOne'.
	resolution := projectOne resolve.
	
	self assert: resolution equals: (resolution resolutionFor: projectOne)