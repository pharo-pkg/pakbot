updating
savePackage
	self workingCopy ifNotNil: 
		[ :workingCopy |
		workingCopy needsSaving ifTrue: 
			[ self sourceRepository 
				ifNil: [ self error: 'no repository set for ', self packageName ].
			self sourceRepository saveNewVersion: self version ] ].