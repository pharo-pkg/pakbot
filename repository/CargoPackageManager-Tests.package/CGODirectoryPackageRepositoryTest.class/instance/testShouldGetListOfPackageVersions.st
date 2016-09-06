tests
testShouldGetListOfPackageVersions
	self 
		assertCollection: (repository versionsOf: 'Grease-Core')
		hasSameElements:  #('Grease-Core@1.1.12' 'Grease-Core@1.1.13')