updating
addDefaultVersionConstraint: aResolutionStrategy from: repositories for: platformAttributes
	| defaultPackageVersionRef |
	constraints ifNotEmpty: [ ^ self ].
	defaultPackageVersionRef := aResolutionStrategy 
						versionOf: self
						in: repositories
						forEnvironment: platformAttributes.
	defaultPackageVersionRef ifNil: [ CGOPackageNotFoundError signal: targetedPackage ].
	constraints := { CGOFixedVersionConstraint with: defaultPackageVersionRef versionString }
