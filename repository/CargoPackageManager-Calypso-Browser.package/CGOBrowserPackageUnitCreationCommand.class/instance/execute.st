execution
execute
	project newPackageUnit: unitName.
	[ toolContext systemEnvironment packageNamed: unitName ]
		on: KeyNotFound
		do: [ self createSystemPackage ]