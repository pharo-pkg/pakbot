tests-version comparison
testPatchDependencyNumberShouldSemanticVersionEquivalent

	| dependency |
	dependency := CGOPackageDependency newFrom: #A -> #('=1.1.1').
	
	self assert: dependency constraints first version equals: '1.1.1' asSemanticVersion.