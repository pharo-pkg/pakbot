tests
testCanGetMCVersionWhenAOngoingPackageUnitProvided
	| repo result |
	repo := self pharoCounterMaster.
	result := repo mcVersionFor: (CGOOngoingPackageUnit2 for: 'Counter-Core').
	self assert: (result isKindOf: MCVersion)