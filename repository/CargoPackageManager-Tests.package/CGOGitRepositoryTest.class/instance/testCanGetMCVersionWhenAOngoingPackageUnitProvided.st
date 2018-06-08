tests
testCanGetMCVersionWhenAOngoingPackageUnitProvided
	| repo result |
	repo := self pharoCounterMasterCloned.
	result := repo mcVersionFor: (CGOOngoingPackageUnit for: 'Counter-Core').
	self assert: (result isKindOf: MCVersion)