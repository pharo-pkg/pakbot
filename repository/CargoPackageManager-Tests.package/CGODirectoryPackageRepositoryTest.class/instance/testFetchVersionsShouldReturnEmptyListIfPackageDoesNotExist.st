tests
testFetchVersionsShouldReturnEmptyListIfPackageDoesNotExist

	self assert: (greaseRepository versionStringsOf: 'Unexistent') equals: #()