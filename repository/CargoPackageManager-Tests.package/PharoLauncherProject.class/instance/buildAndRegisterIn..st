instance creation
buildAndRegisterIn: aCGOPackageRegistry
	registry := aCGOPackageRegistry.
	self
		buildProject;
		buildExternalProjectDependencies;
		buildPackages.
	^ project