accessing
packages
	^ cargoAssembly packageUnits collect: 
		[ :unit | project packageNamed: unit packageName ]