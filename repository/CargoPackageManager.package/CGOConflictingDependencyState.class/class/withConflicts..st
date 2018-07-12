instance-creation
withConflicts: aCollection
	
	^ self new
		conflictingDependencies: aCollection;
		yourself