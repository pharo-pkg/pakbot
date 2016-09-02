versions fetching
fetch: aPackageVersionString
	| pkgVersionRef |

	pkgVersionRef := aPackageVersionString asPackageVersionReference.
	^ self 
		fetch: pkgVersionRef packageName
		version: pkgVersionRef versionNumber.