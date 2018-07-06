tests
testImportNonExistingPackageInSystemRaisesException

	| packageName |
	packageName := 'NewPackage'.
	project createNewPackageNamed: packageName.
	
	self
		should: [project createNewPackageNamed: packageName]
		raise: CGOSystemPackageAlreadyDefined