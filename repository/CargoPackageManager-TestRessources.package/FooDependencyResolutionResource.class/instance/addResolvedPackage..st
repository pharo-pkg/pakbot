building
addResolvedPackage: aSelector
	| packageVersion |
	packageVersion := self perform: aSelector.
	(resolution ongoingPackageResolutionFor: packageVersion packageName)
		packageVersion: packageVersion