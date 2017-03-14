updating
addDefaultVersionConstraint: aResolutionStrategy from: repositories for: platformAttributes
	| defaultPackageVersionRef |
	constraints ifNotEmpty: [ ^ self ].
	defaultPackageVersionRef := aResolutionStrategy 
						versionOf: targetedPackage
						in: repositories
						for: platformAttributes.
	defaultPackageVersionRef ifNil: [ CGOPackageNotFoundError signal: targetedPackage ].
	constraints := { CGOFixedVersionConstraint with: defaultPackageVersionRef versionNumber }
