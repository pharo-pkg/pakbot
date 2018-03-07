removing
removePart: aCGOPackageVersion
	registry unregister: aCGOPackageVersion.
	assemblies 
		remove: aCGOPackageVersion
		ifAbsent: [ 	units remove: aCGOPackageVersion ]