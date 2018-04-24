initialization
initializeFromOngoing: aCGOOngoingProject 
	super initializeFromOngoing: aCGOOngoingProject project: self.
	name := aCGOOngoingProject packageName copy.
	repository := aCGOOngoingProject repository.
	version := aCGOOngoingProject version.
	units := aCGOOngoingProject packageUnits collect: [:each | each asPackageVersionOf: self] as: Array.
	assemblies := aCGOOngoingProject assemblies collect: [:each | each asPackageVersionOf: self] as: Array.
	virtualPackages := aCGOOngoingProject virtualPackages collect: [:each | each asPackageVersionOf: self] as: Array.
	authors := aCGOOngoingProject authors asArray.