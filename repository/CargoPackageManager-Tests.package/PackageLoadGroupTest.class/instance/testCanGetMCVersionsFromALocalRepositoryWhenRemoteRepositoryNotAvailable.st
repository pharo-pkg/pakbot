tests-loading
testCanGetMCVersionsFromALocalRepositoryWhenRemoteRepositoryNotAvailable
	| pkgLoadGroup mcVersions |
	pkgLoadGroup := GreaseTestResource current loadInstructions groups first.
	mcVersions := pkgLoadGroup mcVersions.
		
	self	
		assert: (mcVersions anySatisfy: [:each | each isKindOf: MCVersion]).
	self	
		assert: mcVersions size
		equals: 1.
	self	
		assert: mcVersions first info name
		equals: 'Grease-Core-JohanBrichau.94'.