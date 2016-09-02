comparing
= other
	(targetedPackage = other targetedPackage) ifFalse: [ ^ false ].
	(constraints = other constraints) ifFalse: [ ^ false ].
	(dependent = other dependent) ifFalse: [ ^ false ].
	^ true