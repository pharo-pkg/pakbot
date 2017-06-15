testing
provides: aVirtualPackageVersionReference
	^ provisions 
		detect: [ :provision | | pkgVersionRef |
			pkgVersionRef := provision asPackageVersionReference.
			(pkgVersionRef packageName = aVirtualPackageVersionReference packageName)
				and: [ aVirtualPackageVersionReference versionString
							ifEmpty: [ true ]
							ifNotEmpty: [ pkgVersionRef versionString = aVirtualPackageVersionReference versionString ] ] ]
		ifFound: [ true ]
		ifNone: [ false ]