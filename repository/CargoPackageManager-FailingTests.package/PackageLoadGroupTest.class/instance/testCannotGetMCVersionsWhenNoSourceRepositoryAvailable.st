tests-loading
testCannotGetMCVersionsWhenNoSourceRepositoryAvailable
	| pkgLoadGroup |
	pkgLoadGroup := GreaseTestResource current loadInstructions groups first.
	pkgLoadGroup packageVersions first sourcePackageVersion
		instVarNamed: 'repository' 
		put: nil.

	self 
		should: [ pkgLoadGroup mcVersions ]
		raise: MCRepositoryError
