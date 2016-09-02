adding
addOriginDependency: aDependency
	rootDependency ifNil: [ rootDependency := aDependency ].
	(self ongoingPackageResolutionFor: aDependency targetedPackage)
		addOriginDependency: aDependency