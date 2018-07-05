tests
testCanCreateNewPackageUnit
	| unit |
	unit := (ongoingProject  newPackageUnit: #Unit)
		description: 'A dummy package unit';
		addDependencyOn: #'Counter-Core';
		yourself.
		
	self
		assert: unit class
		equals: CGOOngoingPackageUnit.
		
	self
		assert: unit packageName
		equals: #Unit