accessing
dependencyTargetedPackages
	^ packageVersion dependencies 
		collect: #targetedPackage
		as: Array