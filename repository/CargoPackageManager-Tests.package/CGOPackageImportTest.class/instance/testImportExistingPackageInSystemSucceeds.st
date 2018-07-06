tests
testImportExistingPackageInSystemSucceeds

	| packageName |
	packageName := 'NewPackage'.
	systemPackageOrganizer createPackageNamed: packageName.
	project importPackageNamed: packageName.
	
	self assert: (project hasPackageNamed: packageName)