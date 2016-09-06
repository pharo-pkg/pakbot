providing
virtualPackageNamed: aName
	| package packageName |
	packageName := aName asSymbol.
	package := packages
		at: packageName
		ifAbsent: [ (self fetchFromDb: packageName) ifNil: [ self createVirtualPackage: packageName ] ].
	^ package isVirtual
		ifTrue: [ package ]
		ifFalse: [ self error: aName , ' is not a virtual package!']