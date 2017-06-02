accessing
defaultPackageVersionStrategy
	^ defaultPackageVersionStrategy ifNil: [ CGOBleedingEdgeResolutionStrategy new ]