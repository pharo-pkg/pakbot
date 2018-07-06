tests
testCreateExistingPackageInSystemRaisesException

	| packageName |
	packageName := 'NewPackage'.
	systemPackageOrganizer createPackageNamed: packageName.
	
	self
		should: [project createNewPackageNamed: packageName]
		raise: CGOSystemPackageAlreadyDefined