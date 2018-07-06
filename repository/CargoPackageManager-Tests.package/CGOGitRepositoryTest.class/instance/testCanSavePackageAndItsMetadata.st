tests
testCanSavePackageAndItsMetadata
	| mcVersion message |
	
	self flag:#todo.
	"This functionality uses old Iceberg API, should be migrated"
	self skip.
	
	repository := self pharoCounterMasterCloned.
	message := 'commit from test #testCanSavePackageAndItsMetadata'.
	mcVersion := repository 
		savePackageUnit: (CGOOngoingPackageUnit for: 'Counter-Core') withMessage: message.
	self 
		assert: mcVersion info message
		equals: message