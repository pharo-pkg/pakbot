updating
savePackage
	self workingCopy ifNotNil: 
		[ :workingCopy |
		workingCopy needsSaving ifTrue: 
			[ self sourcePackage 
				ifNil: [ self error: 'no repository set for ', self packageName ].
			self sourcePackage saveNewVersion: self version ] ].