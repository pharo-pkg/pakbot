utility
fixPackageUnitNamesOf: aListOfPackageManifest
	"Iterate on Package manifests to create or fix the package name when possible.
	example: 
		self fixPackageUnitNamesOf: ((AssemblyManifest packageNamed: 'Pharo-Kernel') asOngoingPackageVersion packageUnits collect: #packageManifest)
	"
		
	aListOfPackageManifest do: [ :manifest | | packageName |
		packageName := manifest package packageName.
		((manifest class includesSelector: #packageName) and: [ manifest packageName = packageName ])
			ifFalse: 
				[ self inform: 'Updating ' , packageName, ' manifest'.
				manifest asOngoingPackageVersion updatePackageName: packageName ] ]