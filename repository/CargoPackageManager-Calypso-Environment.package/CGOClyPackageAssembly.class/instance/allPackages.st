accessing
allPackages
	^ cargoAssembly allPackageUnits collect: 
		[ :unit |
			project packageNamed: unit packageName ]