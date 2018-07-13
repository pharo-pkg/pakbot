querying - Installed
providesProject: aProjectDependency

	^ (self projectName = aProjectDependency name and: [ aProjectDependency satisfyConstraints: self version ])
			and: [ self defaultAssembly isInstalled ]