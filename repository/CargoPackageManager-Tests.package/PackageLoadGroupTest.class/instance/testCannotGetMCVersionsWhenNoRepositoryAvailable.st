tests-loading
testCannotGetMCVersionsWhenNoRepositoryAvailable
	| pkgLoadGroup repositoryMock |
	pkgLoadGroup := GreaseTestResource current loadInstructions groups first.
	repositoryMock := protocol mock: 'MCRepository'.
	protocol describe 
		once: repositoryMock recv: #versionFrom:;
		signals: MCRepositoryError.
	pkgLoadGroup addRepository: repositoryMock. 

	self 
		should: [ pkgLoadGroup mcVersions ]
		raise: MCRepositoryError
