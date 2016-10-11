as yet unclassified
testFetchVersionsShouldReturnsEmptyListIfPackageIsVirtual
	
	self assert: (greaseRepository versionStringsOf: 'Grease-Slime') isEmpty