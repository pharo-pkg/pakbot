private
addDefaultVersionConstraintTo: aDependency
	aDependency
		addDefaultVersionConstraint: self defaultVersionStrategy
		from: repositories
		for: Cargo platformAttributes