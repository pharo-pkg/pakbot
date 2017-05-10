accessing
packages
	^ cargoAssembly parts collect: 
		[ :dependency |
			project packageNamed: dependency packageName ]