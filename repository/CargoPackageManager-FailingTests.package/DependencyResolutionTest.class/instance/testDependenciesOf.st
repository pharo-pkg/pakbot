tests
testDependenciesOf
	| resolvedDependency children |
	
	resolvedDependency :=  protocol mock: 'resolvedDependency'.
	protocol describe
		once: resolvedDependency recv: #dependencyTargetedPackages;
		=> { #foo . #bar }.
	resolution ongoingPackageResolutionFor: #foo.
	resolution ongoingPackageResolutionFor: #bar.
	
	children := resolution dependenciesOf: resolvedDependency.
	self
		assert: children size
		equals: 2.
	self
		assert: (children at: 2) targetedPackage
		equals: #bar