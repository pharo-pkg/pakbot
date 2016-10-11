tests-creation
testCreateDependencyFromExactMajorDependencyNumberShouldHaveFixedVersionConstraint

	| dependency |
	dependency := CGOPackageDependency newFrom: #A -> #('=1').
	
	self assert: dependency constraints first isFixed