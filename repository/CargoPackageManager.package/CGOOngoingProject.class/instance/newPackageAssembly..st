updating
newPackageAssembly: aCGOPackageAssemblyName
	| assembly |
	
	assembly := (CGOOngoingPackageAssembly for: aCGOPackageAssemblyName asSymbol in: name).
	assemblies add: assembly.
	^ CGOPackageRegistry default register: assembly