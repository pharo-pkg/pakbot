providing
packageNamed: aName
	| packageName |
	packageName := aName asSymbol.
	^ packages 
		at: packageName
		ifAbsent: [ (self fetchFromDb: packageName) ifNil: [ self createPackage: packageName ] ]