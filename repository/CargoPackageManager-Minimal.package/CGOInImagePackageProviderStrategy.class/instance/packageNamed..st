providing
packageNamed: aName
	^ packages
		at: aName asSymbol
		ifAbsent: [ self createPackage: aName ]