tests
testCreateNonExistingPackageSucceeds

	| packageName |
	packageName := 'NewPackage'.
	project createNewPackageNamed: packageName.
	
	self assert: (project hasPackageNamed: packageName)