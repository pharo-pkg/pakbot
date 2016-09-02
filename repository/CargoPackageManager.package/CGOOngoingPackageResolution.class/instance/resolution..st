resolution
resolution: aPackageVersionReference
	| pkgVersion |
	pkgVersion := aPackageVersionReference asPackageVersion.
	pkgVersion fitsPlatformRequirements
			ifTrue: [ packageVersion := pkgVersion ]
			ifFalse: [ CGODependencyRequirementsUnmet signal ]