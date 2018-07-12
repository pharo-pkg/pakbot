updating
withConflicts: aCollection 
	
	aCollection ifEmpty: [ ^ self ].
	^ CGOConflictingDependencyState withConflicts: aCollection