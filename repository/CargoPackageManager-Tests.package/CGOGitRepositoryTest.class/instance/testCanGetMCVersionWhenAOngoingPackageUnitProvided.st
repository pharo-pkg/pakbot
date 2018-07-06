tests
testCanGetMCVersionWhenAOngoingPackageUnitProvided
	| result |
	
	self flag:#todo.
	"This functionality uses old Iceberg API, should be migrated"
	self skip.	
	
	repository := self pharoCounterMasterCloned.
	result := repository mcVersionFor: (CGOOngoingPackageUnit for: 'Counter-Core').
	self assert: (result isKindOf: MCVersion)