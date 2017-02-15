versions fetching
packagesProviding: aVirtualPackageName version: aSemanticVersion forPlatformAttributes: platformAttributes
	^ (self packageVersionNamesProviding: aVirtualPackageName version: aSemanticVersion)
		collect: [ :packageVersionName | | pkgVersionRef |
			pkgVersionRef := packageVersionName asPackageVersionReference.
			self 
				fetch: pkgVersionRef packageName
				version: pkgVersionRef versionNumber asSemanticVersion  ]
		thenSelect: [ :unit |
			unit platformRequirements includesAny: platformAttributes ]