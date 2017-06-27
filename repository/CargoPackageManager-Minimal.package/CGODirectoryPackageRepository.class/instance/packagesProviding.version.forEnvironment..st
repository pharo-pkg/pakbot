versions fetching
packagesProviding: aVirtualPackageName version: aSemanticVersion forEnvironment: platformAttributes
	^ (self packageVersionNamesProviding: aVirtualPackageName version: aSemanticVersion)
		collect: [ :packageVersionName | | pkgVersionRef |
			pkgVersionRef := packageVersionName asPackageVersionReference.
			self 
				fetch: pkgVersionRef packageName
				version: pkgVersionRef versionNumber ]
		thenSelect: [ :unit |
			self does: unit fitPlatformRequirements: platformAttributes ]