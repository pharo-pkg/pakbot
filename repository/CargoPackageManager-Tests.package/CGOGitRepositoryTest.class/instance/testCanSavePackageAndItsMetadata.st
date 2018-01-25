tests
testCanSavePackageAndItsMetadata
	| repository commit message |
	repository := self pharoCounterMaster.
	message := 'commit from test #testCanSavePackageAndItsMetadata'.
	commit := repository 
		savePackageUnit: (CGOOngoingPackageUnit2 for: 'Counter-Core') withMessage: message.
	self 
		assert: commit comment
		equals: message