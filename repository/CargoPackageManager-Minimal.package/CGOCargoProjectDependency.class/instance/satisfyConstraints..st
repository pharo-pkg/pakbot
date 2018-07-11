constrains
satisfyConstraints: aSemanticVersion 
	^ constraints allSatisfy: [ :each | each isCompatibleWith: aSemanticVersion ]