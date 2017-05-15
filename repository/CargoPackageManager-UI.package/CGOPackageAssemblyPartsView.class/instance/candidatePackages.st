querying
candidatePackages
	| partsNames |
	partsNames := (ongoingPackageVersion parts collect: #targetedPackage) copyWith: ongoingPackageVersion packageName.
	^ (ongoingPackageVersion project packages 
		reject: [ :packageVersion |	partsNames includes: packageVersion packageName  ]) asArray