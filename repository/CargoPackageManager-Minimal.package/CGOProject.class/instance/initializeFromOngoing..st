initialization
initializeFromOngoing: aCGOOngoingProject 
	name := aCGOOngoingProject packageName.
	description := aCGOOngoingProject description.
	repository := aCGOOngoingProject repository.
	version := aCGOOngoingProject version.
	unitNames := aCGOOngoingProject packageUnitNames asArray.
	assemblies := aCGOOngoingProject assemblies collect: #asPackageVersion as: Array.
	virtualPackages := aCGOOngoingProject virtualPackages collect: #asPackageVersion as: Array.
	authors := aCGOOngoingProject authors asArray.