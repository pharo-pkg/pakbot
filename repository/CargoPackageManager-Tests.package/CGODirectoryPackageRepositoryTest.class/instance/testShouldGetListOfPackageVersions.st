tests
testShouldGetListOfPackageVersions
	self 
		assertCollection: (repository versionsOf: 'grease-core')
		hasSameElements:  #('grease-core@1.1.12' 'grease-core@1.1.13')