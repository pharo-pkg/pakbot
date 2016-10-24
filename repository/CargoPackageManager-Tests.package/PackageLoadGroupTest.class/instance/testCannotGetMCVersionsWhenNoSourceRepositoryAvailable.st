tests-loading
testCannotGetMCVersionsWhenNoSourceRepositoryAvailable
	| pkgLoadGroup |
	pkgLoadGroup := GreaseTestResource current loadInstructions groups first.
	pkgLoadGroup packageVersions first sourceRepository 
		instVarNamed: 'repositoryUrl' 
		put: nil.

	self 
		should: [ pkgLoadGroup mcVersions ]
		raise: MCRepositoryError
