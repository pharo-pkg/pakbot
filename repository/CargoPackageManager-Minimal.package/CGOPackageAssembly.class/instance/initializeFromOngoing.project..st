initialization
initializeFromOngoing: aCGOOngoingPackageAssembly project: aCGOProject
	super initializeFromOngoing: aCGOOngoingPackageAssembly project: aCGOProject.
	parts := aCGOOngoingPackageAssembly parts deepCopy.