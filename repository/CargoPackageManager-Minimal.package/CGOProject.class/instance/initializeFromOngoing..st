initialization
initializeFromOngoing: aCGOOngoingProject 
	name := aCGOOngoingProject name.
	description := aCGOOngoingProject description.
	repository := aCGOOngoingProject repository.
	version := aCGOOngoingProject version.
	unitNames := aCGOOngoingProject packageUnitNames asArray.
	assemblies := aCGOOngoingProject assemblies collect: #asPackageVersion as: Array.
	authors := aCGOOngoingProject authors asArray.