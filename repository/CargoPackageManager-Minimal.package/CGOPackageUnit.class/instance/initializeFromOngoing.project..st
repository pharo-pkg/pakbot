initialization
initializeFromOngoing: aCGOOngoingPackageUnit project: aCGOProject
	super initializeFromOngoing: aCGOOngoingPackageUnit project: aCGOProject.
	self flag: 'todo'.
	dependencies.
	platformRequirements.
	provisions.