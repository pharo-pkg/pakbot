tests-accessing
testCanCreateDependencyFromNonScopedPackage
	| dependency |
	dependency := CGOPackageDependency on: #Package.
	
	self 
		assert: dependency targetedPackage 
		equals: 'Package'.
	self assert: dependency scope isNil