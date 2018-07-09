tests
testImportAlreadyImportedPackageRaisesException

	| packageName |
	packageName := 'NewPackage'.
	systemPackageOrganizer createPackageNamed: packageName.
	
	project importPackageNamed: packageName.
	self
		should: [ project importPackageNamed: packageName ]
		raise: CGOPackageAlreadyRegistered