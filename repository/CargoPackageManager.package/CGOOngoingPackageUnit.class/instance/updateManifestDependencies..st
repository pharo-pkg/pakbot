updating
updateManifestDependencies: aPackageDependencyList
	self 
		updateMethod: #dependencies 
		withContent: (aPackageDependencyList collect: #asLiteral) printString