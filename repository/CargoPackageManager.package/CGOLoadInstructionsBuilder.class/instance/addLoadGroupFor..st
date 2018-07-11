loading order
addLoadGroupFor: resolvedDependencies
	| packageVersions |
	packageVersions := ( resolvedDependencies 
		collect: #resolvedProjectVersion
		thenReject: [ :pkgVersion | resolution isAlreadyInstalled: pkgVersion ] ) asArray.
	packageVersions 
		ifNotEmpty: [ loadInstructions addGroup: (CGOPackageLoadGroup newWithAll: packageVersions) ]