providing
virtualPackageNamed: aName
	^ packages
		at: aName asSymbol
		ifPresent: [ :package |
						package isVirtual
							ifTrue: [ package ]
							ifFalse: [ self error: aName , ' is not a virtual package!'] ]
		ifAbsent: [ self createVirtualPackage: aName ]