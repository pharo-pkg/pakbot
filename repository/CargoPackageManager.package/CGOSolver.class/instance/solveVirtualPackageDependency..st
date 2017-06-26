private
solveVirtualPackageDependency: aDependency
	| packageName candidates |
	
	packageName := aDependency targetedPackage.
	candidates := repositories flatCollect: [ :repository |
		repository
			packagesProviding: packageName
			version: (self versionFor: packageName)
			forEnvironment: Cargo imageEnvironment ].
	
	candidates ifEmpty: [ CGOUnresolvedDependency signal: 'Cannot find ' , packageName , ' virtual package!' ].

	^ self defaultVirtualPackageResolutionStrategy  
		solve: aDependency 
		candidates: candidates