accessing
defaultVirtualPackageResolutionStrategy
	^ defaultVirtualPackageResolutionStrategy 
		ifNil: [ CGOInteractiveVirtualPackageResolutionStrategy new ]