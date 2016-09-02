instance creation
fromString: aString
	| constraintString |
	
	constraintString := aString trim.
	(constraintString first = $=)
		ifTrue: [ ^ CGOFixedVersionConstraint with: (SemanticVersion fromString: constraintString allButFirst ) ]
		ifFalse: [ CGODependencyConstraintFormatError signal ]