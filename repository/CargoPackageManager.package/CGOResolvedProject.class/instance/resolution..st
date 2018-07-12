resolution
resolution: aPackageVersionReference
	| pkgVersion |
	pkgVersion := aPackageVersionReference.
	pkgVersion fitsPlatformRequirements
			ifTrue: [ resolvedProjectVersion := pkgVersion ]
			ifFalse: [ CGODependencyRequirementsUnmet signal ]