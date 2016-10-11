tests
testFetchVersionsShouldReturnsEmptyListIfPackageIsVirtual
	
	self assert: (greaseRepository versionsOf: 'Grease-Slime') isEmpty