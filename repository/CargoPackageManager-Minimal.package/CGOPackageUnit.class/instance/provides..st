testing
provides: aVirtualPackageVersionReference
	^ provisions 
		detect: [ :provision | | pkgVersionRef |
			pkgVersionRef := provision asPackageVersionReference.
			(pkgVersionRef packageName = aVirtualPackageVersionReference packageName)
				and: [ aVirtualPackageVersionReference versionNumber 
							ifEmpty: [ true ]
							ifNotEmpty: [ pkgVersionRef versionNumber = aVirtualPackageVersionReference versionNumber ] ] ]
		ifFound: [ true ]
		ifNone: [ false ]