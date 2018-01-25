updating
newPackageAssembly: aCGOPackageAssemblyName
	| assembly |
	
	assembly := (CGOOngoingPackageAssembly2 for: aCGOPackageAssemblyName asSymbol project: self).
	assemblies add: assembly.
	^ registry register: assembly