resolution
resolution: aPackageVersionReference
	| pkgVersion |
	pkgVersion := aPackageVersionReference.
	pkgVersion fitsPlatformRequirements
			ifTrue: [ packageVersion := pkgVersion ]
			ifFalse: [ CGODependencyRequirementsUnmet signal ]