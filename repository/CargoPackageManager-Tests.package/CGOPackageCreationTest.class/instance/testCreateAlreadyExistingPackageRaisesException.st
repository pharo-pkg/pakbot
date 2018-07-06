tests
testCreateAlreadyExistingPackageRaisesException

	| packageName |
	packageName := 'NewPackage'.
	project createNewPackageNamed: packageName.
	
	self
		should: [project createNewPackageNamed: packageName]
		raise: CGOSystemPackageAlreadyDefined