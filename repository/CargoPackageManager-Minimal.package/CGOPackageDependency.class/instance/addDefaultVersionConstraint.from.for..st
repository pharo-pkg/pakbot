updating
addDefaultVersionConstraint: aResolutionStrategy from: repositories for: platformAttributes
	| defaultPackageVersionRef |
	constraints ifNotEmpty: [ ^ self ].
	defaultPackageVersionRef := aResolutionStrategy 
						versionOf: targetedPackage
						in: repositories
						for: platformAttributes.
	defaultPackageVersionRef ifNil: [ CGOPackageNotFoundError signal: 'Cannot find ' , targetedPackage , ' package' ].
	constraints := { CGOFixedVersionConstraint with: defaultPackageVersionRef versionNumber }
