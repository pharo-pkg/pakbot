accessing
packageUnitsOf: anAssembly
	"List package units of the given assembly"
	^ (anAssembly asOngoingPackageVersion packageUnits collect: #packageManifest) 
			collect: #packageName 
			as: Array