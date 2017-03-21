private
latestVersionOfVirtualPackage: aVirtualPackageName suitableForEnvironment: platformAttributes
	"Virtual packages DO NOT support platform attributes at this time. So, platformAttributes argument is just ignored"
	| pkgVersionRef |
	pkgVersionRef := ((self versionStringsOfVirtual: aVirtualPackageName) collect: #asPackageVersionReference)
		detectMax: #versionNumber.
	^ self fetchVirtual: pkgVersionRef packageName version: pkgVersionRef versionNumber asString