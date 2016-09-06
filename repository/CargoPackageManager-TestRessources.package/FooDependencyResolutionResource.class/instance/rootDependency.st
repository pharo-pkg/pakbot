building
rootDependency
	^ CGOPackageDependency 
		on: self fooPackage packageName
		for: nil
		withConstraints: { CGOFixedVersionConstraint with: '1.0' }