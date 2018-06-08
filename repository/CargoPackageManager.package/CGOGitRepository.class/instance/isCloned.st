private
isCloned
	self isIceRepositoryValid
		ifTrue: [ ^ true ].
	(self isRepositoryAlreadyClonedInDefaultLocation or: [ self isRepositoryAlreadyCloned ])
		ifTrue: [ iceRepository := iceRepository addLocalRepository.
			^ true ].
	^ false