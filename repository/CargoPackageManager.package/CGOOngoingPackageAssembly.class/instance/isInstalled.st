querying - installed
isInstalled
	
	^ (self parts collect: #asPackageDependency) allSatisfy: #isInstalled