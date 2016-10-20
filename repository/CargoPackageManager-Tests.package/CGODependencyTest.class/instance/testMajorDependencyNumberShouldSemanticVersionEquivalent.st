tests-version comparison
testMajorDependencyNumberShouldSemanticVersionEquivalent

	| dependency |
	dependency := CGOPackageDependency newFrom: #A -> #('=1').
	
	self assert: dependency constraints first version equals: '1.0.0' asSemanticVersion.