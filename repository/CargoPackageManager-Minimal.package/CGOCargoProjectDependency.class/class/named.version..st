instance-creation
named: aName version: aVersion 
	
	^ self new
		name: aName;
		constraints: {(CGODependencyConstraint fromString: aVersion)};
		yourself