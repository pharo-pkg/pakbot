loading order
addLoadGroupFor: resolvedDependencies
	| packageGroup |
	packageGroup := CGOPackageLoadGroup newWithAll: 
		(resolvedDependencies collect: #packageVersion as: Array).
	loadInstructions addGroup: packageGroup