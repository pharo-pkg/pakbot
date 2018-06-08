tests
testCanSavePackageAndItsMetadata
	| repository mcVersion message |
	repository := self pharoCounterMasterCloned.
	message := 'commit from test #testCanSavePackageAndItsMetadata'.
	mcVersion := repository 
		savePackageUnit: (CGOOngoingPackageUnit for: 'Counter-Core') withMessage: message.
	self 
		assert: mcVersion info message
		equals: message