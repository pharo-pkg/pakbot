protocol
resolvedPackageFor: aDependency
	| packageName ongoingPackageResolution packageVersionRef |
	
	packageName := aDependency targetedPackage.
	ongoingPackageResolution := resolution ongoingPackageResolutionFor: packageName.
	packageVersionRef := (self isVirtual: packageName)
		ifTrue: [ | pkgVersionString | 
				pkgVersionString := self solveVirtualPackageDependency: aDependency.
				CGOPackageVersionReference newOn: pkgVersionString ]
		ifFalse: 
			[ CGOPackageVersionReference new
				initializeWithName: packageName
				version: (self versionFor: packageName) asString;
				yourself ].
	packageVersionRef packageRepositories: repositories.
	ongoingPackageResolution resolution: packageVersionRef.
	^ ongoingPackageResolution