initializing
initializeWithRangeBetween: lowerSemanticVersion and: upperSemanticVersion
	super initialize.
	minVersion := lowerSemanticVersion asSemanticVersion.
	maxVersion := upperSemanticVersion asSemanticVersion