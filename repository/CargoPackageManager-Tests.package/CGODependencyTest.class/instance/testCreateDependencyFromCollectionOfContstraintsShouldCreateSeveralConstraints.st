tests-creation
testCreateDependencyFromCollectionOfContstraintsShouldCreateSeveralConstraints

	| dependency |
	dependency := CGOPackageDependency newFrom: #A -> #('=1.1.1' '=1.1.2' '=1.1.3').
	self assert: dependency constraints size equals: 3