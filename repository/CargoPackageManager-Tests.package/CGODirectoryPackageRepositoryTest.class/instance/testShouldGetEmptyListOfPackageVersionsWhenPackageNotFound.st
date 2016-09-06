tests
testShouldGetEmptyListOfPackageVersionsWhenPackageNotFound
	self 
		assert: (repository versionsOf: 'A')
		equals: #()