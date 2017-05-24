querying
candidatePackages
	| partsNames |
	partsNames := (ongoingPackageVersion parts collect: #targetedPackage) copyWith: ongoingPackageVersion packageName.
	^ (ongoingPackageVersion registry installedPackages
		reject: [ :packageVersion |	partsNames includes: packageVersion packageName  ]) asArray