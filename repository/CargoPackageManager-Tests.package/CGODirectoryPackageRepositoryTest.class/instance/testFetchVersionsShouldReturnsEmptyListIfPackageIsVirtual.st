as yet unclassified
testFetchVersionsShouldReturnsEmptyListIfPackageIsVirtual
	
	self assert: (greaseRepository versionsOf: 'Grease-Slime') isEmpty