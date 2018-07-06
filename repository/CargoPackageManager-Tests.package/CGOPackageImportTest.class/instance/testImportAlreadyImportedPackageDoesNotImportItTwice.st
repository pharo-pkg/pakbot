tests
testImportAlreadyImportedPackageDoesNotImportItTwice

	| packageName |
	packageName := 'NewPackage'.
	systemPackageOrganizer createPackageNamed: packageName.
	
	project importPackageNamed: packageName.
	
	[ project importPackageNamed: packageName.
	  self fail ]
		on: CGOPackageAlreadyRegistered
		do: [ :error | "Do nothing, just go on to the next assertion" ].
	
	self assert: project packageUnits size equals: 1