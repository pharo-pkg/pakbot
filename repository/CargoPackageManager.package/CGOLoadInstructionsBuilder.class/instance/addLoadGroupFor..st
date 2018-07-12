loading order
addLoadGroupFor: resolvedDependencies
	| packageVersions |

	packageVersions := ( resolvedDependencies
		collect: [ :each | each resolution]
		thenReject: [ :each | each isInstalled ] ) asArray.
	packageVersions 
		ifNotEmpty: [ loadInstructions addGroup: (CGOPackageLoadGroup newWithAll: packageVersions) ]