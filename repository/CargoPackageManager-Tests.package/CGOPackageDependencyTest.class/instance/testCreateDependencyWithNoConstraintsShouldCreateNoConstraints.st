tests-creation
testCreateDependencyWithNoConstraintsShouldCreateNoConstraints
	| dependency |
	dependency := CGOPackageDependency newFrom: #A -> #().
	
	self assert: dependency constraints isEmpty