tests-accessing
testCanCreateDependencyFromScopedPackage
	| dependency |
	dependency := CGOPackageDependency on: #Project::Package.
	
	self 
		assert: dependency targetedPackage 
		equals: 'Package'.
	self 
		assert: dependency scope
		equals: 'Project'