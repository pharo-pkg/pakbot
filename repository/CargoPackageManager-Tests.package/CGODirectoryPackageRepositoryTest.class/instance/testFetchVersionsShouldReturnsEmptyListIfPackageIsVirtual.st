tests
testFetchVersionsShouldReturnsEmptyListIfPackageIsVirtual
	
	self assert: (greaseRepository versionStringsOf: 'Grease-Slime') isEmpty