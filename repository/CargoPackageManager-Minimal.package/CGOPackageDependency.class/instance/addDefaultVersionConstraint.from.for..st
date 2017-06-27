updating
addDefaultVersionConstraint: aResolutionStrategy from: repositories for: platformAttributes
	| defaultPackageVersionRef |
	constraints ifNotEmpty: [ ^ self ].
	defaultPackageVersionRef := aResolutionStrategy 
						versionOf: targetedPackage
						in: repositories
						forEnvironment: platformAttributes.
	defaultPackageVersionRef ifNil: [ CGOPackageNotFoundError signal: targetedPackage ].
	constraints := { CGOFixedVersionConstraint with: defaultPackageVersionRef versionString }
