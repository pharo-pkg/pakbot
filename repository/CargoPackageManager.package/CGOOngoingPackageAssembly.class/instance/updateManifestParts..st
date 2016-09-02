updating
updateManifestParts: aPackageDependencyList
	self 
		updateMethod: #parts 
		withContent: (aPackageDependencyList collect: #asLiteral) printString