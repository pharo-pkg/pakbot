updating
savePackage
	self workingCopy needsSaving ifTrue: 
		[ | repository | 
		self repositories 
			ifEmpty: [ self error: 'no repository set for ', self packageName ].
		repository := MCRepository fromUrl: self repositories first.
		self workingCopy
			newVersionWithName: (self workingCopy uniqueVersionNameIn: repository)
			message: 'Publication of version ' , self version
			in: repository ].