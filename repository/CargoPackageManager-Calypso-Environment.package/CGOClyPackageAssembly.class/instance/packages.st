accessing
packages
	^ cargoAssembly packageUnitNames collect: 
		[ :unitName | project packageNamed: unitName ]