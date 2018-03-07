updating
newPackageAssembly: aCGOPackageAssemblyName
	| assembly |
	
	assembly := CGOOngoingPackageAssembly 
		for: aCGOPackageAssemblyName asSymbol
		project: self.
	(assemblies includes: assembly)
		ifTrue: [ CGOPackageAlreadyRegistered signal ].		
	assemblies add: assembly.
	^ registry register: assembly