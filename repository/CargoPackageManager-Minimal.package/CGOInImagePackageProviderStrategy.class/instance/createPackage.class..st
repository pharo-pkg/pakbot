private - instance creation
createPackage: aName class: packageClass
	^ packages 
		at: aName asSymbol
		put: (packageClass newNamed: aName)