running
setUp
	super setUp.
	seaside31PackageVersion := self packageVersions
		detect: [ :each | each packageName = 'Seaside31' ].
	seaside31Dependency := CGOPackageDependency
									on: seaside31PackageVersion package name
									for: nil
									withConstraints: { CGOFixedVersionConstraint with: '3.1' }