updating
savePackage
	self workingCopy ifNotNil: 
		[ :workingCopy |
		workingCopy needsSaving ifTrue: 
			[ self sourcePackageVersion 
				ifNil: [ self error: 'no repository set for ', self packageName ].
			self sourcePackageVersion saveNewVersion: self version ] ].