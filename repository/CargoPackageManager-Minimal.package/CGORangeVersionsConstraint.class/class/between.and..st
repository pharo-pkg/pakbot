instance creation
between: lowerSemanticVersion and: upperSemanticVersion
	^ CGORangeVersionsConstraint new 
		initializeWithRangeBetween: lowerSemanticVersion and: upperSemanticVersion;
		yourself.