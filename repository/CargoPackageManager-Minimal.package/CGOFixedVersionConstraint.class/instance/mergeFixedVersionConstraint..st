merging
mergeFixedVersionConstraint: aFixedVersionConstraint
	^ (self version = aFixedVersionConstraint version)
		ifTrue: [ self ]
		ifFalse: [ self signalDependencyConflictWith: aFixedVersionConstraint ]