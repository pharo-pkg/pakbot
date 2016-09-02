accessing
defaultVersionStrategy
	^ defaultVersionStrategy ifNil: [ CGOBleedingEdgeResolutionStrategy new ]