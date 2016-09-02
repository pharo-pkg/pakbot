updating - ui
updateDependencyConstraints: aPackageDependency
	| constraintsString constraints |
	constraintsString := UIManager default 
		request: 'Constraints on package ' , aPackageDependency packageName, ':'
		initialAnswer: (Character space join: aPackageDependency constraints).
	constraintsString ifNil: [ ^ self ].
	constraints := ('\s+' asRegex split: constraintsString)
		collect: [:each | CGOFixedVersionConstraint with: each ]
		as: Array.
	self
		updateDependency: (CGOPackageDependency 
			on: aPackageDependency packageName 
			for: aPackageDependency dependent
			withConstraints: constraints)