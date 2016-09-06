tests
testShouldGetAllCurrentDependenciesOfPackageUnit
	| deps |
	
	deps := CGOPackageDependencyUpdater allCurrentDependenciesOfManifest: ManifestOneDependency.
	
	self 
		assertCollection: deps
		hasSameElements: #(#OneDependency #NoDependency)