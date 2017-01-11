testing
isSourcePackageDirty
	^ self workingCopy 
		ifNil: [ False ]
		ifNotNil: [ :workingCopy | workingCopy needsSaving ]