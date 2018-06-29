building
buildAndRegisterIn: aCGOPackageRegistry
	registry := aCGOPackageRegistry.
	self buildProject.
	self buildExternalProjectDependencies.
	self buildPackages.
	^ project