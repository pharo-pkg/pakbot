private
addDefaultVersionConstraintTo: aDependency
	aDependency
		addDefaultVersionConstraint: self defaultPackageVersionStrategy
		from: repositories
		for: Cargo imageEnvironment