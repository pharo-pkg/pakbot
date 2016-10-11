tests
testFetchVersionsShouldReturnAllVersionsIfPackageExists
	self 
		assertCollection: (greaseRepository versionsOf: 'grease-core')
		hasSameElements:  #('grease-core@1.1.12' 'grease-core@1.1.13')