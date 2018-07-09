accessing
dependencyTargetedPackages
	^ packageVersion dependencies 
		collect: #dependencyName
		as: Array