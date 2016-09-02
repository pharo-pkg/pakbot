protocol
dependentPackages
	^ CGOPackageRegistry default installedPackages
		collect: [ :aPackage | aPackage dependencies
								select: [ : aDependency | aDependency targetedPackage = self ] ]