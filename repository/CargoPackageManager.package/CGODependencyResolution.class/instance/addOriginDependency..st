adding
addOriginDependency: aDependency
	rootDependency ifNil: [ rootDependency := aDependency ].
	(self ongoingPackageResolutionFor: aDependency name)
		addOriginDependency: aDependency