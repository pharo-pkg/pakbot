initialization
initializePartsWith: aPackageAssembly
	parts := self
		toArrayOrNilIfEmpty:
			(aPackageAssembly parts collect: 
			[ :part | 
			Association 
				key: part targetedPackage
				value: (self dependencyConstraintsMapping: part) ])