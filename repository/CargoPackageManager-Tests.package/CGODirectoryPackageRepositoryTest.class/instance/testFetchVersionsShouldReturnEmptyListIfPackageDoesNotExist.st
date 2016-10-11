tests
testFetchVersionsShouldReturnEmptyListIfPackageDoesNotExist

	self assert: (greaseRepository versionsOf: 'Unexistent') equals: #()