initialization
initializeWith: anAssociation 
	| constraintStringList |
	targetedPackage := anAssociation key asSymbol.
	constraintStringList := anAssociation value.
	constraints := constraintStringList collect: 
		[ :constraintString | CGODependencyConstraint fromString: constraintString  ]