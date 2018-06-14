initialization
initializeWith: anAssociation 
	| constraintStringList |
	self initializeTargetAndScopeFrom: anAssociation key asSymbol.
	constraintStringList := anAssociation value.
	constraints := constraintStringList collect: 
		[ :constraintString | CGODependencyConstraint fromString: constraintString  ]