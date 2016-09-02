private
addConstraintsFrom: aDependency
	aDependency constraints
		ifEmpty: [ self addDefaultVersionConstraintTo: aDependency ].
	aDependency constraints
		do: [ :constraint |
			self 
				addConstraint: constraint
				on: aDependency targetedPackage ]