updating
removePart: aCGOPackageVersion
	registry unregister: aCGOPackageVersion.
	assemblies 
		remove: aCGOPackageVersion
		ifAbsent: [ 	unitNames remove: aCGOPackageVersion packageName ]